import 'package:formz/formz.dart';

enum EmailError { empty, invalid }

class Email extends FormzInput<String, EmailError> {
  const Email.pure() : super.pure('');
  const Email.dirty(super.value) : super.dirty();

  static final RegExp _emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == EmailError.empty) {
      return 'Email is required';
    }

    if (displayError == EmailError.invalid) {
      return 'Enter a valid email';
    }

    return null;
  }

  @override
  EmailError? validator(String value) {
    if (value.isEmpty) {
      return EmailError.empty;
    }

    if (!_emailRegExp.hasMatch(value)) {
      return EmailError.invalid;
    }

    return null;
  }
}
