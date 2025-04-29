// import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:equatable/equatable.dart';
import 'package:local_push_notifications_flutter/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(NotificationsState());

  // @override
  // Stream<NotificationsState> mapEventToState(
  //   NotificationsEvent event,
  // ) async* {
  //   // TODO: implement mapEventToState
  // }

  static Future<void> initializeFCM() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
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

    settings.authorizationStatus;

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    }
  }
}
