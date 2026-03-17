import 'package:equatable/equatable.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final String? userEmail;

  const AuthState._({
    required this.status,
    this.userEmail,
  });

  const AuthState.unknown() : this._(status: AuthStatus.unknown);
  
  const AuthState.authenticated(String email)
      : this._(status: AuthStatus.authenticated, userEmail: email);
      
  const AuthState.unauthenticated() : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [status, userEmail];
}
