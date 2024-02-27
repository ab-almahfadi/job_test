import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String username;
  final String? name;
  final String? birthday;
  final String? horoscope;
  final String? zodiac;
  final int? height;
  final int? weight;
  final List<String>? interests;

  const User({
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
