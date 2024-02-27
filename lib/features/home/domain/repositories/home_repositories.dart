import 'package:dartz/dartz.dart';
import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/features/home/home.dart';
import 'package:welltested_annotation/welltested_annotation.dart';

@Welltested()
abstract class HomeRepository {
  Future<Either<Failure, User>> updateProfile({
    required String name,
    String? birthday,
    int? height,
    int? weight,
    List<String>? interests,
  });
}
