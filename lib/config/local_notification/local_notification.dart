import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_push_notifications_flutter/config/router/app_router.dart';

class LocalNotification {
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true,
  );

  static Future<void> requestLocalNotificationPermission() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  static Future<void> initializeLocalNotification() async {
    final flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid = AndroidInitializationSettings(
      'app_icon.png',
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  static void showLocalNotification({
    required int id,
    String? title,
    String? body,
    String? data,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'channel id',
      'channel name',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(
      android: androidDetails,
    );
    final flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();

    return flutterLocalNotificationPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: data,
    );
  }

  static void onDidReceiveNotificationResponse(NotificationResponse response) {
    appRouter.push('/push-details/${response.payload}');
  }
}
