import '../../../core/core.dart';
import '../entities/entities.dart';

abstract class AuthRepository {
  Stream<AuthSession> get session;

  Future<void> initialize();

  Future<Result<void>> signIn({
    required String email,
    required String password,
  });

  Future<Result<void>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String phoneNumber,
  });
  Future<void> signOut();

  Future<Result<void>> changePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<void> close();
}
