import 'package:dio/dio.dart';
import '../../data/data.dart' show AuthService, AuthRepository;

class AuthInterceptor extends QueuedInterceptor {
  final Dio _dio;
  final AuthService _authService;
  final AuthRepository _authRepository;

  AuthInterceptor(this._dio, this._authService, this._authRepository);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains('/m/auth/refresh-token')) {
      try {
        final newToken = await _authService.refreshToken();
        final requestOptions = err.requestOptions;
        requestOptions.headers['Authorization'] = 'Bearer $newToken';
        final response = await _dio.fetch(requestOptions);
        return handler.resolve(response);
      } catch (_) {
        await _authRepository.signOut();
        return handler.reject(err);
      }
    }
    return handler.next(err);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final publicPaths = ['/m/auth/login', '/m/auth/register'];

    final isPublicPath = publicPaths.any((path) => options.path.contains(path));

    if (isPublicPath) {
      return handler.next(options);
    }

    final token = await _authService.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }
}
