import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador_03/cubits/auth_cubit.dart';
import 'package:projeto_integrador_03/cubits/auth_state.dart';

class AuthGuard {
  final AuthCubit _authCubit;

  AuthGuard(this._authCubit);

  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    final authState = _authCubit.state;
    final bool isLoggingIn = state.matchedLocation == '/login';

    if (authState.status == AuthStatus.unauthenticated) {
      // Se não estiver autenticado e não estiver na tela de login, manda para o login
      return isLoggingIn ? null : '/login';
    }

    if (authState.status == AuthStatus.authenticated) {
      // Se estiver autenticado e tentar ir para o login, manda para a home
      return isLoggingIn ? '/' : null;
    }

    // Se o status for unknown (ex: carregando sessão), podemos retornar null
    // e deixar uma Splash mostrar um loading (definido na rota de Splash)
    return null;
  }
}
