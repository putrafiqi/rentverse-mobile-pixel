import 'package:equatable/equatable.dart';

import 'user.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthSession extends Equatable {
  final AuthStatus status;
  final User? user;

  const AuthSession({this.status = AuthStatus.unknown, this.user});

  AuthSession copyWith({AuthStatus? status, User? user}) {
    return AuthSession(status: status ?? this.status, user: user ?? this.user);
  }

  @override
  List<Object?> get props => [status, user];
}
