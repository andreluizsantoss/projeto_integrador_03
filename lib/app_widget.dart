import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/core/auth/auth_cubit.dart';
import 'app/core/cubit/connectivity/connectivity_cubit.dart';
import 'app/core/cubit/theme/theme_cubit.dart';
import 'app/core/di/injection.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        BlocProvider(create: (_) => getIt<ConnectivityCubit>()),
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
      ],
      child: const _MaterialAppWidget(),
    );
  }
}

class _MaterialAppWidget extends StatelessWidget {
  const _MaterialAppWidget();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
