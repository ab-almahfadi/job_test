import 'package:equatable/equatable.dart';

class Register extends Equatable {
  final String message;

  const Register({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}