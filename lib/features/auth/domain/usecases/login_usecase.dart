import 'dart:async';

import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/features/auth/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginUseCase implements UseCaseFuture<Failure, Login, LoginParams> {
  LoginUseCase(this.authRepository);

  final AuthRepository authRepository;

  @override
  FutureOr<Either<Failure, Login>> call(LoginParams params) async {
    return authRepository.login(
      email: params.email,
      username: params.username,
      password: params.password,
    );
  }
}

class LoginParams extends Equatable {
  const LoginParams(
      {required this.email, required this.username, required this.password});

  final String email;
  final String username;
  final String password;

  @override
  List<Object?> get props => [email, username, password];
}
