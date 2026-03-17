import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../auth/auth_guard.dart';
import '../di/injection.dart';
import '../../presentation/splash/splash_page.dart';
import '../../presentation/auth/login/login_page.dart';
import '../../presentation/home/home_page.dart';

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
