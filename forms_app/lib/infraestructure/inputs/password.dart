import 'package:formz/formz.dart';

enum PasswordError { empty }

class Password extends FormzInput<String, PasswordError> {
  const Password.pure() : super.pure('');
  const Password.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PasswordError.empty) {
      return 'Password is required';
    }

    if (value.length > 20) {
      return 'Password must be at most 20 characters';
    }

    return null;
  }

  @override
  PasswordError? validator(String value) {
    if (value.length > 20) {
      return PasswordError.empty;
    }

    if (value.isEmpty) {
      return PasswordError.empty;
    }

    return null;
  }
}
