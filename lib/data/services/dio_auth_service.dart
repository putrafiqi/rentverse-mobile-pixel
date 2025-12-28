import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './interfaces/interfaces.dart';
import './models/models.dart';

class DioAuthService extends AuthService {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  DioAuthService([Dio? dio, FlutterSecureStorage? secureStorage])
    : _dio = dio ?? Dio(),
      _secureStorage = secureStorage ?? const FlutterSecureStorage();

  @override
  Future<UserModel> signIn({required String email, required String password}) {
    return _performRequest(
      () => _dio.post(
        '/m/auth/login',
        data: {'email': email, 'password': password},
      ),
      (data) {
        final token = data['token'] as String;
        _secureStorage.write(key: defaultTokenKey, value: token);
        return UserModel.fromJson(data['user']);
      },
    );
  }

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String phoneNumber,
  }) {
    return _performRequest(
      () => _dio.post(
        '/m/auth/register',
        data: {
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
          'dateOfBirth': dateOfBirth,
          'phoneNumber': phoneNumber,
        },
      ),
      (data) {
        final token = data['token'] as String;
        _secureStorage.write(key: defaultTokenKey, value: token);
        return UserModel.fromJson(data['user']);
      },
    );
  }

  @override
  Future<UserModel> verifyToken() {
    return _performRequest(
      () => _dio.get('/m/auth/verify-token'),
      (data) => UserModel.fromJson(data['user']),
    );
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) {
    return _performRequest(
      () => _dio.post(
        '/m/users/change-password',
        data: {'currentPassword': oldPassword, 'newPassword': newPassword},
      ),
      (data) {},
    );
  }

  @override
  Future<String> refreshToken() {
    return _performRequest(() => _dio.post('/m/auth/refresh-token'), (data) {
      final token = data['token'] as String;
      _secureStorage.write(key: defaultTokenKey, value: token);
      return token;
    });
  }

  @override
  Future<String?> getToken() async {
    final token = await _secureStorage.read(key: defaultTokenKey);
    return token;
  }

  @override
  Future<void> signOut() async {
    await _secureStorage.delete(key: defaultTokenKey);
  }

  Future<T> _performRequest<T>(
    Future<Response> Function() request,
    T Function(dynamic data) mapper,
  ) async {
    try {
      final response = await request();
      final data = response.data['data'];
      return mapper(data);
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? e.message ?? 'Unknown error';
      throw AuthServiceException(errorMessage);
    } catch (e) {
      throw AuthServiceException();
    }
  }
}
