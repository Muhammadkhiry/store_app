import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_app/cubits/product_cubit/product_cubit.dart';
import 'package:store_app/cubits/product_cubit/product_cubit_states.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/views/selected_product_card.dart';

class DisplayProducts extends StatelessWidget {
  const DisplayProducts({super.key, required this.productList});

  final List<ProductModel> productList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductCubitStates>(
      builder: (context, state) {
        final cubit = context.read<ProductCubit>();

        return Padding(
          padding: const EdgeInsets.only(top: 55),
          child: GridView.builder(
            clipBehavior: Clip.none,
            itemCount: productList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3.3 / 3,
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 45,
            ),
            itemBuilder: (context, index) {
              final product = productList[index];

              final bool isFavorite = cubit.isFavorite(product);

              final bool isInCart = cubit.isInCart(product);

              return Padding(
                padding: const EdgeInsets.all(11),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Card(
                      color: Colors.white,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: const TextStyle(color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "\$${product.price}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                // CART
                                IconButton(
                                  onPressed: () async {
                                    await cubit.toggleCart(product);
                                  },
                                  icon: Icon(
                                    isInCart
                                        ? Icons.shopping_cart
                                        : Icons.add_shopping_cart,
                                    color: isInCart
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                ),

                                // FAVORITE
                                IconButton(
                                  onPressed: () async {
                                    await cubit.toggleFavorite(product);
                                  },
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavorite
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      left: 55,
                      bottom: 105,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SelectedProductCard(
                                  favorite: cubit.isFavorite(product),

                                  onFavoritePressed: () {
                                    cubit.toggleFavorite(product);
                                  },

                                  product: product,
                                );
                              },
                            ),
                          );
                        },
                        child: Image.network(
                          product.thumbnail,
                          height: 115,
                          width: 125,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }

                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
