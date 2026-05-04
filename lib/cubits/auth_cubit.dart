import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_integrador_03/core/rest_client/rest_client_exception.dart';
import 'package:projeto_integrador_03/features/auth/domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const AuthState.unknown());

  Future<void> login({required int operatorId, required int pin}) async {
    emit(const AuthState.loading());
    try {
      final operator = await _authRepository.login(
        operatorId: operatorId,
        pin: pin,
      );
      emit(AuthState.authenticated(operator));
    } catch (e) {
      emit(AuthState.error(_errorMessage(e)));
    }
  }

  void logout() => emit(const AuthState.unauthenticated());

  String _errorMessage(dynamic e) {
    if (e is RestClientException) return e.displayMessage;
    return 'Erro ao realizar login';
  }
}
