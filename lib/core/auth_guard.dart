import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador_03/cubits/auth_cubit.dart';
import 'package:projeto_integrador_03/cubits/auth_state.dart';

class AuthGuard {
  final AuthCubit _authCubit;

  AuthGuard(this._authCubit);

  static const _publicRoutes = {'/splash', '/operator-selection', '/login'};

  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    final authState = _authCubit.state;
    final location = state.matchedLocation;
    final isPublic = _publicRoutes.contains(location);

    if (authState.status == AuthStatus.unknown ||
        authState.status == AuthStatus.loading) {
      return null;
    }

    if (authState.status == AuthStatus.unauthenticated ||
        authState.status == AuthStatus.error) {
      return isPublic ? null : '/operator-selection';
    }

    if (authState.status == AuthStatus.authenticated) {
      if (location == '/login' || location == '/operator-selection') {
        return '/';
      }
      return null;
    }

    return null;
  }
}
