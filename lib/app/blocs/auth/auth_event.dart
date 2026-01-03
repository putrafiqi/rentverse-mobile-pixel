part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthRequested extends AuthEvent {
  const AuthRequested();
}

final class AuthSignedOut extends AuthEvent {
  const AuthSignedOut();
}
