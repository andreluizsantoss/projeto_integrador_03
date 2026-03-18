import 'package:get_it/get_it.dart';
import 'package:projeto_integrador_03/app/core/auth/auth_cubit.dart';
import 'package:projeto_integrador_03/app/core/auth/auth_guard.dart';
import 'package:projeto_integrador_03/app/core/cubit/connectivity/connectivity_cubit.dart';
import 'package:projeto_integrador_03/app/core/cubit/theme/theme_cubit.dart';
import 'package:projeto_integrador_03/app/core/logger/app_logger.dart';
import 'package:projeto_integrador_03/app/core/rest_client/dio/dio_rest_client.dart';
import 'package:projeto_integrador_03/app/core/rest_client/rest_client.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Logger
  getIt.registerLazySingleton<AppLogger>(() => AppLoggerImpl());

  // Network
  getIt.registerLazySingleton<RestClient>(() => DioRestClient());

  // 1. Primeiro as dependências básicas (Cubits Globais)
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit());
  getIt.registerLazySingleton<ConnectivityCubit>(() => ConnectivityCubit());
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

  // 2. Depois classes que dependem dos Cubits
  getIt.registerFactory<AuthGuard>(() => AuthGuard(getIt<AuthCubit>()));
}
