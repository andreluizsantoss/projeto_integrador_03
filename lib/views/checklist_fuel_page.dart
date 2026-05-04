import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador_03/core/app_colors.dart';
import 'package:projeto_integrador_03/core/responsive_context.dart';
import 'package:projeto_integrador_03/cubits/checklist_cubit.dart';
import 'package:projeto_integrador_03/core/utils/app_loading_overlay.dart';
import 'package:projeto_integrador_03/cubits/checklist_state.dart';
import 'package:projeto_integrador_03/views/widgets/app_button.dart';

class ChecklistFuelPage extends StatefulWidget {
  const ChecklistFuelPage({super.key});

  @override
  State<ChecklistFuelPage> createState() => _ChecklistFuelPageState();
}

class _ChecklistFuelPageState extends State<ChecklistFuelPage> {
  @override
  void initState() {
    super.initState();
    // Cobre o caso raro em que os itens já carregaram antes do listener estar ativo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (!context.read<ChecklistCubit>().state.isLoadingItens) {
        AppLoadingOverlay.hide(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChecklistCubit, ChecklistState>(
      listener: (context, state) {
        if (!state.isLoadingItens) {
          AppLoadingOverlay.hide(context);
        }
      },
      builder: (context, state) {
        final cubit = context.read<ChecklistCubit>();

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
        final titleSize = context.responsiveValue<double>(
          mobile: 26.0,
          tablet: 38.0,
        );
        final labelSize = context.responsiveValue<double>(
          mobile: 18.0,
          tablet: 24.0,
        );
        final chipSize = context.responsiveValue<double>(
          mobile: 15.0,
          tablet: 20.0,
        );
        final itemSize = context.responsiveValue<double>(
          mobile: 18.0,
          tablet: 24.0,
        );
        final btnH = context.responsiveValue<double>(
          mobile: 52.0,
          tablet: 64.0,
        );
        final spacing = context.responsiveValue<double>(
          mobile: 20.0,
          tablet: 32.0,
        );

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
                  Text(
                    'Check List',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: titleSize,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: spacing),
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
                            // Operador
                            Row(
                              children: [
                                Text(
                                  'Operador:',
                                  style: TextStyle(
                                    fontSize: labelSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const Spacer(),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: context.responsiveValue<double>(
                                      mobile: 150.0,
                                      tablet: 220.0,
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD9D9D9),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            state.operatorName.isEmpty
                                                ? 'Operador'
                                                : state.operatorName,
                                            style: TextStyle(
                                              fontSize: chipSize,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 18,
                                          color: Colors.black54,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spacing),
                            // Maquina
                            Row(
                              children: [
                                Text(
                                  'Maquina:',
                                  style: TextStyle(
                                    fontSize: labelSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const Spacer(),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: context.responsiveValue<double>(
                                      mobile: 150.0,
                                      tablet: 220.0,
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD9D9D9),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      state.machineName.isEmpty
                                          ? 'MÁQUINA'
                                          : state.machineName.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: chipSize,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        letterSpacing: 1,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spacing),
                            // Combustivel header
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Combustivel:',
                                    style: TextStyle(
                                      fontSize: labelSize * 0.92,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    state.fuelLabel(),
                                    style: TextStyle(
                                      fontSize: labelSize * 0.92,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: spacing),
                            // Cheio = kStatusCompliant (1)
                            _RadioItem(
                              label: 'Cheio',
                              selected: state.fuelStatus() == kStatusCompliant,
                              onTap: () => cubit.setFuelLevel(kStatusCompliant),
                              fontSize: itemSize,
                            ),
                            SizedBox(
                              height: context.responsiveValue<double>(
                                mobile: 14.0,
                                tablet: 20.0,
                              ),
                            ),
                            // Medio = kStatusNeedsMaintenance (3)
                            _RadioItem(
                              label: 'Medio',
                              selected:
                                  state.fuelStatus() == kStatusNeedsMaintenance,
                              onTap: () =>
                                  cubit.setFuelLevel(kStatusNeedsMaintenance),
                              fontSize: itemSize,
                            ),
                            SizedBox(
                              height: context.responsiveValue<double>(
                                mobile: 14.0,
                                tablet: 20.0,
                              ),
                            ),
                            // Vazio = kStatusNonCompliant (2)
                            _RadioItem(
                              label: 'Vazio',
                              selected:
                                  state.fuelStatus() == kStatusNonCompliant,
                              onTap: () =>
                                  cubit.setFuelLevel(kStatusNonCompliant),
                              fontSize: itemSize,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: spacing),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padH),
                    child: AppButton(
                      label: 'Continuar',
                      onPressed: state.fuelLevel == null
                          ? null
                          : () => context.push('/checklist/seguranca'),
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

class _RadioItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final double fontSize;

  const _RadioItem({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: selected ? AppColors.primary : const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(5),
            ),
            child: selected
                ? const Icon(Icons.check, size: 18, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 16),
          Text(
            label,
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
