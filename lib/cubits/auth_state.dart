import 'package:equatable/equatable.dart';
import 'package:projeto_integrador_03/features/auth/domain/entities/operator_entity.dart';

enum AuthStatus { unknown, loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final OperatorEntity? operador;
  final String? error;

  const AuthState._({required this.status, this.operador, this.error});

  const AuthState.unknown() : this._(status: AuthStatus.unknown);
  const AuthState.loading() : this._(status: AuthStatus.loading);
  const AuthState.authenticated(OperatorEntity op)
    : this._(status: AuthStatus.authenticated, operador: op);
  const AuthState.unauthenticated()
    : this._(status: AuthStatus.unauthenticated);
  const AuthState.error(String msg)
    : this._(status: AuthStatus.error, error: msg);

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isLoading => status == AuthStatus.loading;

  @override
  List<Object?> get props => [status, operador, error];
}
