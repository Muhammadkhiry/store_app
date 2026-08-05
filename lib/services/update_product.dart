import 'package:dio/dio.dart';
import 'package:store_app/const.dart';
import 'package:store_app/models/product_model.dart';

class UpdateProduct {
  final Dio dio;

  UpdateProduct({required this.dio});

  Future<ProductModel> updateProduct({required ProductModel product}) async {
    try {
      final response = await dio.put(
        "$baseUrl/products/${product.id}",
        data: {
          "title": product.title,
          "price": product.price,
          "description": product.description,
          "thumbnail": product.image,
          "category": product.category,
        },
      );

      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
