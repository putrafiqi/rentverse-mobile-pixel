import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import 'data/data.dart';
import 'app/app.dart';
import 'core/core.dart';

Future<AuthRepository> _bootstrapAuthRepository(
  Dio dio,
  FlutterSecureStorage storage,
) async {
  final authService = DioAuthService(dio, storage);
  final authRepository = AuthRepositoryImpl(authService);

  dio.interceptors.add(AuthInterceptor(dio, authService, authRepository));

  // Initialize the auth repository to load any existing session
  await authRepository.initialize();

  return authRepository;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);

  const baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://localhost:3000/api/v1/m/',
  );

  final dio = Dio();
  dio.options.baseUrl = baseUrl;

  final storage = FlutterSecureStorage(
    aOptions: AndroidOptions(),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  final authRepository = await _bootstrapAuthRepository(dio, storage);

  if (kDebugMode) {
    dio.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
        ),
      ),
    );

    Bloc.observer = TalkerBlocObserver();
  }

  runApp(App(authRepositoryBuilder: () => authRepository));
}
