import 'package:formz/formz.dart';

enum PasswordValidationError {
  required('Password is required'),

  tooShort('Password must be at least 8 characters'),

  weak('Password must contain at least one letter and one number');

  final String message;
  const PasswordValidationError(this.message);
}

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure([super.value = '']) : super.pure();
  const Password.dirty([super.value = '']) : super.dirty();

  // Regex to check for at least one letter and one number
  static final _passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$');

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.required;
    }

    if (value.length < 8) {
      return PasswordValidationError.tooShort;
    }

    if (!_passwordRegex.hasMatch(value)) {
      return PasswordValidationError.weak;
    }

    return null;
  }
}
