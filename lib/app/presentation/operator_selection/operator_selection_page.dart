import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador_03/app/core/ui/app_colors.dart';
import 'package:projeto_integrador_03/app/core/ui/widgets/app_button.dart';
import 'package:projeto_integrador_03/app/presentation/operator_selection/widgets/operator_card.dart';

class OperatorSelectionPage extends StatelessWidget {
  const OperatorSelectionPage({super.key});

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Título conforme imagem
                const Text(
                  'Selecione o Operador',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 16),
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
                      // ... (restante dos cards)
                      children: [
                        OperatorCard(
                          label: 'Label text',
                          icon: Icons.stars_rounded,
                          iconColor: Colors.black54,
                          onTap: () {},
                        ),
                        OperatorCard(
                          label: 'Label text',
                          icon: Icons.stars_rounded,
                          iconColor: Colors.black54,
                          onTap: () {},
                        ),
                        OperatorCard(
                          label: 'Label text',
                          icon: Icons.stars_rounded,
                          iconColor: Colors.black54,
                          onTap: () {},
                        ),
                        OperatorCard(
                          label: 'Label text',
                          icon: Icons.stars_rounded,
                          iconColor: Colors.black54,
                          onTap: () {},
                        ),
                        OperatorCard(
                          label: 'Label text',
                          icon: Icons.stars_rounded,
                          iconColor: Colors.black54,
                          onTap: () {},
                        ),
                        OperatorCard(
                          label: 'Label text',
                          icon: Icons.stars_rounded,
                          iconColor: Colors.black54,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Botões de ação
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botão Cancelar (Agora usando AppButton reutilizável)
                    Expanded(
                      child: AppButton(
                        label: 'Cancelar',
                        backgroundColor: const Color(0xFFF28B82),
                        onPressed: () => context.pop(),
                        height: 56,
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Botão Continuar (Preto - Estilo Premium do projeto)
                    Expanded(
                      child: AppButton(
                        label: 'Continuar',
                        onPressed: () {},
                        width: double.infinity,
                        height: 56,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
