import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador_03/core/app_colors.dart';
import 'package:projeto_integrador_03/core/responsive_context.dart';
import 'package:projeto_integrador_03/cubits/checklist_cubit.dart';
import 'package:projeto_integrador_03/cubits/checklist_state.dart';
import 'package:projeto_integrador_03/features/items/domain/entities/checklist_item_entity.dart';
import 'package:projeto_integrador_03/views/widgets/app_button.dart';

class ChecklistElectricalOperationPage extends StatelessWidget {
  const ChecklistElectricalOperationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChecklistCubit, ChecklistState>(
      builder: (context, state) {
        final cubit = context.read<ChecklistCubit>();
        final itensEletrica = state.itemsByCategory('eletrica');
        final itensFuncionamento = state.itemsByCategory('funcionamento');
        final nivelEletrica = state.sectionLevel('eletrica');
        final nivelFunc = state.sectionLevel('funcionamento');
        final nivelGeral = _combinedLevel(nivelEletrica, nivelFunc);

        final padH = context.responsiveValue<double>(
          mobile: 20.0,
          tablet: 40.0,
        );
        final padTop = context.responsiveValue<double>(
          mobile: 16.0,
          tablet: 32.0,
        );
        final cardPad = context.responsiveValue<double>(
          mobile: 20.0,
          tablet: 32.0,
        );
        final borderRadius = context.responsiveValue<double>(
          mobile: 24.0,
          tablet: 32.0,
        );
        final btnH = context.responsiveValue<double>(
          mobile: 52.0,
          tablet: 64.0,
        );
        final titleSize = context.responsiveValue<double>(
          mobile: 22.0,
          tablet: 30.0,
        );
        final labelSize = context.responsiveValue<double>(
          mobile: 13.0,
          tablet: 17.0,
        );
        final itemSize = context.responsiveValue<double>(
          mobile: 14.0,
          tablet: 18.0,
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
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: padH),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          cardPad,
                          cardPad,
                          cardPad,
                          cardPad * 0.5,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SectionHeader(
                              titulo: 'ELÉTRICA',
                              titleSize: titleSize,
                              labelSize: labelSize,
                            ),
                            const SizedBox(height: 8),
                            const Divider(height: 1, color: Color(0xFFE0E0E0)),
                            const SizedBox(height: 4),
                            Expanded(
                              child: ListView(
                                children: [
                                  ...itensEletrica.map(
                                    (item) => _ChecklistItemRow(
                                      item: item,
                                      statusAtual: state.statusOf(item.itemId),
                                      onTap: (statusId) => cubit.setAnswer(
                                        item.itemId,
                                        statusId,
                                      ),
                                      fontSize: itemSize,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  _SectionHeader(
                                    titulo: 'FUNCIONAMENTO',
                                    titleSize: titleSize,
                                    labelSize: labelSize,
                                  ),
                                  const SizedBox(height: 8),
                                  const Divider(
                                    height: 1,
                                    color: Color(0xFFE0E0E0),
                                  ),
                                  const SizedBox(height: 4),
                                  ...itensFuncionamento.map(
                                    (item) => _ChecklistItemRow(
                                      item: item,
                                      statusAtual: state.statusOf(item.itemId),
                                      onTap: (statusId) => cubit.setAnswer(
                                        item.itemId,
                                        statusId,
                                      ),
                                      fontSize: itemSize,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  _StatusSection(nivel: nivelGeral),
                                  const SizedBox(height: 8),
                                ],
                              ),
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
                      onPressed:
                          state.isCategoryComplete('eletrica') &&
                              state.isCategoryComplete('funcionamento')
                          ? () => context.push('/checklist/resumo')
                          : null,
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

  String _combinedLevel(String a, String b) {
    if (a == 'Não Conforme' || b == 'Não Conforme') return 'Não Conforme';
    if (a == 'Precisa Manutenção' || b == 'Precisa Manutenção') {
      return 'Precisa Manutenção';
    }
    if (a == 'Conforme' && b == 'Conforme') return 'Conforme';
    return 'Nivel de situação';
  }
}

class _SectionHeader extends StatelessWidget {
  final String titulo;
  final double titleSize;
  final double labelSize;

  const _SectionHeader({
    required this.titulo,
    required this.titleSize,
    required this.labelSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              titulo,
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
          ),
        ),
        for (final label in ['[S]', '[N]', '[A]'])
          SizedBox(
            width: 36,
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: labelSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ChecklistItemRow extends StatelessWidget {
  final ChecklistItemEntity item;
  final int? statusAtual;
  final void Function(int statusId) onTap;
  final double fontSize;

  const _ChecklistItemRow({
    required this.item,
    required this.statusAtual,
    required this.onTap,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              item.description,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
          _AvaliacaoCheckbox(
            selected: statusAtual == kStatusCompliant,
            onTap: () => onTap(kStatusCompliant),
          ),
          _AvaliacaoCheckbox(
            selected: statusAtual == kStatusNonCompliant,
            onTap: () => onTap(kStatusNonCompliant),
          ),
          _AvaliacaoCheckbox(
            selected: statusAtual == kStatusNeedsMaintenance,
            onTap: () => onTap(kStatusNeedsMaintenance),
          ),
        ],
      ),
    );
  }
}

class _AvaliacaoCheckbox extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;

  const _AvaliacaoCheckbox({required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 36,
        height: 36,
        child: Center(
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: selected ? AppColors.primary : const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(4),
            ),
            child: selected
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
          ),
        ),
      ),
    );
  }
}

class _StatusSection extends StatelessWidget {
  final String nivel;

  const _StatusSection({required this.nivel});

  @override
  Widget build(BuildContext context) {
    final statusSize = context.responsiveValue<double>(
      mobile: 20.0,
      tablet: 26.0,
    );
    final pilSize = context.responsiveValue<double>(mobile: 14.0, tablet: 18.0);

    return Column(
      children: [
        Text(
          'STATUS',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: statusSize,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
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
        ),
      ],
    );
  }
}
