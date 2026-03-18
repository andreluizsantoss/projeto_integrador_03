import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador_03/app/core/ui/app_colors.dart';
import 'package:projeto_integrador_03/app/core/ui/widgets/app_button.dart';
import 'package:projeto_integrador_03/app/core/utils/responsive_context.dart';
import 'package:projeto_integrador_03/app/presentation/operator_selection/widgets/operator_card.dart';

class OperatorSelectionPage extends StatelessWidget {
  const OperatorSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final paddingHorizontal = context.responsiveValue<double>(
      mobile: 24.0,
      tablet: 60.0,
    );

    final titleFontSize = context.responsiveValue<double>(
      mobile: 28.0,
      tablet: 36.0,
    );

    final buttonHeight = context.responsiveValue<double>(
      mobile: 56.0,
      tablet: 64.0,
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal,
              vertical: context.responsiveValue<double>(mobile: 16.0, tablet: 32.0),
            ),
            child: Column(
              children: [
                SizedBox(height: context.responsiveValue<double>(mobile: 10, tablet: 20)),
                // Título responsivo
                Text(
                  'Selecione o Operador',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: context.responsiveValue<double>(mobile: 16, tablet: 32)),
                // Container com borda preta
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      children: [
                        OperatorCard(
                          label: 'Label text',
                          onTap: () {},
                        ),
                        OperatorCard(
                          label: 'Label text',
                          onTap: () {},
                        ),
                        OperatorCard(
                          label: 'Label text',
                          onTap: () {},
                        ),
                        OperatorCard(
                          label: 'Label text',
                          onTap: () {},
                        ),
                        OperatorCard(
                          label: 'Label text',
                          onTap: () {},
                        ),
                        OperatorCard(
                          label: 'Label text',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: context.responsiveValue<double>(mobile: 24, tablet: 40)),
                // Botões de ação responsivos
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'Cancelar',
                        backgroundColor: const Color(0xFFF28B82),
                        onPressed: () => context.pop(),
                        height: buttonHeight,
                      ),
                    ),
                    SizedBox(width: context.responsiveValue<double>(mobile: 20, tablet: 40)),
                    Expanded(
                      child: AppButton(
                        label: 'Continuar',
                        onPressed: () {},
                        height: buttonHeight,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.responsiveValue<double>(mobile: 8, tablet: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
