part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginAuthEvent extends AuthEvent {
  final LoginParams params;

  const LoginAuthEvent(
      {required this.params});

  @override
  List<Object> get props => [params];
}

class RegisterAuthEvent extends AuthEvent {
  final RegisterParams params;

  const RegisterAuthEvent({required this.params});

  @override
  List<Object> get props => [params];
}

class LogoutAuthEvent extends AuthEvent {}

class ProfileAuthEvent extends AuthEvent {}
