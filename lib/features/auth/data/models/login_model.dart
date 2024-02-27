import 'package:youapp_test/features/auth/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends Equatable {
  final String message;
  final String access_token;

  const LoginModel({
    required this.message,
    required this.access_token,
  });

  Login toEntity() {
    return Login(
      message: message,
      accessToken: access_token,
    );
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  @override
  List<Object?> get props => [message, access_token];
}
