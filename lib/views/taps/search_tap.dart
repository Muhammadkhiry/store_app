import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_app/cubits/product_cubit/product_cubit.dart';
import 'package:store_app/cubits/product_cubit/product_cubit_states.dart';
import 'package:store_app/views/display_products.dart';
import 'package:store_app/widgets/custom_textfield.dart';

class SearchTap extends StatefulWidget {
  const SearchTap({super.key});

  @override
  State<SearchTap> createState() => _SearchTapState();
}

class _SearchTapState extends State<SearchTap> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductCubitStates>(
      builder: (context, state) {
        final cubit = context.read<ProductCubit>();

        return Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            children: [
              CustomTextField(
                controller: controller,
                onSubmitted: (value) {
                  final query = value.trim();

                  if (query.isNotEmpty) {
                    cubit.getProductsByCategory(categoryTitle: query);
                  }
                },
                label: 'Search by category',
                hint: 'Smartphone',
              ),

              const SizedBox(height: 10),

              Expanded(child: _buildSearchResult(context, state, cubit)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchResult(
    BuildContext context,
    ProductCubitStates state,
    ProductCubit cubit,
  ) {
    // Loading ONLY when we don't already have search results.
    if (state is LoadingProductsState && cubit.categoryProducts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is FailureState) {
      return Center(child: Text(state.message));
    }

    // IMPORTANT:
    // Don't check:
    // state is LoadedCategoryProductsState
    //
    // because CartUpdatedState / FavoriteUpdatedState
    // can come at any time.

    if (cubit.categoryProducts.isEmpty) {
      return const Center(child: Text("Search for a category"));
    }

    return DisplayProducts(productList: cubit.categoryProducts);
  }
}
