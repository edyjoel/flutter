import 'package:formz/formz.dart';

// Define input validation errors
enum StockError { empty, value }

// Extend FormzInput and provide the input type and error type.
class Stock extends FormzInput<double, StockError> {
  // Call super.pure to represent an unmodified form input.
  const Stock.pure() : super.pure(0.0);

  // Call super.dirty to represent a modified form input.
  const Stock.dirty(double value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == StockError.empty) return 'El campo es requerido';
    if (displayError == StockError.value) {
      return 'El valor no puede ser negativo';
    }
    return 'No tiene formato válido';
  }

  // Override validator to handle validating a given input value.
  @override
  StockError? validator(double value) {
    if (value == 0) return StockError.empty;
    if (value < 0) return StockError.value;
    return null;
  }
}
