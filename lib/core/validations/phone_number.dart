import 'package:formz/formz.dart';

enum PhoneNumberValidationError {
  required('Phone number is required'),

  invalid('Invalid phone number format'),

  tooShort('Phone number is too short');

  final String message;
  const PhoneNumberValidationError(this.message);
}

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure([super.value = '']) : super.pure();
  const PhoneNumber.dirty([super.value = '']) : super.dirty();

  // Regex to allow digits, spaces, hyphens, parentheses, and optional leading +
  static final _phoneRegex = RegExp(r'^\+?[0-9\s\-\(\)]+$');

  @override
  PhoneNumberValidationError? validator(String value) {
    if (value.isEmpty) {
      return PhoneNumberValidationError.required;
    }

    if (!_phoneRegex.hasMatch(value)) {
      return PhoneNumberValidationError.invalid;
    }

    // 3. Check the actual digit length
    final sanitizedNumber = value.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');

    if (sanitizedNumber.length < 8) {
      return PhoneNumberValidationError.tooShort;
    }

    return null;
  }
}
