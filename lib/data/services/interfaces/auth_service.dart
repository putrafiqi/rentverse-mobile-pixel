import 'package:equatable/equatable.dart';

import '../models/models.dart';

const String defaultTokenKey = 'token';

abstract class AuthService {
  Future<UserModel> signIn({required String email, required String password});
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String phoneNumber,
  });
  Future<void> signOut();

  Future<UserModel> verifyToken();
  Future<String> refreshToken();
  Future<String?> getToken();

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}

class AuthServiceException extends Equatable implements Exception {
  final String message;
  const AuthServiceException([this.message = 'An unknown error occurred.']);

  @override
  String toString() => 'AuthServiceException: $message';

  @override
  List<Object> get props => [message];
}
