import 'package:youapp_test/features/auth/auth.dart';
import 'package:dio/dio.dart';

/// Error handling when error in interceptor about authentication
class AuthHttpInterceptor extends InterceptorsWrapper {
  AuthHttpInterceptor(this.authLocalSource);

  /// Repository to get data current token
  final AuthLocalDataSource authLocalSource;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await authLocalSource.getData();

    final optionHeaders = <String, Object>{};

    if (token != null) {
      optionHeaders.putIfAbsent('x-access-token', () => token);
    }

    options.headers.addAll(optionHeaders);
    handler.next(options);
  }
}
