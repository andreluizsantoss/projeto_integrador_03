import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador_03/app/core/ui/app_colors.dart';
import 'package:projeto_integrador_03/app/core/ui/widgets/app_button.dart';
import 'package:projeto_integrador_03/app/core/utils/responsive_context.dart';
import 'package:projeto_integrador_03/app/presentation/home/widgets/activity_tile.dart';

class MachineSelectionPage extends StatelessWidget {
  const MachineSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final paddingHorizontal = context.responsiveValue<double>(
      mobile: 20.0,
      tablet: 56.0,
    );

    final titleSize = context.responsiveValue<double>(
      mobile: 26.0,
      tablet: 38.0,
    );

    final buttonHeight = context.responsiveValue<double>(
      mobile: 50.0,
      tablet: 64.0,
    );

    final borderRadius = context.responsiveValue<double>(
      mobile: 24.0,
      tablet: 32.0,
    );

    final sectionSpacing = context.responsiveValue<double>(
      mobile: 24.0,
      tablet: 40.0,
    );

    final machines = [
      'Trator',
      'Escavadeira',
      'Colheitadeira',
      'Retroescavadeira',
      'Label text',
      'Label text',
    ];

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
              SizedBox(height: context.responsiveValue<double>(mobile: 16, tablet: 32)),
              
              // Título
              Text(
                'Selecione a Maquina',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: titleSize,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              
              SizedBox(height: sectionSpacing),
              
              // Container da Lista
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      vertical: context.responsiveValue<double>(mobile: 12, tablet: 24),
                    ),
                    itemCount: machines.length,
                    itemBuilder: (context, index) {
                      return ActivityTile(
                        label: machines[index],
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ),
              
              SizedBox(height: sectionSpacing),
              
              // Botões de ação
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'Cancelar',
                        backgroundColor: const Color(0xFFF28B82),
                        onPressed: () => context.pop(),
                        height: buttonHeight,
                        borderRadius: 16,
                      ),
                    ),
                    SizedBox(width: context.responsiveValue<double>(mobile: 16, tablet: 24)),
                    Expanded(
                      child: AppButton(
                        label: 'Continuar',
                        onPressed: () {},
                        height: buttonHeight,
                        borderRadius: 16,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: context.responsiveValue<double>(mobile: 24, tablet: 48)),
            ],
          ),
        ),
      ),
    );
  }
}
