import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador_03/core/app_colors.dart';
import 'package:projeto_integrador_03/core/responsive_context.dart';
import 'package:projeto_integrador_03/features/auth/domain/entities/operator_entity.dart';
import 'package:projeto_integrador_03/features/operators/presentation/cubit/operator_cubit.dart';
import 'package:projeto_integrador_03/features/operators/presentation/cubit/operator_state.dart';
import 'package:projeto_integrador_03/views/widgets/app_button.dart';
import 'package:projeto_integrador_03/views/widgets/operator_card.dart';

class OperatorSelectionPage extends StatefulWidget {
  const OperatorSelectionPage({super.key});

  @override
  State<OperatorSelectionPage> createState() => _OperatorSelectionPageState();
}

class _OperatorSelectionPageState extends State<OperatorSelectionPage> {
  @override
  void initState() {
    super.initState();
    context.read<OperatorCubit>().fetchAll();
  }

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
        decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal,
              vertical: context.responsiveValue<double>(
                mobile: 16.0,
                tablet: 32.0,
              ),
            ),
            child: BlocBuilder<OperatorCubit, OperatorState>(
              builder: (context, state) {
                final selected = state is OperatorLoaded
                    ? state.selected
                    : null;

                return Column(
                  children: [
                    SizedBox(
                      height: context.responsiveValue<double>(
                        mobile: 10,
                        tablet: 20,
                      ),
                    ),
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
                    SizedBox(
                      height: context.responsiveValue<double>(
                        mobile: 16,
                        tablet: 32,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: _buildList(context, state, selected),
                      ),
                    ),
                    SizedBox(
                      height: context.responsiveValue<double>(
                        mobile: 24,
                        tablet: 40,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            label: 'Cancelar',
                            backgroundColor: const Color(0xFFF28B82),
                            onPressed: () => context.pop(),
                            height: buttonHeight,
                          ),
                        ),
                        SizedBox(
                          width: context.responsiveValue<double>(
                            mobile: 20,
                            tablet: 40,
                          ),
                        ),
                        Expanded(
                          child: AppButton(
                            label: 'Continuar',
                            onPressed: selected == null
                                ? null
                                : () => context.push('/login'),
                            height: buttonHeight,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: context.responsiveValue<double>(
                        mobile: 8,
                        tablet: 16,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    OperatorState state,
    OperatorEntity? selected,
  ) {
    if (state is OperatorLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is OperatorError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(state.message, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.read<OperatorCubit>().fetchAll(),
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      );
    }
    if (state is OperatorLoaded) {
      if (state.operators.isEmpty) {
        return const Center(child: Text('Nenhum operador encontrado.'));
      }
      return ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        children: state.operators.map((op) {
          final isSelected = selected?.operatorId == op.operatorId;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: OperatorCard(
              label: op.nome,
              onTap: () => context.read<OperatorCubit>().select(op),
            ),
          );
        }).toList(),
      );
    }
    return const SizedBox.shrink();
  }
}
