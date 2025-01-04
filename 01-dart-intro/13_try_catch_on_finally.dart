void main() async {
  print('Inicio del programa');

  try {
    final value = await httpGet('api');
    print(value);
  } on Exception {
    print('Tenemos una Exception');
  } catch (err) {
    print(err);
  } finally {
    print('Fin del try catch');
  }

  print('Fin del programa');
}

Future<String> httpGet(String url) async {
  await Future.delayed(const Duration(seconds: 1));

  throw Exception('No hay parametros');

//   throw 'Error en la peticion';

//   return 'Tenemos un valor';
}
