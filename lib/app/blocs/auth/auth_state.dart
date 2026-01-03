part of 'auth_bloc.dart';

final class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;

  const AuthState({this.status = AuthStatus.unknown, this.user});

  bool get isUnknown => status == AuthStatus.unknown;
  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;

  AuthState copyWith({AuthStatus? status, User? user}) {
    return AuthState(status: status ?? this.status, user: user ?? this.user);
  }

  @override
  List<Object?> get props => [status, user];
}
