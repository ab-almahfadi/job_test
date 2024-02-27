import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/features/auth/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:youapp_test/features/home/home.dart';
import 'package:welltested_annotation/welltested_annotation.dart';

@Welltested()
abstract class AuthRepository {
  Future<Either<Failure, Login>> login({
    required String email,
    required String username,
    required String password,
  });

  Future<Either<Failure, Register>> register({
    required String email,
    required String username,
    required String password,
  });

  Future<Either<Failure, bool>> logout();

  Future<Either<Failure, User>> profile();
}
