import 'package:formz/formz.dart';

enum DateOfBirthValidationError {
  empty('Date of birth is required'),

  futureDate('Date cannot be in the future'),

  tooOld('Invalid birth year');

  final String message;
  const DateOfBirthValidationError(this.message);
}

class DateOfBirth extends FormzInput<DateTime?, DateOfBirthValidationError> {
  const DateOfBirth.pure([super.value]) : super.pure();

  const DateOfBirth.dirty([super.value]) : super.dirty();

  @override
  DateOfBirthValidationError? validator(DateTime? value) {
    if (value == null) {
      return DateOfBirthValidationError.empty;
    }

    final now = DateTime.now();

    if (value.isAfter(now)) {
      return DateOfBirthValidationError.futureDate;
    }

    if (value.year < 1900) {
      return DateOfBirthValidationError.tooOld;
    }

    return null;
  }
}
