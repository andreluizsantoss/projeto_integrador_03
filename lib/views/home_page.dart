import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador_03/core/app_colors.dart';
import 'package:projeto_integrador_03/core/responsive_context.dart';
import 'package:projeto_integrador_03/cubits/auth_cubit.dart';
import 'package:projeto_integrador_03/features/history/domain/entities/history_entity.dart';
import 'package:projeto_integrador_03/features/history/presentation/cubit/history_cubit.dart';
import 'package:projeto_integrador_03/features/history/presentation/cubit/history_state.dart';
import 'package:projeto_integrador_03/views/widgets/activity_tile.dart';
import 'package:projeto_integrador_03/views/widgets/app_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    final operatorId = context.read<AuthCubit>().state.operador?.operatorId;
    context.read<HistoryCubit>().fetchAll(operatorId: operatorId);
  }

  static String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso).toLocal();
      final d = dt.day.toString().padLeft(2, '0');
      final m = dt.month.toString().padLeft(2, '0');
      final y = dt.year.toString();
      final h = dt.hour.toString().padLeft(2, '0');
      final min = dt.minute.toString().padLeft(2, '0');
      final s = dt.second.toString().padLeft(2, '0');
      return '$d/$m/$y $h:$min:$s';
    } catch (_) {
      return iso;
    }
  }

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
        decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: paddingHorizontal,
                  vertical: context.responsiveValue<double>(
                    mobile: 8,
                    tablet: 24,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: context.responsiveValue<double>(
                        mobile: 32,
                        tablet: 56,
                      ),
                      fit: BoxFit.contain,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.logout,
                        color: Colors.black,
                        size: context.responsiveValue<double>(
                          mobile: 28,
                          tablet: 44,
                        ),
                      ),
                      onPressed: () {
                        context.read<AuthCubit>().logout();
                        context.go('/operator-selection');
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: sectionSpacing),
              // Status Card
              BlocBuilder<HistoryCubit, HistoryState>(
                builder: (context, state) {
                  final count = state is HistoryLoaded
                      ? state.checklists.length
                      : null;

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: paddingHorizontal,
                    ),
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
                              fontSize: context.responsiveValue<double>(
                                mobile: 18,
                                tablet: 28,
                              ),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: context.responsiveValue<double>(
                              mobile: 8,
                              tablet: 16,
                            ),
                          ),
                          count == null
                              ? const CircularProgressIndicator()
                              : Text(
                                  '$count',
                                  style: TextStyle(
                                    fontSize: context.responsiveValue<double>(
                                      mobile: 40,
                                      tablet: 72,
                                    ),
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  );
                },
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
                        onPressed: _loadHistory,
                        height: buttonHeight,
                        borderRadius: borderRadius,
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
                        label: 'Check List',
                        onPressed: () => context.push('/machine-selection'),
                        height: buttonHeight,
                        borderRadius: borderRadius,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: context.responsiveValue<double>(mobile: 24, tablet: 48),
              ),
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
                  child: BlocBuilder<HistoryCubit, HistoryState>(
                    builder: (context, state) {
                      if (state is HistoryLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is HistoryError) {
                        return Center(
                          child: Text(
                            state.message,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      if (state is HistoryLoaded) {
                        return _buildHistoryList(
                          context,
                          state.checklists,
                          borderRadius,
                        );
                      }
                      return const SizedBox.shrink();
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

  Widget _buildHistoryList(
    BuildContext context,
    List<HistoryEntity> checklists,
    double borderRadius,
  ) {
    if (checklists.isEmpty) {
      return const Center(child: Text('Nenhum checklist realizado.'));
    }
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        vertical: context.responsiveValue<double>(mobile: 16, tablet: 32),
      ),
      itemCount: checklists.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.black.withValues(alpha: 0.05),
        indent: 16,
        endIndent: 16,
      ),
      itemBuilder: (context, index) {
        final h = checklists[index];
        return ActivityTile(
          label:
              '${h.machineName} — ${h.operatorName} — ${_formatDate(h.data)}',
          onTap: () {},
        );
      },
    );
  }
}
