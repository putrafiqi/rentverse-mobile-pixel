import '../models/models.dart';

enum AuthStatus { authenticated, unauthenticated }

abstract class AuthRepository {
  Stream<AuthStatus> get status;
  Stream<User?> get currentUser;

  Future<Result> signIn({required String email, required String password});

  Future<Result> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String phoneNumber,
  });
  Future<void> signOut();

  Future<Result> changePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<void> close();
}
