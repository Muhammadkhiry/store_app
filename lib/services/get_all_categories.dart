import 'package:dio/dio.dart';

class GetAllCategories {
  final Dio dio = Dio();

  Future<List<String>> getAllCategories() async {
    try {
      final response = await dio.get(
        "https://dummyjson.com/products/category-list",
      );

      return List<String>.from(response.data);
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
