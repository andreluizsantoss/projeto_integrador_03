import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador_03/core/app_colors.dart';
import 'package:projeto_integrador_03/core/responsive_context.dart';
import 'package:projeto_integrador_03/features/checklist/domain/entities/checklist_detail_entity.dart';
import 'package:projeto_integrador_03/views/widgets/app_button.dart';
import '../cubit/checklist_detail_cubit.dart';
import '../cubit/checklist_detail_state.dart';

class ChecklistDetailPage extends StatelessWidget {
  const ChecklistDetailPage({super.key});

  static String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso).toLocal();
      final d = dt.day.toString().padLeft(2, '0');
      final m = dt.month.toString().padLeft(2, '0');
      final y = dt.year.toString();
      final h = dt.hour.toString().padLeft(2, '0');
      final min = dt.minute.toString().padLeft(2, '0');
      return '$d/$m/$y  $h:$min';
    } catch (_) {
      return iso;
    }
  }

  @override
  Widget build(BuildContext context) {
    final padH = context.responsiveValue<double>(mobile: 20.0, tablet: 40.0);
    final padTop = context.responsiveValue<double>(mobile: 16.0, tablet: 32.0);
    final borderRadius = context.responsiveValue<double>(
      mobile: 24.0,
      tablet: 32.0,
    );
    final titleSize = context.responsiveValue<double>(
      mobile: 26.0,
      tablet: 38.0,
    );
    final btnH = context.responsiveValue<double>(mobile: 52.0, tablet: 64.0);
    final spacing = context.responsiveValue<double>(mobile: 20.0, tablet: 32.0);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: BlocBuilder<ChecklistDetailCubit, ChecklistDetailState>(
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(height: padTop),
                  Text(
                    'Detalhes do Checklist',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: titleSize,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spacing),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: padH),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      child: _buildContent(context, state),
                    ),
                  ),
                  SizedBox(height: spacing),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padH),
                    child: AppButton(
                      label: 'Voltar',
                      backgroundColor: const Color(0xFFF28B82),
                      onPressed: () => context.pop(),
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
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ChecklistDetailState state) {
    if (state is ChecklistDetailLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is ChecklistDetailError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Erro ao carregar detalhes',
                style: TextStyle(
                  fontSize: context.responsiveValue<double>(
                    mobile: 16.0,
                    tablet: 20.0,
                  ),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                state.message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      );
    }
    if (state is ChecklistDetailLoaded) {
      return _buildDetail(context, state.detail);
    }
    return const SizedBox.shrink();
  }

  Widget _buildDetail(BuildContext context, ChecklistDetailEntity detail) {
    final cardPad = context.responsiveValue<double>(mobile: 20.0, tablet: 32.0);
    final labelSize = context.responsiveValue<double>(
      mobile: 15.0,
      tablet: 20.0,
    );
    final sectionTitleSize = context.responsiveValue<double>(
      mobile: 14.0,
      tablet: 18.0,
    );
    final itemSize = context.responsiveValue<double>(
      mobile: 13.0,
      tablet: 17.0,
    );
    final spacing = context.responsiveValue<double>(mobile: 12.0, tablet: 20.0);

    return SingleChildScrollView(
      padding: EdgeInsets.all(cardPad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header info
          _InfoChip(
            icon: Icons.person_outline,
            label: 'Operador',
            value: detail.operatorName,
            labelSize: labelSize,
          ),
          SizedBox(height: spacing * 0.6),
          _InfoChip(
            icon: Icons.precision_manufacturing_outlined,
            label: 'Máquina',
            value: detail.machineName.toUpperCase(),
            labelSize: labelSize,
          ),
          SizedBox(height: spacing * 0.6),
          _InfoChip(
            icon: Icons.calendar_today_outlined,
            label: 'Data',
            value: _formatDate(detail.data),
            labelSize: labelSize,
          ),
          SizedBox(height: spacing),
          Divider(color: Colors.black.withValues(alpha: 0.08), thickness: 1),
          SizedBox(height: spacing * 0.5),
          // Sections by category
          ...detail.categories.map(
            (cat) => _CategorySection(
              category: cat,
              answers: detail.answersByCategory(cat),
              sectionTitleSize: sectionTitleSize,
              itemSize: itemSize,
              spacing: spacing,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final double labelSize;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.labelSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: labelSize * 1.2, color: Colors.black54),
        SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: labelSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: labelSize,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}

class _CategorySection extends StatelessWidget {
  final String category;
  final List<ChecklistAnswerEntity> answers;
  final double sectionTitleSize;
  final double itemSize;
  final double spacing;

  const _CategorySection({
    required this.category,
    required this.answers,
    required this.sectionTitleSize,
    required this.itemSize,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: spacing * 0.5),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: context.responsiveValue<double>(
              mobile: 8.0,
              tablet: 12.0,
            ),
          ),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            category,
            style: TextStyle(
              fontSize: sectionTitleSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
        SizedBox(height: spacing * 0.4),
        ...answers.map(
          (answer) =>
              _AnswerRow(answer: answer, itemSize: itemSize, spacing: spacing),
        ),
      ],
    );
  }
}

class _AnswerRow extends StatelessWidget {
  final ChecklistAnswerEntity answer;
  final double itemSize;
  final double spacing;

  const _AnswerRow({
    required this.answer,
    required this.itemSize,
    required this.spacing,
  });

  Color _statusColor(int statusId) {
    switch (statusId) {
      case 1:
        return AppColors.primary;
      case 2:
        return const Color(0xFFD32F2F);
      case 3:
        return const Color(0xFFE65100);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final badgeColor = _statusColor(answer.statusId);

    return Padding(
      padding: EdgeInsets.only(bottom: spacing * 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  answer.itemDescription,
                  style: TextStyle(
                    fontSize: itemSize,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  answer.statusDescription,
                  style: TextStyle(
                    fontSize: itemSize * 0.85,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          if (answer.observation != null && answer.observation!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                'Obs: ${answer.observation}',
                style: TextStyle(
                  fontSize: itemSize * 0.9,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          Divider(
            color: Colors.black.withValues(alpha: 0.06),
            thickness: 1,
            height: spacing * 0.8,
          ),
        ],
      ),
    );
  }
}
