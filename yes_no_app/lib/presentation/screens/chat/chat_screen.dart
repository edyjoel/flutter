import 'package:flutter/material.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_buble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_buble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/57899051?v=4'),
            ),
          ),
          title: Text('Chat Screen'),
        ),
        body: _ChatView());
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return (index & 2 == 0)
                        ? HerMessageBuble()
                        : MyMessageBuble();
                  }),
            ),
            MessageFieldBox()
          ],
        ),
      ),
    );
  }
}
