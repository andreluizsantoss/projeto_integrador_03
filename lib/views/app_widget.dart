import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_integrador_03/cubits/auth_cubit.dart';
import 'package:projeto_integrador_03/cubits/checklist_cubit.dart';
import 'package:projeto_integrador_03/cubits/connectivity_cubit.dart';
import 'package:projeto_integrador_03/cubits/theme_cubit.dart';
import 'package:projeto_integrador_03/core/injection.dart';
import 'package:projeto_integrador_03/core/app_router.dart';
import 'package:projeto_integrador_03/core/theme_config.dart';
import 'package:projeto_integrador_03/core/config/app_config.dart';
import 'package:projeto_integrador_03/features/history/presentation/cubit/history_cubit.dart';
import 'package:projeto_integrador_03/features/machines/presentation/cubit/machine_cubit.dart';
import 'package:projeto_integrador_03/features/operators/presentation/cubit/operator_cubit.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        BlocProvider(create: (_) => getIt<ConnectivityCubit>()),
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<ChecklistCubit>()),
        BlocProvider(create: (_) => getIt<OperatorCubit>()),
        BlocProvider(create: (_) => getIt<MachineCubit>()),
        BlocProvider(create: (_) => getIt<HistoryCubit>()),
      ],
      child: const _MaterialAppWidget(),
    );
  }
}

class _MaterialAppWidget extends StatelessWidget {
  const _MaterialAppWidget();

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;

    return MaterialApp.router(
      title: AppConfig.title,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      darkTheme: AppTheme.theme,
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
