import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  const MessageFieldBox({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final focusMode = FocusNode();

    final colors = Theme.of(context).colorScheme;

    final outlineInputBorder = UnderlineInputBorder(
        borderSide: BorderSide(color: colors.primary),
        borderRadius: BorderRadius.circular(40));

    final inputDecoration = InputDecoration(
      hintText: 'Type a message',
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
      suffixIcon: IconButton(
          icon: Icon(Icons.send_outlined),
          onPressed: () {
            final message = textController.text;
            print('Send message $message');
            textController.clear();
          }),
    );

    return TextFormField(
      onTapOutside: (event) {
        focusMode.unfocus();
      },
      focusNode: focusMode,
      controller: textController,
      decoration: inputDecoration,
      onFieldSubmitted: (value) {
        print(value);
        textController.clear();
        focusMode.requestFocus();
      },
    );
  }
}
