import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_push_notifications_flutter/domain/entities/push_messages.dart';
import 'package:local_push_notifications_flutter/presentation/blocs/notifications/notifications_bloc.dart';

class DetailsScreen extends StatelessWidget {

  final String pushMessageId;

  const DetailsScreen({super.key, required this.pushMessageId});

  @override
  Widget build(BuildContext context) {
    final pushMessage = context.watch<NotificationsBloc>().getMessageById(pushMessageId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Push message details: $pushMessageId'),
      ),
      body: pushMessage == null ? const Center(child: Text('Push message not found')) :  _DetaildView(pushMessage: pushMessage),
    );
  }
}

class _DetaildView extends StatelessWidget {
  final PushMessage pushMessage;
  const _DetaildView({required this.pushMessage});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20), 
      child: Column(children: [
        if(pushMessage.imageUrl != null) Image.network(pushMessage.imageUrl!),
        const SizedBox(height: 20,),
        Text(pushMessage.title, style: textStyle.titleMedium,),
        const SizedBox(height: 20,),
        Text(pushMessage.body),
        Divider(),
        Text(pushMessage.data.toString()),
      ]));
  }
}