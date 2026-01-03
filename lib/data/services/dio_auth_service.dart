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
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    return _performRequest(
      () => _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      ),
      (data) async {
        final token = data['token'] as String;
        await _secureStorage.write(key: defaultTokenKey, value: token);
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
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
          'dateOfBirth': dateOfBirth,
          'phone': phoneNumber,
        },
      ),
      (data) async {
        final token = data['token'] as String;
        await _secureStorage.write(key: defaultTokenKey, value: token);
        return UserModel.fromJson(data['user']);
      },
    );
  }

  @override
  Future<UserModel> verifyToken() async {
    return _performRequest(
      () => _dio.get('/auth/me'),
      (data) async => UserModel.fromJson(data),
    );
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) {
    return _performRequest(
      () => _dio.post(
        '/users/change-password',
        data: {'currentPassword': oldPassword, 'newPassword': newPassword},
      ),
      (data) async {},
    );
  }

  @override
  Future<String> refreshToken() async {
    return _performRequest(() => _dio.post('/auth/refresh-token'), (
      data,
    ) async {
      final token = data['token'] as String;
      await _secureStorage.write(key: defaultTokenKey, value: token);
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
    Future<T> Function(dynamic data) mapper,
  ) async {
    try {
      final response = await request();
      final data = response.data['data'];
      return await mapper(data);
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? e.message ?? 'Unknown error';
      throw AuthServiceException(errorMessage);
    } catch (_) {
      throw AuthServiceException();
    }
  }
}
