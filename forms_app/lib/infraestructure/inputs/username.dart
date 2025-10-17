import 'package:formz/formz.dart';

enum UsernameError { empty }

class Username extends FormzInput<String, UsernameError> {
  const Username.pure() : super.pure('');
  const Username.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == UsernameError.empty) {
      return 'Username is required';
    }

    if (value.length > 20) {
      return 'Username must be at most 20 characters';
    }

    return null;
  }

  @override
  UsernameError? validator(String value) {
    if (value.length > 20) {
      return UsernameError.empty;
    }

    if (value.isEmpty) {
      return UsernameError.empty;
    }

    return null;
  }
}
