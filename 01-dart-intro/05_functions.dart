void main() {
  print(greetEveryone());

  print('Suma: ${addTwoNumbers(1, 2)}');

  print(greetPerson(name: 'Edy'));
}

String greetEveryone() {
  return 'Hello everyone!';
}

int addTwoNumbers(int a, int b) {
  return a + b;
}

int addTwoNumbersLambda(int a, int b) => a + b;

int addTwoNumbersOptional(int a, [int b = 0]) {
  return a + b;
}

String greetPerson({required String name, String message = 'Hola'}) {
  return 'Hola, Fernando';
}
