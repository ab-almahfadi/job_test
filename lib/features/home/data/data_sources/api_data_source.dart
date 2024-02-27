import 'package:dio/dio.dart';
import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/features/home/home.dart';

abstract class HomeApiDataSource {
  Future<UserModel> updateProfile({
    required String name,
    String? birthday,
    int? height,
    int? weight,
    List<String>? interests,
  });
}

class HomeApiDataSourceImpl implements HomeApiDataSource {
  HomeApiDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<UserModel> updateProfile({
    required String name,
    String? birthday,
    int? height,
    int? weight,
    List<String>? interests,
  }) async {
    try {
      final response = await dio.put('/updateProfile', data: {
        'name': name,
        "birthday": birthday,
        "height": height,
        "weight": weight,
        "interests": interests,
      });

      return UserModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }
}
