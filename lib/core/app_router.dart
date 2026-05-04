import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador_03/core/auth_guard.dart';
import 'package:projeto_integrador_03/core/injection.dart';
import 'package:projeto_integrador_03/features/checklist/presentation/cubit/checklist_detail_cubit.dart';
import 'package:projeto_integrador_03/features/checklist/presentation/pages/checklist_detail_page.dart';
import 'package:projeto_integrador_03/views/splash_page.dart';
import 'package:projeto_integrador_03/views/login_page.dart';
import 'package:projeto_integrador_03/views/home_page.dart';
import 'package:projeto_integrador_03/views/operator_selection_page.dart';
import 'package:projeto_integrador_03/views/machine_selection_page.dart';
import 'package:projeto_integrador_03/views/checklist_fuel_page.dart';
import 'package:projeto_integrador_03/views/checklist_safety_page.dart';
import 'package:projeto_integrador_03/views/checklist_engine_structure_page.dart';
import 'package:projeto_integrador_03/views/checklist_electrical_operation_page.dart';
import 'package:projeto_integrador_03/views/checklist_summary_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/splash',
  refreshListenable: null,
  redirect: (context, state) => getIt<AuthGuard>().redirect(context, state),
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/operator-selection',
      builder: (context, state) => const OperatorSelectionPage(),
    ),
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(
      path: '/machine-selection',
      builder: (context, state) => const MachineSelectionPage(),
    ),
    GoRoute(
      path: '/checklist/combustivel',
      builder: (context, state) => const ChecklistFuelPage(),
    ),
    GoRoute(
      path: '/checklist/seguranca',
      builder: (context, state) => const ChecklistSafetyPage(),
    ),
    GoRoute(
      path: '/checklist/motor-estrutura',
      builder: (context, state) => const ChecklistEngineStructurePage(),
    ),
    GoRoute(
      path: '/checklist/eletrica-funcionamento',
      builder: (context, state) => const ChecklistElectricalOperationPage(),
    ),
    GoRoute(
      path: '/checklist/resumo',
      builder: (context, state) => const ChecklistSummaryPage(),
    ),
    GoRoute(
      path: '/checklist/detalhe/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return BlocProvider(
          create: (_) => getIt<ChecklistDetailCubit>()..fetchById(id),
          child: const ChecklistDetailPage(),
        );
      },
    ),
  ],
);
