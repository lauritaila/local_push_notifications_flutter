// import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsState());

  // @override
  // Stream<NotificationsState> mapEventToState(
  //   NotificationsEvent event,
  // ) async* {
  //   // TODO: implement mapEventToState
  // }
}
