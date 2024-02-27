import 'package:youapp_test/features/auth/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

@JsonSerializable()
class RegisterModel extends Equatable {
  final String message;

  const RegisterModel({
    required this.message,
  });

  Register toEntity() {
    return Register(
      message: message,
    );
  }

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);

  @override
  List<Object?> get props => [message];
}
