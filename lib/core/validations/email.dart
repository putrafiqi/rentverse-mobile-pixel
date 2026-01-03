import 'package:formz/formz.dart';

enum EmailValidationError {
  required('Email is required'),

  invalid('Please enter a valid email address');

  final String message;
  const EmailValidationError(this.message);
}

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure([super.value = '']) : super.pure();

  const Email.dirty([super.value = '']) : super.dirty();

  // Regex pattern for validating email addresses
  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationError.required;
    }

    return _emailRegex.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}
