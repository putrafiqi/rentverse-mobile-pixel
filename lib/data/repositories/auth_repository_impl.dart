import 'dart:async';

import '../../core/core.dart';
import '../services/services.dart';
import 'entities/entities.dart';
import 'interfaces/interfaces.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;
  final _sessionController = StreamController<AuthSession>.broadcast();

  AuthSession _currentSession = const AuthSession(
    status: AuthStatus.unknown,
    user: null,
  );

  AuthRepositoryImpl(this._authService);

  @override
  Stream<AuthSession> get session async* {
    yield _currentSession;
    yield* _sessionController.stream;
  }

  void _updateSession(AuthStatus status, User? user) {
    _currentSession = AuthSession(status: status, user: user);
    if (!_sessionController.isClosed) {
      _sessionController.add(_currentSession);
    }
  }

  @override
  Future<void> initialize() async {
    try {
      final userModel = await _authService.verifyToken();
      _updateSession(AuthStatus.authenticated, userModel.toEntity());
    } catch (e) {
      try {
        await _authService.signOut();
      } catch (_) {}
      _updateSession(AuthStatus.unauthenticated, null);
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
      _updateSession(AuthStatus.authenticated, userModel.toEntity());
      return const Result.success(null);
    } on AuthServiceException catch (e) {
      return Result.failure(e.message);
    } catch (e) {
      return const Result.failure('Unknown failure occurred during sign in.');
    }
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
      _updateSession(AuthStatus.authenticated, userModel.toEntity());
      return const Result.success(null);
    } on AuthServiceException catch (e) {
      return Result.failure(e.message);
    } catch (e) {
      return const Result.failure('Unknown failure occurred during sign up.');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } catch (_) {
    } finally {
      _updateSession(AuthStatus.unauthenticated, null);
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
      return const Result.success(null);
    } on AuthServiceException catch (e) {
      return Result.failure(e.message);
    } catch (e) {
      return const Result.failure(
        'Unknown failure occurred during password change.',
      );
    }
  }

  @override
  Future<void> close() async {
    await _sessionController.close();
  }
}
