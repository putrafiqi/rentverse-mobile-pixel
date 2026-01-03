part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final bool isValidInput;
  final String? errorMessage;
  final bool isObscuredPassword;

  const SignInState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValidInput = false,
    this.errorMessage,
    this.isObscuredPassword = true,
  });

  SignInState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    bool? isValidInput,
    String? errorMessage,
    bool? isObscuredPassword,
  }) {
    return SignInState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      isValidInput: isValidInput ?? this.isValidInput,
      errorMessage: errorMessage ?? this.errorMessage,
      isObscuredPassword: isObscuredPassword ?? this.isObscuredPassword,
    );
  }

  @override
  List<Object?> get props => [
    status,
    email,
    password,
    isValidInput,
    errorMessage,
    isObscuredPassword,
  ];
}
