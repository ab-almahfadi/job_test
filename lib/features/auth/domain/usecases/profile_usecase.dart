import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/features/auth/auth.dart';
import 'package:youapp_test/features/home/home.dart';

class ProfileUseCase implements UseCaseFuture<Failure, User, NoParams> {
  ProfileUseCase(this.authRepository);

  final AuthRepository authRepository;

  @override
  FutureOr<Either<Failure, User>> call(NoParams params) async {
    return authRepository.profile();
  }
}
