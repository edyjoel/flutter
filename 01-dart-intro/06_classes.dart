void main() {
  final wolverine = new Hero(name: 'Logan', power: 'Regeneracion');

  print(wolverine);
  print(wolverine.name);
  print(wolverine.power);
}

class Hero {
  String name;
  String power;

  Hero({required this.name, required this.power});

  @override
  String toString() {
    return 'Hola Mundo';
  }

//   Hero(String pName, String pPower)
//     : name = pName,
//       power = pPower;
}
