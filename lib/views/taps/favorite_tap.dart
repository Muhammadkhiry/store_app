import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/product_cubit/product_cubit.dart';
import 'package:store_app/cubits/product_cubit/product_cubit_states.dart';
import 'package:store_app/views/display_products.dart';

class FavoriteTap extends StatefulWidget {
  const FavoriteTap({super.key});

  @override
  State<FavoriteTap> createState() => _FavoriteTapState();
}

class _FavoriteTapState extends State<FavoriteTap> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getAllFav();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductCubitStates>(
      builder: (context, state) {
        final cubit = context.watch<ProductCubit>();

        if (state is LoadingProductsState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (cubit.favoriteList.isEmpty) {
          return const Center(child: Text("No favorite products yet"));
        }

        return DisplayProducts(productList: cubit.favoriteList);
      },
    );
  }
}
