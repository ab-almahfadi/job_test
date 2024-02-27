import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/features/home/home.dart';

class UpdateProfileUseCase
    implements UseCaseFuture<Failure, User, UpdateProfileParams> {
  UpdateProfileUseCase(this.homeRepository);

  final HomeRepository homeRepository;

  @override
  FutureOr<Either<Failure, User>> call(UpdateProfileParams params) async {
    return homeRepository.updateProfile(
      name: params.name,
      birthday: params.birthday,
      height: params.height,
      weight: params.weight,
      interests: params.interests,
    );
  }
}

class UpdateProfileParams extends Equatable {
  const UpdateProfileParams(
      {required this.name,
      this.birthday,
      this.height,
      this.weight,
      this.interests});

  final String name;
  final String? birthday;
  final int? height;
  final int? weight;
  final List<String>? interests;

  @override
  List<Object?> get props => [
        name,
        birthday,
        height,
        weight,
        interests,
      ];
}
