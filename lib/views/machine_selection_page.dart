import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador_03/core/app_colors.dart';
import 'package:projeto_integrador_03/core/responsive_context.dart';
import 'package:projeto_integrador_03/cubits/auth_cubit.dart';
import 'package:projeto_integrador_03/cubits/auth_state.dart';
import 'package:projeto_integrador_03/cubits/checklist_cubit.dart';
import 'package:projeto_integrador_03/features/machines/domain/entities/machine_entity.dart';
import 'package:projeto_integrador_03/features/machines/presentation/cubit/machine_cubit.dart';
import 'package:projeto_integrador_03/features/machines/presentation/cubit/machine_state.dart';
import 'package:projeto_integrador_03/core/utils/app_loading_overlay.dart';
import 'package:projeto_integrador_03/views/widgets/app_button.dart';
import 'package:projeto_integrador_03/views/widgets/activity_tile.dart';

class MachineSelectionPage extends StatefulWidget {
  const MachineSelectionPage({super.key});

  @override
  State<MachineSelectionPage> createState() => _MachineSelectionPageState();
}

class _MachineSelectionPageState extends State<MachineSelectionPage> {
  @override
  void initState() {
    super.initState();
    context.read<MachineCubit>().fetchAll();
  }

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

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: BlocBuilder<MachineCubit, MachineState>(
            builder: (context, state) {
              final selected = state is MachineLoaded ? state.selected : null;

              return Column(
                children: [
                  SizedBox(
                    height: context.responsiveValue<double>(
                      mobile: 16,
                      tablet: 32,
                    ),
                  ),
                  Text(
                    'Selecione a Máquina',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: titleSize,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: sectionSpacing),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: paddingHorizontal,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: _buildList(context, state, selected),
                    ),
                  ),
                  SizedBox(height: sectionSpacing),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: paddingHorizontal,
                    ),
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
                        SizedBox(
                          width: context.responsiveValue<double>(
                            mobile: 16,
                            tablet: 24,
                          ),
                        ),
                        Expanded(
                          child: AppButton(
                            label: 'Continuar',
                            onPressed: selected == null
                                ? null
                                : () => _startChecklist(context, selected),
                            height: buttonHeight,
                            borderRadius: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.responsiveValue<double>(
                      mobile: 24,
                      tablet: 48,
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

  void _startChecklist(BuildContext context, MachineEntity machine) {
    final authState = context.read<AuthCubit>().state;
    if (authState.status != AuthStatus.authenticated ||
        authState.operador == null) {
      return;
    }
    AppLoadingOverlay.show(context);
    context.read<ChecklistCubit>().start(authState.operador!, machine);
    context.push('/checklist/combustivel');
  }

  Widget _buildList(
    BuildContext context,
    MachineState state,
    MachineEntity? selected,
  ) {
    if (state is MachineLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is MachineError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(state.message, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.read<MachineCubit>().fetchAll(),
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      );
    }
    if (state is MachineLoaded) {
      if (state.machines.isEmpty) {
        return const Center(child: Text('Nenhuma máquina encontrada.'));
      }
      return ListView.builder(
        padding: EdgeInsets.symmetric(
          vertical: context.responsiveValue<double>(mobile: 12, tablet: 24),
        ),
        itemCount: state.machines.length,
        itemBuilder: (context, index) {
          final machine = state.machines[index];
          final isSelected = selected?.machineId == machine.machineId;
          return Container(
            color: isSelected
                ? AppColors.secondary.withValues(alpha: 0.25)
                : Colors.transparent,
            child: ActivityTile(
              label: machine.machineName,
              onTap: () => context.read<MachineCubit>().select(machine),
            ),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }
}
