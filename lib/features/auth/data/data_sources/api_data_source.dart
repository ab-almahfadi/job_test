import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/features/auth/auth.dart';
import 'package:dio/dio.dart';
import 'package:youapp_test/features/home/home.dart';

abstract class AuthApiDataSource {
  Future<LoginModel> login({
    required String email,
    required String username,
    required String password,
  });

  Future<RegisterModel> register({
    required String email,
    required String username,
    required String password,
  });

  Future<bool> logout();

  Future<UserModel> profile();
}

class AuthApiDataSourceImpl implements AuthApiDataSource {
  AuthApiDataSourceImpl(
      this.dio, {
        required this.authLocalSource,
      });

  final Dio dio;
  final AuthLocalDataSource authLocalSource;

  @override
  Future<LoginModel> login({
    required String email,
    required String username,
    required String password,
}) async {
    try {
      final response = await dio.post('/login', data: {
        'email' : email,
        'username' : username,
        'password' : password,
      });

      if (response.statusCode == 201){
        await authLocalSource.saveCache(response.data['access_token']);
      }

      return LoginModel.fromJson(response.data);
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<RegisterModel> register({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final response = await dio.post('/register', data: {
        'email' : email,
        'username' : username,
        'password' : password,
      });

      // if (response.statusCode == 200){
      //   await authLocalSource.saveCache(response.data['data']['access_token']);
      // }

      return RegisterModel.fromJson(response.data);
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<bool> logout() async {
    try {
      authLocalSource.clearCache();

      return false;
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<UserModel> profile() async {
    try {
      final response = await dio.get('/getProfile');

      return UserModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }
}
