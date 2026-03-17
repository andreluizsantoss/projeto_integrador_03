import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/ui/app_colors.dart';
import '../../core/ui/app_text_styles.dart';

import '../../core/ui/widgets/app_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              // Logo da Empresa
              Image.asset('assets/images/logo.png', height: 120),
              const SizedBox(height: 48),
              // Título
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'PROJETO INTEGRADOR 3',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h1.copyWith(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(flex: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: AppButton(
                  label: 'ACESSAR',
                  height: 56,
                  onPressed: () => context.push('/login'),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
