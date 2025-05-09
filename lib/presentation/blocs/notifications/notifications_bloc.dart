// import 'dart:async';

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:equatable/equatable.dart';
import 'package:local_push_notifications_flutter/domain/entities/push_messages.dart';
import 'package:local_push_notifications_flutter/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  int pushNumberId = 0;
  final Future<void> Function()? requestLocalNotificationPermission;
  final void Function({
    required int id,
    String? title,
    String? body,
    String? data,
  })?
  showLocalNotification;

  NotificationsBloc({
    this.showLocalNotification,
    this.requestLocalNotificationPermission,
  }) : super(NotificationsState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);
    on<NotificationReceived>(_onPushMessageReceived);

    //verify permission
    _initialStatusCheck();
    //listen to foreground messages
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
    emit(state.copyWith(status: event.status));
    _getFCMToken();
  }

  void _onPushMessageReceived(
    NotificationReceived event,
    Emitter<NotificationsState> emit,
  ) {
    emit(
      state.copyWith(notifications: [event.message, ...state.notifications]),
    );
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationStatusChanged(settings.authorizationStatus));
    _getFCMToken();
  }

  void _getFCMToken() async {
    if (state.status != AuthorizationStatus.authorized) return;
    final token = await messaging.getToken();
    print(token);
  }

  void handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;
    final notification = PushMessage(
      messageId:
          message.messageId?.replaceAll(":", '').replaceAll("%", "") ?? '',
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      sendDate: message.sentTime ?? DateTime.now(),
      data: message.data,
      imageUrl:
          Platform.isIOS
              ? message.notification?.apple?.imageUrl
              : message.notification?.android?.imageUrl,
    );

    if (showLocalNotification == null) {
      showLocalNotification!(
        id: ++pushNumberId,
        title: notification.title,
        body: notification.body,
        data: notification.data.toString(), // notification.data,
      );
    }

    add(NotificationReceived(notification));
  }

  void _onForegroundMessage() async {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    if (requestLocalNotificationPermission != null) {
      await requestLocalNotificationPermission!();
    }

    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  PushMessage? getMessageById(String id) {
    final exist = state.notifications.any((message) => message.messageId == id);
    if (!exist) return null;
    return state.notifications.firstWhere((message) => message.messageId == id);
  }
}
