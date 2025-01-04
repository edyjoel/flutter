void main() {
  final numbers = [1, 2, 3];

  print('List original: $numbers');
  print('Length: $numbers.length');
  print('Index 0: ${numbers.first}');
  print('Index 0: ${numbers[0]}');
  print('Reversed: ${numbers.reversed}');

  final reversedNumbers = numbers.reversed;
  print('Iterable: $reversedNumbers');
  print('List: ${reversedNumbers.toList()}');
  print('Set: ${reversedNumbers.toSet()}');

  final numbersGraterThan5 = numbers.where((num) {
    return num > 5;
  });

  print('>5 iterable: $numbersGraterThan5');
  print('>5 Set: ${numbersGraterThan5.toSet()}');
}
