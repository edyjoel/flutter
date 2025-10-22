import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_app/config/router/app_router.dart';

class LocalNotifications {
  static Future<void> requestPermissionLocalNotifications() async {
    final flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestPermission();
  }

  static Future<void> initializeLocalNotifications() async {
    final flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid = AndroidInitializationSettings(
      'app_icon',
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    // Crear canal de notificación para Android
    const androidChannel = AndroidNotificationChannel(
      'high_importance_channel', // ID único del canal
      'Notificaciones Importantes', // Nombre visible para el usuario
      description: 'Este canal se usa para notificaciones importantes',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      showBadge: true,
    );

    final androidImplementation = flutterLocalNotificationPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidImplementation?.createNotificationChannel(androidChannel);

    print('✅ Canal de notificaciones creado: ${androidChannel.id}');
  }

  static void showLocalNotification({
    required int id,
    String? title,
    String? body,
    String? data,
  }) {
    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel', // Debe coincidir con el ID del canal creado
      'Notificaciones Importantes',
      channelDescription: 'Este canal se usa para notificaciones importantes',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
      enableLights: true,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    print('📢 Mostrando notificación local: $title');

    flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: data,
    );
  }

  static void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) {
    appRouter.push('/push-details/${notificationResponse.payload}');
  }
}

extension on AndroidFlutterLocalNotificationsPlugin? {
  void requestPermission() {}
}
