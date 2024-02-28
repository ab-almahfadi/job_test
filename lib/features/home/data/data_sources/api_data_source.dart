import 'package:dio/dio.dart';
import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/features/home/home.dart';

abstract class HomeApiDataSource {
  Future<UserModel> updateProfile({
    required String name,
    String? birthday,
    int? height,
    String? heightm,
    int? weight,
    String? weightm,
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
    String? heightm,
    int? weight,
    String? weightm,
    List<String>? interests,
  }) async {
    try {
      final response = await dio.put('/updateProfile', data: {
        'name': name,
        "birthday": birthday,
        "height": height,
        "heightm": heightm,
        "weight": weight,
        "weightm": weightm,
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
