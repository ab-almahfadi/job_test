import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String email;
  final String username;
  final String? name;
  final String? birthday;
  final String? horoscope;
  final String? zodiac;
  final int? height;
  final int? weight;
  final List<String>? interests;

  const UserModel({
    required this.email,
    required this.username,
    this.name,
    this.birthday,
    this.horoscope,
    this.zodiac,
    this.height,
    this.weight,
    this.interests,
  });

  User toEntity() {
    return User(
      email: email,
      username: username,
      name: name,
      birthday: birthday,
      horoscope: horoscope,
      zodiac: zodiac,
      height: height,
      weight: weight,
      interests: interests,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
    email,
    username,
    name,
    birthday,
    horoscope,
    zodiac,
    height,
    weight,
    interests,
  ];
}
