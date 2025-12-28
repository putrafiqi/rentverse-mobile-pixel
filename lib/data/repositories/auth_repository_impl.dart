import 'dart:async';

import '../services/services.dart';
import './models/models.dart';
import './interfaces/interfaces.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  final _statusController = StreamController<AuthStatus>.broadcast();
  final _userController = StreamController<User?>.broadcast();

  @override
  Stream<AuthStatus> get status => _statusController.stream;

  @override
  Stream<User?> get currentUser => _userController.stream;

  AuthRepositoryImpl(this._authService) {
    _loadInitialData();
  }

  void _loadInitialData() async {
    try {
      final userModel = await _authService.verifyToken();
      final user = User.fromJson(userModel.toJson());
      _userController.add(user);
      _statusController.add(AuthStatus.authenticated);
    } catch (_) {
      await _authService.signOut();
      _userController.add(null);
      _statusController.add(AuthStatus.unauthenticated);
    }
  }

  @override
  Future<Result<void>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await _authService.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      return Result.success(null);
    } on AuthServiceException catch (e) {
      return Result.failure(e.message);
    } catch (e) {
      return Result.failure('Unknown failure occurred during password change.');
    }
  }

  @override
  Future<Result<void>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _authService.signIn(
        email: email,
        password: password,
      );
      final user = User.fromJson(userModel.toJson());
      _userController.add(user);
      _statusController.add(AuthStatus.authenticated);
      return Result.success(null);
    } on AuthServiceException catch (e) {
      return Result.failure(e.message);
    } catch (e) {
      return Result.failure('Unknown failure occurred during sign in.');
    }
  }

  @override
  Future<void> signOut() async {
    await _authService.signOut();
    _userController.add(null);
    _statusController.add(AuthStatus.unauthenticated);
  }

  @override
  Future<Result<void>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String phoneNumber,
  }) async {
    try {
      final userModel = await _authService.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        phoneNumber: phoneNumber,
      );
      final user = User.fromJson(userModel.toJson());
      _userController.add(user);
      _statusController.add(AuthStatus.authenticated);
      return Result.success(null);
    } on AuthServiceException catch (e) {
      return Result.failure(e.message);
    } catch (e) {
      return Result.failure('Unknown failure occurred during sign up.');
    }
  }

  @override
  Future<void> close() async {
    await _statusController.close();
    await _userController.close();
  }
}
