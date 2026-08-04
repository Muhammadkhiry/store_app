import 'package:dio/dio.dart';
import 'package:store_app/models/product_model.dart';

class AddNewProduct {
  final Dio dio;

  AddNewProduct({required this.dio});

  Future<ProductModel> addNewProduct({
    required String title,
    required double price,
    required String description,
    required String image,
    required String category,
  }) async {
    try {
      final response = await dio.post(
        "https://dummyjson.com/products/add",
        data: {
          "title": title,
          "price": price,
          "description": description,
          "thumbnail": image,
          "category": category,
        },
      );

      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
