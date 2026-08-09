import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_app/cubits/product_cubit/product_cubit.dart';
import 'package:store_app/cubits/product_cubit/product_cubit_states.dart';
import 'package:store_app/views/display_products.dart';

class HomeTap extends StatelessWidget {
  const HomeTap({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductCubitStates>(
      builder: (context, state) {
        final cubit = context.read<ProductCubit>();

        if (state is LoadingProductsState && cubit.allProducts.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FailureState) {
          return Center(child: Text(state.message));
        }

        if (cubit.allProducts.isEmpty) {
          return const Center(child: Text("No products found"));
        }

        return DisplayProducts(productList: cubit.allProducts);
      },
    );
  }
}
