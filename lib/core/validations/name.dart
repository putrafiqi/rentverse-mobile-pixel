import 'package:formz/formz.dart';

enum NameValidationError {
  required('Name is required'),

  tooShort('Name must be at least 2 characters'),

  invalid('Name contains invalid characters');

  final String message;
  const NameValidationError(this.message);
}

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure([super.value = '']) : super.pure();
  const Name.dirty([super.value = '']) : super.dirty();

  // Regex to allow letters, spaces, hyphens, and apostrophes
  static final _nameRegex = RegExp(r"^[a-zA-Z\s\-\']+$");

  @override
  NameValidationError? validator(String value) {
    if (value.trim().isEmpty) {
      return NameValidationError.required;
    }

    if (value.trim().length < 2) {
      return NameValidationError.tooShort;
    }

    if (!_nameRegex.hasMatch(value)) {
      return NameValidationError.invalid;
    }

    return null;
  }
}
