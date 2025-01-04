void main() {
  print('Inicio del programa');

  httpGet('api').then((value) {
    print(value);
  }).catchError((err) {
    print(err);
  });

  print('Fin del programa');
}

Future<String> httpGet(String url) {
  return Future.delayed(const Duration(seconds: 1), () {
    throw 'Error en la peticion';

//     return 'Respuesta de la peticion';
  });
}
