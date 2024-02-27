import 'dart:async';

import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/features/auth/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUseCase implements UseCaseFuture<Failure, Register, RegisterParams> {
  RegisterUseCase(this.authRepository);

  final AuthRepository authRepository;

  @override
  FutureOr<Either<Failure, Register>> call(RegisterParams params) async {
    return authRepository.register(
      email: params.email,
      username: params.username,
      password: params.password,
    );
  }
}

class RegisterParams extends Equatable {
  const RegisterParams(
      {required this.email, required this.username, required this.password});

  final String email;
  final String username;
  final String password;

  @override
  List<Object?> get props => [email, username, password];
}
