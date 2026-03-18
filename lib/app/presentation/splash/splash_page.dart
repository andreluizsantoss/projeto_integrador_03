import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador_03/app/core/ui/app_colors.dart';
import 'package:projeto_integrador_03/app/core/ui/app_text_styles.dart';
import 'package:projeto_integrador_03/app/core/ui/widgets/app_button.dart';
import 'package:projeto_integrador_03/app/core/utils/responsive_context.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: context.responsiveValue(
                    mobile: context.screenHeight * 0.12,
                    tablet: context.screenHeight * 0.55,
                  ),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Text(
                'PROJETO\nINTEGRADOR 3',
                textAlign: TextAlign.center,
                style: AppTextStyles.h1.copyWith(
                  color: Colors.black,
                  fontSize: context.responsiveValue(mobile: 36, tablet: 72),
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                  letterSpacing: -0.5,
                ),
              ),
              AppButton(
                label: 'Acessar',
                width: context.responsiveValue(mobile: 180, tablet: 280),
                height: context.responsiveValue(mobile: 56, tablet: 80),
                onPressed: () => context.push('/login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
