import 'package:dio/dio.dart';
import 'package:store_app/models/product_model.dart';

class GetAllProducts {
  final dio = Dio();
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await dio.get("https://dummyjson.com/products");
      final List<dynamic> responseData = response.data["products"];
      List<ProductModel> products = responseData
          .map((e) => ProductModel.fromJson(e))
          .toList();
      return products;
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
