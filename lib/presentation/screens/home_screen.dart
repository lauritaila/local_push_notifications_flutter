import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_push_notifications_flutter/presentation/blocs/notifications/notifications_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.select((NotificationsBloc bloc) => Text(bloc.state.status.toString())),
        actions: [
          IconButton(
            onPressed: () {
              context.read<NotificationsBloc>().requestPermission();
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {

    final notications = context.watch<NotificationsBloc>().state.notifications;
    return ListView.builder(
      itemBuilder: (context, index) {
        final notication = notications[index];
        return ListTile(
          title: Text(notication.title), 
          subtitle: Text(notication.body),
          leading: notication.imageUrl != null ? Image.network(notication.imageUrl!) : null,
          );
      }, itemCount: notications.length);
  }
}