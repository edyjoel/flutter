part of 'notifications_bloc.dart';

sealed class NotificationsEvent {
  const NotificationsEvent();
}

class NotificationStatusChanged extends NotificationsEvent {
  final AuthorizationStatus authorizationStatus;

  const NotificationStatusChanged(this.authorizationStatus);
}

class NotificationReceived extends NotificationsEvent {
  final PushMessage pushMessage;

  const NotificationReceived(this.pushMessage);
}
