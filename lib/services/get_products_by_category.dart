import 'package:dio/dio.dart';
import 'package:store_app/const.dart';
import 'package:store_app/models/product_model.dart';

class GetProductsByCategory {
  final Dio dio;

  GetProductsByCategory({required this.dio});

  Future<List<ProductModel>> getProductsByCategory({
    required String categoryTitle,
  }) async {
    try {
      final response = await dio.get(
        "$baseUrl/products/category/$categoryTitle",
      );

      final List<dynamic> responseData = response.data["products"];

      return responseData
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
