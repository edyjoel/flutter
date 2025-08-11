import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarScreen extends StatelessWidget {
  static const String name = 'snackbar_screen';
  const SnackbarScreen({super.key});

  void showCustomSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackbar = SnackBar(
      content: const Text('Hola mundo'),
      action: SnackBarAction(label: 'Deshacer', onPressed: () {}),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
                title: const Text('Estas seguro?'),
                content: const Text(
                    'Amet labore enim sunt irure minim fugiat elit est veniam laboris. Dolore eu cillum eu aliquip dolor ex dolor pariatur non aute. Elit nulla pariatur in dolore consequat aliqua incididunt veniam sit tempor eu cupidatat. Deserunt laborum et do esse pariatur mollit ipsum excepteur velit. Aliquip fugiat velit aliqua in eiusmod culpa eu esse pariatur irure. In irure deserunt irure eu. Aliquip irure aute adipisicing magna esse occaecat velit incididunt culpa.'),
                actions: [
                  TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('Cancelar')),
                  FilledButton(
                      onPressed: () => context.pop(),
                      child: const Text('Aceptar'))
                ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snackbars y diálogos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: () {
                showAboutDialog(context: context, children: [
                  Text('Licencia de uso de Flutter'),
                ]);
              },
              child: Text('Licencias usadas'),
            ),
            FilledButton.tonal(
              onPressed: () => openDialog(context),
              child: Text('Mostrar diálogo'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Mostrar Snackbar'),
        icon: Icon(Icons.remove_red_eye_outlined),
        onPressed: () {
          showCustomSnackbar(context);
        },
      ),
    );
  }
}
