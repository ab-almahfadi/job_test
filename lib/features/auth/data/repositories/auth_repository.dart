import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/features/auth/auth.dart';
import 'package:youapp_test/features/home/home.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
      this.authApiDataSource
      );

  final AuthApiDataSource authApiDataSource;

  @override
  Future<Either<Failure, Login>> login({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final result = await authApiDataSource.login(
        email: email,
        username: username,
        password: password,
      );

      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, Register>> register({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final result = await authApiDataSource.register(
        email: email,
        username: username,
        password: password,
      );

      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, User>> profile() async {
    try {
      final result = await authApiDataSource.profile();

      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }
}