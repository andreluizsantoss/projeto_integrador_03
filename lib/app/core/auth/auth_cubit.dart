import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState.unknown());

  void checkAuth() {
    // Simulação de verificação de token/sessão
    emit(const AuthState.unauthenticated());
  }

  void login(String email) {
    emit(AuthState.authenticated(email));
  }

  void logout() {
    emit(const AuthState.unauthenticated());
  }
}
