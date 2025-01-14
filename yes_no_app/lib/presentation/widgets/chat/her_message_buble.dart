import 'package:flutter/material.dart';

class HerMessageBuble extends StatelessWidget {
  const HerMessageBuble({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: colors.secondary, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'How are you?',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 5),
        // Todo: imagen
        _ImageBuble(),
        SizedBox(height: 10),
      ],
    );
  }
}

class _ImageBuble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
          'https://yesno.wtf/assets/yes/4-c53643ecec77153eefb461e053fb4947.gif',
          width: size.width * 0.7,
          height: 150,
          fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;

        return Container(
          width: size.width * 0.7,
          height: 150,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text('Loading...'),
        );
      }),
    );
  }
}
