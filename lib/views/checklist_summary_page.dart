import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador_03/core/app_colors.dart';
import 'package:projeto_integrador_03/core/responsive_context.dart';
import 'package:projeto_integrador_03/core/utils/app_loading_overlay.dart';
import 'package:projeto_integrador_03/core/utils/app_messages.dart';
import 'package:projeto_integrador_03/cubits/auth_cubit.dart';
import 'package:projeto_integrador_03/cubits/checklist_cubit.dart';
import 'package:projeto_integrador_03/cubits/checklist_state.dart';
import 'package:projeto_integrador_03/features/history/presentation/cubit/history_cubit.dart';
import 'package:projeto_integrador_03/views/widgets/app_button.dart';

class ChecklistSummaryPage extends StatelessWidget {
  const ChecklistSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChecklistCubit, ChecklistState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          AppLoadingOverlay.show(context);
        } else {
          AppLoadingOverlay.hide(context);
        }
        if (state.isSubmitSuccess) {
          final operatorId = context
              .read<AuthCubit>()
              .state
              .operador
              ?.operatorId;
          context.read<HistoryCubit>().fetchAll(operatorId: operatorId);
          context.read<ChecklistCubit>().reset();
          AppMessages.showSuccess(context, 'Dados salvos com sucesso!');
          context.go('/');
        } else if (state.error != null && !state.isSubmitting) {
          AppMessages.showError(context, state.error!);
        }
      },
      builder: (context, state) {
        final padH = context.responsiveValue<double>(
          mobile: 20.0,
          tablet: 40.0,
        );
        final padTop = context.responsiveValue<double>(
          mobile: 16.0,
          tablet: 32.0,
        );
        final cardPad = context.responsiveValue<double>(
          mobile: 22.0,
          tablet: 36.0,
        );
        final borderRadius = context.responsiveValue<double>(
          mobile: 24.0,
          tablet: 32.0,
        );
        final btnH = context.responsiveValue<double>(
          mobile: 52.0,
          tablet: 64.0,
        );

        final now = DateTime.now();
        final data =
            '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
        final percentual = state.completionPercent();

        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundGradient,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: padTop),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: padH),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(cardPad),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  'CHECK LIST',
                                  style: TextStyle(
                                    fontSize: context.responsiveValue<double>(
                                      mobile: 20.0,
                                      tablet: 28.0,
                                    ),
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '$percentual%',
                                  style: TextStyle(
                                    fontSize: context.responsiveValue<double>(
                                      mobile: 20.0,
                                      tablet: 28.0,
                                    ),
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: context.responsiveValue<double>(
                                mobile: 20.0,
                                tablet: 32.0,
                              ),
                            ),
                            _InfoRow(
                              label: 'Operador:',
                              valor: state.operatorName.isEmpty
                                  ? '—'
                                  : state.operatorName,
                            ),
                            _InfoRow(
                              label: 'Maquina:',
                              valor: state.machineName.isEmpty
                                  ? '—'
                                  : state.machineName,
                            ),
                            _InfoRow(label: 'Data:', valor: data),
                            SizedBox(
                              height: context.responsiveValue<double>(
                                mobile: 24.0,
                                tablet: 40.0,
                              ),
                            ),
                            _SecaoNivelRow(
                              label: 'Segurança',
                              nivel: state.sectionLevel('seguranca'),
                            ),
                            _SecaoNivelRow(
                              label: 'Motor',
                              nivel: state.sectionLevel('motor'),
                            ),
                            _SecaoNivelRow(
                              label: 'Estrutura',
                              nivel: state.sectionLevel('estrutura'),
                            ),
                            _SecaoNivelRow(
                              label: 'Elétrica',
                              nivel: state.sectionLevel('eletrica'),
                            ),
                            _SecaoNivelRow(
                              label: 'Funcionamento',
                              nivel: state.sectionLevel('funcionamento'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.responsiveValue<double>(
                      mobile: 16.0,
                      tablet: 32.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padH),
                    child: AppButton(
                      label: 'Confirmar',
                      onPressed: () => context.read<ChecklistCubit>().submit(),
                      height: btnH,
                      borderRadius: 16,
                    ),
                  ),
                  SizedBox(
                    height: context.responsiveValue<double>(
                      mobile: 24.0,
                      tablet: 48.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String valor;

  const _InfoRow({required this.label, required this.valor});

  @override
  Widget build(BuildContext context) {
    final fontSize = context.responsiveValue<double>(
      mobile: 17.0,
      tablet: 22.0,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            valor,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _SecaoNivelRow extends StatelessWidget {
  final String label;
  final String nivel;

  const _SecaoNivelRow({required this.label, required this.nivel});

  @override
  Widget build(BuildContext context) {
    final labelSize = context.responsiveValue<double>(
      mobile: 15.0,
      tablet: 20.0,
    );
    final pilSize = context.responsiveValue<double>(mobile: 13.0, tablet: 17.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: labelSize,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              nivel,
              style: TextStyle(
                fontSize: pilSize,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
