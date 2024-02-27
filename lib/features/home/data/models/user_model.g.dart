// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'] as String,
      username: json['username'] as String,
      name: json['name'] as String?,
      birthday: json['birthday'] as String?,
      horoscope: json['horoscope'] as String?,
      zodiac: json['zodiac'] as String?,
      height: json['height'] as int?,
      weight: json['weight'] as int?,
      interests: (json['interests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'username': instance.username,
      'name': instance.name,
      'birthday': instance.birthday,
      'horoscope': instance.horoscope,
      'zodiac': instance.zodiac,
      'height': instance.height,
      'weight': instance.weight,
      'interests': instance.interests,
    };
