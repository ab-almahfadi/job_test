import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final String message;
  final String accessToken;

  const Login({
    required this.message,
    required this.accessToken,
});

  @override
  List<Object?> get props => [message, accessToken];
}