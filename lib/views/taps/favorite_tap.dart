import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/product_cubit/product_cubit.dart';
import 'package:store_app/cubits/product_cubit/product_cubit_states.dart';
import 'package:store_app/views/display_products.dart';

class FavoriteTap extends StatelessWidget {
  const FavoriteTap({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductCubitStates>(
      builder: (context, state) {
        if (state is LoadingProductsState) {
          return Center(child: CircularProgressIndicator());
        } else {
          return BlocProvider.of<ProductCubit>(context).favoriteList.isNotEmpty
              ? DisplayProducts(
                  productList: BlocProvider.of<ProductCubit>(
                    context,
                  ).favoriteList,
                )
              : Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 151, horizontal: 9),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "There is no chosen favorite products yet",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
        }
      },
    );
  }
}
