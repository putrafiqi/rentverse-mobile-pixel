part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

final class SignUpEmailChanged extends SignUpEvent {
  final String email;

  const SignUpEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

final class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  const SignUpPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

final class SignUpFirstNameChanged extends SignUpEvent {
  final String firstName;

  const SignUpFirstNameChanged(this.firstName);

  @override
  List<Object> get props => [firstName];
}

final class SignUpLastNameChanged extends SignUpEvent {
  final String lastName;

  const SignUpLastNameChanged(this.lastName);

  @override
  List<Object> get props => [lastName];
}

final class SignUpPhoneNumberChanged extends SignUpEvent {
  final String phoneNumber;

  const SignUpPhoneNumberChanged(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

final class SignUpDateOfBirthChanged extends SignUpEvent {
  final DateTime dateOfBirth;

  const SignUpDateOfBirthChanged(this.dateOfBirth);

  @override
  List<Object> get props => [dateOfBirth];
}

final class SignUpPasswordObscuredToggled extends SignUpEvent {
  const SignUpPasswordObscuredToggled();
}

final class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted();
}
