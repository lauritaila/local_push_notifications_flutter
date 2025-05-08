import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:local_push_notifications_flutter/config/router/app_router.dart';
import 'package:local_push_notifications_flutter/config/theme/app_theme.dart';

import 'package:local_push_notifications_flutter/config/local_notification/local_notification.dart';
import 'package:local_push_notifications_flutter/presentation/blocs/notifications/notifications_bloc.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await NotificationsBloc.initializeFCM();
  await LocalNotification.initializeLocalNotification();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => NotificationsBloc())
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(),
      builder: (context, child) => _HandleNotificationInteractions(child: child!)
    );
  }
}

class _HandleNotificationInteractions extends StatefulWidget {
  final Widget child;
  const _HandleNotificationInteractions({required this.child});

  @override
  State<_HandleNotificationInteractions> createState() => _HandleNotificationInteractionsState();
}

class _HandleNotificationInteractionsState extends State<_HandleNotificationInteractions> {

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }
  
  void _handleMessage(RemoteMessage message) {
    context.read<NotificationsBloc>().handleRemoteMessage(message);
    final messageId = message.messageId?.replaceAll(":", "").replaceAll("%", "");
    appRouter.push('/push-details/$messageId');
  }

  
  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
  }


  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
