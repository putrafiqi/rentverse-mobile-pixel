part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInSubmitted extends SignInEvent {
  const SignInSubmitted();
}

class SignInEmailChanged extends SignInEvent {
  final String email;

  const SignInEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class SignInPasswordChanged extends SignInEvent {
  final String password;

  const SignInPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class SignInPasswordObscuredToggled extends SignInEvent {
  const SignInPasswordObscuredToggled();
}
