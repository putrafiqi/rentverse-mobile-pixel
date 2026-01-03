part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final Name firstName;
  final Name lastName;
  final PhoneNumber phoneNumber;
  final DateOfBirth dateOfBirth;
  final bool isValidInput;
  final String? errorMessage;
  final bool isObscuredPassword;

  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.firstName = const Name.pure(),
    this.lastName = const Name.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.dateOfBirth = const DateOfBirth.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValidInput = false,
    this.errorMessage,
    this.isObscuredPassword = true,
  });

  SignUpState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    Name? firstName,
    Name? lastName,
    PhoneNumber? phoneNumber,
    DateOfBirth? dateOfBirth,
    bool? isValidInput,
    String? errorMessage,
    bool? isObscuredPassword,
  }) {
    return SignUpState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      isValidInput: isValidInput ?? this.isValidInput,
      errorMessage: errorMessage ?? this.errorMessage,
      isObscuredPassword: isObscuredPassword ?? this.isObscuredPassword,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    status,
    isValidInput,
    errorMessage,
    isObscuredPassword,
    firstName,
    lastName,
    phoneNumber,
    dateOfBirth,
  ];
}
