import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = [
      'Cargando películas...',
      'Buscando en la base de datos...',
      'Casi listo, gracias por tu paciencia...',
      'Preparando todo para ti...',
      '¡Listo en un momento!',
    ];

    return Stream.periodic(const Duration(seconds: 3),
        (count) => messages[count % messages.length]);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Espera un momento por favor...'),
          SizedBox(height: 10),
          CircularProgressIndicator(strokeWidth: 2),
          SizedBox(height: 10),
          StreamBuilder<String>(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Cargando...');

              return Text(snapshot.data!);
            },
          )
        ],
      ),
    ));
  }
}
