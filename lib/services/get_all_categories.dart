import 'package:dio/dio.dart';
import 'package:store_app/const.dart';

class GetAllCategories {
  final Dio dio;

  GetAllCategories({required this.dio});

  Future<List<String>> getAllCategories() async {
    try {
      final response = await dio.get(
        "$baseUrl/products/category-list",
      );

      return List<String>.from(response.data);
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
