import 'dart:async';

import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/features/auth/auth.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase implements UseCaseFuture<Failure, bool, NoParams> {
  LogoutUseCase(this.authRepository);

  final AuthRepository authRepository;

  @override
  FutureOr<Either<Failure, bool>> call(NoParams params) async {
    return authRepository.logout();
  }
}
