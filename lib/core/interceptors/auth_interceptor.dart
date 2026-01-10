import 'package:dio/dio.dart';
import '../../data/data.dart' show AuthService, AuthRepository;

class AuthInterceptor extends QueuedInterceptor {
  static const String _retriedKey = 'auth_retried_once';

  final Dio _dio;
  final AuthService _authService;
  final AuthRepository _authRepository;

  AuthInterceptor(this._dio, this._authService, this._authRepository);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final excludedPaths = [
      '/auth/login',
      '/auth/register',
      '/m/auth/refresh-token',
    ];

    final isExcludedPath = excludedPaths.any(
      (path) => err.requestOptions.path.contains(path),
    );

    final isUnauthorized = err.response?.statusCode == 401;

    if (!isUnauthorized || isExcludedPath) {
      return handler.next(err);
    }

    final alreadyRetried = err.requestOptions.extra[_retriedKey] == true;
    if (alreadyRetried) {
      await _authRepository.signOut();
      return handler.reject(err);
    }

    final token = await _authService.getToken();
    if (token == null || token.isEmpty) {
      await _authRepository.signOut();
      return handler.reject(err);
    }

    try {
      final newToken = await _authService.refreshToken();

      final requestOptions = err.requestOptions;
      requestOptions.extra[_retriedKey] = true;
      requestOptions.headers['Authorization'] = 'Bearer $newToken';

      final response = await _dio.fetch(requestOptions);
      return handler.resolve(response);
    } catch (_) {
      await _authRepository.signOut();
      return handler.reject(err);
    }
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final publicPaths = ['/auth/login', '/auth/register'];
    final isPublicPath = publicPaths.any((path) => options.path.contains(path));

    if (isPublicPath) {
      return handler.next(options);
    }

    final token = await _authService.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    } else {
      options.headers.remove('Authorization');
    }

    return handler.next(options);
  }
}
