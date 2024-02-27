import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/features/auth/auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youapp_test/features/home/home.dart';

import 'config.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  await _setupCore();

  // ------------------------ Authentication ----------------------------------

  // Data
  getIt
    ..registerLazySingleton<AuthApiDataSource>(
      () => AuthApiDataSourceImpl(
        getIt(),
        authLocalSource: getIt(),
      ),
    )
    ..registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt()),
    );

  // Domain
  getIt
    ..registerLazySingleton(() => LoginUseCase(getIt()))
    ..registerLazySingleton(() => RegisterUseCase(getIt()))
    ..registerLazySingleton(() => LogoutUseCase(getIt()))
    ..registerLazySingleton(() => ProfileUseCase(getIt()));

  // Presentation
  getIt.registerFactory(
    () => AuthBloc(
      loginUseCase: getIt(),
      registerUseCase: getIt(),
      logoutUseCase: getIt(),
      profileUseCase: getIt(),
    ),
  );

  // ------------------------ Home ----------------------------------

  // Data
  getIt
    ..registerLazySingleton<HomeApiDataSource>(
        () => HomeApiDataSourceImpl(getIt()))
    ..registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(getIt()));

  // Domain
  getIt.registerLazySingleton(() => UpdateProfileUseCase(getIt()));

  // Presentation
  getIt.registerFactory(
    () => HomeBloc(
      updateProfileUseCase: getIt(),
    ),
  );
}

Future<void> _setupCore() async {
  EquatableConfig.stringify = AppConfig.autoStringifyEquatable;

  getIt.registerLazySingleton(InternetConnectionChecker.new);
  getIt.registerLazySingleton(
    () => CaptureErrorUseCase(),
  );
  getIt.registerLazySingleton(
    () => Dio()
      ..options = BaseOptions(baseUrl: AppConfig.baseUrl.value)
      ..interceptors.addAll([
        LogInterceptor(requestBody: false, responseBody: false),
        AuthHttpInterceptor(getIt()),
      ]),
  );

  if (!kIsWeb) {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init('${appDocDir.path}/db');
  }

  getIt.registerLazySingleton<HiveInterface>(() => Hive);

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<InternetConnectionChecker>()),
  );

  // ------------------------ Settings ----------------------------------

  // Domain
  getIt.registerLazySingleton(RecordErrorUseCase.new);
}
