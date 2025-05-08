import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

    const initializationSettingsAndroid =AndroidInitializationSettings('app_icon.png');
    //Todo : Add iOS settings

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationPlugin.initialize(
      initializationSettings
    );
  }
  static void showLocalNotification({required int id, required String? title, required String? body, String? data}) async {
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
      //TODO : Add iOS settings
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
}
