import 'package:dartz/dartz.dart';
import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/features/home/home.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this.homeApiDataSource);

  final HomeApiDataSource homeApiDataSource;

  @override
  Future<Either<Failure, User>> updateProfile({
    required String name,
    String? birthday,
    int? height,
    int? weight,
    List<String>? interests,
  }) async {
    try {
      final result = await homeApiDataSource.updateProfile(
        name: name,
        birthday: birthday,
        height: height,
        weight: weight,
        interests: interests
      );

      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }
}