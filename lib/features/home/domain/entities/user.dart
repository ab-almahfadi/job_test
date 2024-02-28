import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class User extends Equatable {
  final String email;
  final String username;
  final String? name;
  final String? birthday;
  final String? horoscope;
  final String? zodiac;
  final int? height;
  final String? heightm;
  final int? weight;
  final String? weightm;
  final List<String>? interests;
  final ImagePicker? picker;

  const User({
    required this.email,
    required this.username,
    this.name,
    this.birthday,
    this.horoscope,
    this.zodiac,
    this.height,
    this.heightm,
    this.weight,
    this.weightm,
    this.interests,
    this.picker,
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
        heightm,
        weight,
        weightm,
        interests,
      ];

  
}
