void main() {
  final String pokemon = 'Ditto';
  final int hp = 100;
  final bool isAlive = true;
  final List<String> abilities = ['impostor'];
  final sprites = <String>['ditto/front.png'];

//   dinamic == null

  dynamic errorMessage = 'Hola';
  errorMessage = true;
  errorMessage = [1, 2, 3];
  errorMessage = {1, 2, 3};
  errorMessage = () => true;
  errorMessage = null;

  print("""
  $pokemon
  $hp
  $isAlive
  $abilities
  $sprites

  """);
}
