import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/get_all_products.dart';
import 'package:store_app/views/display_products.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  late Future<List<ProductModel>> future;
  @override
  void initState() {
    super.initState();
    future = GetAllProducts(dio: Dio()).getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: future,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
            if (snapshot.hasData) {
              return DisplayProducts(productList: snapshot.data!);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
    );
  }
}
