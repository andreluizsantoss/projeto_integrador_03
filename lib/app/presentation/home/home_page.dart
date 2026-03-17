import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/auth/auth_cubit.dart';
import '../../core/ui/app_colors.dart';
import '../../core/ui/app_text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userEmail = context.select(
      (AuthCubit cubit) => cubit.state.userEmail,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () => context.read<AuthCubit>().logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home_rounded, size: 80, color: AppColors.primary),
            const SizedBox(height: 24),
            Text('Bem-vindo!', style: AppTextStyles.h2),
            if (userEmail != null) ...[
              const SizedBox(height: 8),
              Text(
                userEmail,
                style: AppTextStyles.bodyLarge.copyWith(color: AppColors.grey),
              ),
            ],
            const SizedBox(height: 48),
            const Text('Tela Principal', style: AppTextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }
}
