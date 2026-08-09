import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/product_cubit/product_cubit.dart';
import 'package:store_app/cubits/product_cubit/product_cubit_states.dart';
import 'package:store_app/views/display_products.dart';

class CartTap extends StatefulWidget {
  const CartTap({super.key});

  @override
  State<CartTap> createState() => _CartTapState();
}

class _CartTapState extends State<CartTap> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductCubitStates>(
      builder: (context, state) {
        final cubit = context.watch<ProductCubit>();

        if (state is LoadingProductsState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (cubit.cartList.isEmpty) {
          return const Center(child: Text("No cart products yet"));
        }

        return DisplayProducts(productList: cubit.cartList);
      },
    );
  }
}
