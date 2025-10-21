import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/domain/entities/push_message.dart';
import 'package:push_app/presentation/blocs/notifications/notifications_bloc.dart';

class DetailsScreen extends StatelessWidget {
  final String pushMessageId;

  const DetailsScreen({super.key, required this.pushMessageId});

  @override
  Widget build(BuildContext context) {
    final PushMessage? message = context
        .watch<NotificationsBloc>()
        .getMessageById(pushMessageId);

    return Scaffold(
      appBar: AppBar(title: const Text('Details Screen')),
      body: message == null
          ? const Center(child: Text('Message not found'))
          : _DetailsView(message: message),
    );
  }
}

class _DetailsView extends StatelessWidget {
  final PushMessage message;
  const _DetailsView({required this.message});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          if (message.imageUrl != null) ...[
            Image.network(message.imageUrl!),
            SizedBox(height: 20),
          ],

          Text(message.title, style: textStyles.headlineMedium),
          SizedBox(height: 10),
          Text(message.body, style: textStyles.bodyLarge),

          const Divider(),
          Text(message.data.toString(), style: textStyles.bodySmall),
        ],
      ),
    );
  }
}
