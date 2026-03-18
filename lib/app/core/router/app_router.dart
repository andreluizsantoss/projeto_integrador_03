import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador_03/app/core/auth/auth_guard.dart';
import 'package:projeto_integrador_03/app/core/di/injection.dart';
import 'package:projeto_integrador_03/app/presentation/splash/splash_page.dart';
import 'package:projeto_integrador_03/app/presentation/auth/login/login_page.dart';
import 'package:projeto_integrador_03/app/presentation/home/home_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/splash',
  refreshListenable: null,
  redirect: (context, state) => getIt<AuthGuard>().redirect(context, state),
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
  ],
);
