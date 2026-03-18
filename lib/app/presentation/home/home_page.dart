import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador_03/app/core/ui/app_colors.dart';
import 'package:projeto_integrador_03/app/core/ui/widgets/app_button.dart';
import 'package:projeto_integrador_03/app/core/utils/responsive_context.dart';
import 'package:projeto_integrador_03/app/presentation/home/widgets/activity_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final paddingHorizontal = context.responsiveValue<double>(
      mobile: 16.0,
      tablet: 48.0,
    );

    final statusCardHeight = context.responsiveValue<double>(
      mobile: 120.0,
      tablet: 180.0,
    );

    final buttonHeight = context.responsiveValue<double>(
      mobile: 50.0,
      tablet: 64.0,
    );

    final sectionSpacing = context.responsiveValue<double>(
      mobile: 16.0,
      tablet: 32.0,
    );

    final borderRadius = context.responsiveValue<double>(
      mobile: 16.0,
      tablet: 24.0,
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: paddingHorizontal, 
                  vertical: context.responsiveValue<double>(mobile: 8, tablet: 24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: context.responsiveValue<double>(mobile: 32, tablet: 56),
                      fit: BoxFit.contain,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.menu, 
                        color: Colors.black, 
                        size: context.responsiveValue<double>(mobile: 32, tablet: 48),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              SizedBox(height: sectionSpacing),

              // Status Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                child: Container(
                  width: double.infinity,
                  height: statusCardHeight,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9).withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total de Check List Feitos:',
                        style: TextStyle(
                          fontSize: context.responsiveValue<double>(mobile: 18, tablet: 28),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: context.responsiveValue<double>(mobile: 8, tablet: 16)),
                      Text(
                        '1000000',
                        style: TextStyle(
                          fontSize: context.responsiveValue<double>(mobile: 40, tablet: 72),
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: sectionSpacing),

              // Ações Rápidas
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'Historico',
                        onPressed: () {},
                        height: buttonHeight,
                        borderRadius: borderRadius,
                      ),
                    ),
                    SizedBox(width: context.responsiveValue<double>(mobile: 16, tablet: 24)),
                    Expanded(
                      child: AppButton(
                        label: 'Check List',
                        onPressed: () => context.push('/machine-selection'),
                        height: buttonHeight,
                        borderRadius: borderRadius,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: context.responsiveValue<double>(mobile: 24, tablet: 48)),

              // Lista de Atividades
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                    paddingHorizontal,
                    0,
                    paddingHorizontal,
                    context.responsiveValue<double>(mobile: 16, tablet: 48),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9).withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(
                      vertical: context.responsiveValue<double>(mobile: 16, tablet: 32),
                    ),
                    itemCount: 10,
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.black.withValues(alpha: 0.05),
                      indent: 16,
                      endIndent: 16,
                    ),
                    itemBuilder: (context, index) {
                      return ActivityTile(
                        label: 'Label text',
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
