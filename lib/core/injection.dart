import 'package:get_it/get_it.dart';
import 'package:projeto_integrador_03/core/auth_guard.dart';
import 'package:projeto_integrador_03/core/logger/app_logger.dart';
import 'package:projeto_integrador_03/core/rest_client/dio/dio_rest_client.dart';
import 'package:projeto_integrador_03/core/rest_client/rest_client.dart';
import 'package:projeto_integrador_03/cubits/auth_cubit.dart';
import 'package:projeto_integrador_03/cubits/checklist_cubit.dart';
import 'package:projeto_integrador_03/cubits/connectivity_cubit.dart';
import 'package:projeto_integrador_03/cubits/theme_cubit.dart';
import 'package:projeto_integrador_03/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:projeto_integrador_03/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:projeto_integrador_03/features/auth/domain/repositories/auth_repository.dart';
import 'package:projeto_integrador_03/features/checklist/data/datasources/checklist_remote_datasource.dart';
import 'package:projeto_integrador_03/features/checklist/data/repositories/checklist_repository_impl.dart';
import 'package:projeto_integrador_03/features/checklist/domain/repositories/checklist_repository.dart';
import 'package:projeto_integrador_03/features/history/data/datasources/history_remote_datasource.dart';
import 'package:projeto_integrador_03/features/history/data/repositories/history_repository_impl.dart';
import 'package:projeto_integrador_03/features/history/domain/repositories/history_repository.dart';
import 'package:projeto_integrador_03/features/history/presentation/cubit/history_cubit.dart';
import 'package:projeto_integrador_03/features/items/data/datasources/item_remote_datasource.dart';
import 'package:projeto_integrador_03/features/items/data/repositories/item_repository_impl.dart';
import 'package:projeto_integrador_03/features/items/domain/repositories/item_repository.dart';
import 'package:projeto_integrador_03/features/machines/data/datasources/machine_remote_datasource.dart';
import 'package:projeto_integrador_03/features/machines/data/repositories/machine_repository_impl.dart';
import 'package:projeto_integrador_03/features/machines/domain/repositories/machine_repository.dart';
import 'package:projeto_integrador_03/features/machines/presentation/cubit/machine_cubit.dart';
import 'package:projeto_integrador_03/features/operators/data/datasources/operator_remote_datasource.dart';
import 'package:projeto_integrador_03/features/operators/data/repositories/operator_repository_impl.dart';
import 'package:projeto_integrador_03/features/operators/domain/repositories/operator_repository.dart';
import 'package:projeto_integrador_03/features/checklist/presentation/cubit/checklist_detail_cubit.dart';
import 'package:projeto_integrador_03/features/operators/presentation/cubit/operator_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Logger
  getIt.registerLazySingleton<AppLogger>(() => AppLoggerImpl());

  // Network
  getIt.registerLazySingleton<RestClient>(() => DioRestClient());

  // ── DataSources ──────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<RestClient>()),
  );
  getIt.registerLazySingleton<OperatorRemoteDataSource>(
    () => OperatorRemoteDataSourceImpl(getIt<RestClient>()),
  );
  getIt.registerLazySingleton<MachineRemoteDataSource>(
    () => MachineRemoteDataSourceImpl(getIt<RestClient>()),
  );
  getIt.registerLazySingleton<ItemRemoteDataSource>(
    () => ItemRemoteDataSourceImpl(getIt<RestClient>()),
  );
  getIt.registerLazySingleton<ChecklistRemoteDataSource>(
    () => ChecklistRemoteDataSourceImpl(getIt<RestClient>()),
  );
  getIt.registerLazySingleton<HistoryRemoteDataSource>(
    () => HistoryRemoteDataSourceImpl(getIt<RestClient>()),
  );

  // ── Repositories ─────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );
  getIt.registerLazySingleton<OperatorRepository>(
    () => OperatorRepositoryImpl(getIt<OperatorRemoteDataSource>()),
  );
  getIt.registerLazySingleton<MachineRepository>(
    () => MachineRepositoryImpl(getIt<MachineRemoteDataSource>()),
  );
  getIt.registerLazySingleton<ItemRepository>(
    () => ItemRepositoryImpl(getIt<ItemRemoteDataSource>()),
  );
  getIt.registerLazySingleton<ChecklistRepository>(
    () => ChecklistRepositoryImpl(getIt<ChecklistRemoteDataSource>()),
  );
  getIt.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(getIt<HistoryRemoteDataSource>()),
  );

  // ── Cubits ───────────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<ConnectivityCubit>(() => ConnectivityCubit());
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  getIt.registerLazySingleton<ChecklistCubit>(
    () => ChecklistCubit(
      checklistRepository: getIt<ChecklistRepository>(),
      itemRepository: getIt<ItemRepository>(),
    ),
  );
  getIt.registerLazySingleton<OperatorCubit>(
    () => OperatorCubit(getIt<OperatorRepository>()),
  );
  getIt.registerLazySingleton<MachineCubit>(
    () => MachineCubit(getIt<MachineRepository>()),
  );
  getIt.registerLazySingleton<HistoryCubit>(
    () => HistoryCubit(getIt<HistoryRepository>()),
  );
  getIt.registerFactory<ChecklistDetailCubit>(
    () => ChecklistDetailCubit(getIt<ChecklistRepository>()),
  );

  // ── Auth Guard ───────────────────────────────────────────────────────────────
  getIt.registerFactory<AuthGuard>(() => AuthGuard(getIt<AuthCubit>()));
}
