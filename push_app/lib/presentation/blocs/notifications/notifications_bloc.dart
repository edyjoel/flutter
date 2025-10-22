import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_app/config/local_notifications/local_notifications.dart';
import 'package:push_app/domain/entities/push_message.dart';
import 'package:push_app/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message: ${message.messageId}');
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final Future<void> Function()? requestLocalNotificationPermissions;
  final void Function({
    required int id,
    String? title,
    String? body,
    String? data,
  })?
  showLocalNotification;

  NotificationsBloc({
    this.requestLocalNotificationPermissions,
    this.showLocalNotification,
  }) : super(NotificationsState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);
    on<NotificationReceived>(_onPushMessageReceived);

    _initialStatusCheck();
    _onForegroundMessage();
  }

  static Future<void> initializeFCM() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void _notificationStatusChanged(
    NotificationStatusChanged event,
    Emitter<NotificationsState> emit,
  ) {
    emit(state.copyWith(authorizationStatus: event.authorizationStatus));
    _getFCMToken();
  }

  void _initialStatusCheck() async {
    NotificationSettings settings = await messaging.getNotificationSettings();
    add(NotificationStatusChanged(settings.authorizationStatus));
    _getFCMToken();
  }

  void _getFCMToken() async {
    if (state.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await messaging.getToken();
      print("FCM Token: $token");
    }
  }

  void handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;

    final notification = PushMessage(
      messageId:
          message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      sentDate: message.sentTime ?? DateTime.now(),
      data: message.data,
      imageUrl: Platform.isAndroid
          ? message.notification?.android?.imageUrl
          : message.notification?.apple?.imageUrl,
    );

    if (showLocalNotification != null) {
      showLocalNotification!(
        id: notification.messageId.hashCode,
        title: notification.title,
        body: notification.body,
        data: notification.messageId,
      );
    }

    add(NotificationReceived(notification));
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void _onPushMessageReceived(
    NotificationReceived event,
    Emitter<NotificationsState> emit,
  ) {
    final updatedNotifications = List<PushMessage>.from(state.notifications)
      ..add(event.pushMessage);
    emit(state.copyWith(notifications: updatedNotifications));
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (requestLocalNotificationPermissions != null) {
      await requestLocalNotificationPermissions!();
    }

    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  PushMessage? getMessageById(String messageId) {
    final exist = state.notifications.any(
      (element) => element.messageId == messageId,
    );
    if (!exist) return null;

    return state.notifications.firstWhere(
      (element) => element.messageId == messageId,
    );
  }
}
