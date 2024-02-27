import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  const Failure({
    required this.message,
    this.code,
    this.errorCode,
  });

  final String message;

  final Object? code;

  final String? errorCode;

  @override
  List<Object?> get props => [message, code, errorCode];
}
