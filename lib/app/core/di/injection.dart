import 'package:get_it/get_it.dart';
import '../auth/auth_cubit.dart';
import '../cubit/connectivity/connectivity_cubit.dart';
import '../cubit/theme/theme_cubit.dart';
import '../logger/app_logger.dart';
import '../rest_client/dio/dio_rest_client.dart';
import '../rest_client/rest_client.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Logger
  getIt.registerLazySingleton<AppLogger>(() => AppLoggerImpl());

  // Network
  getIt.registerLazySingleton<RestClient>(() => DioRestClient());

  // Cubits Globais
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit());
  getIt.registerLazySingleton<ConnectivityCubit>(() => ConnectivityCubit());
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}
