import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/product_cubit/product_cubit.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/views/selected_product_card.dart';

class DisplayProducts extends StatefulWidget {
  const DisplayProducts({super.key, required this.productList});
  final List<ProductModel> productList;

  @override
  State<DisplayProducts> createState() => _DisplayProductsState();
}

class _DisplayProductsState extends State<DisplayProducts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 55),
      child: GridView.builder(
        clipBehavior: Clip.none,
        itemCount: widget.productList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3.3 / 3,
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 45,
        ),
        itemBuilder: (BuildContext context, int index) {
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
                          widget.productList[index].title,
                          style: TextStyle(color: Colors.grey),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "\$${widget.productList[index].price}",
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<ProductCubit>().toggleCart(
                                  widget.productList[index],
                                );
                              },
                              icon: Icon(
                                Icons.add_shopping_cart,
                                color: Colors.grey,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<ProductCubit>().toggleFavorite(
                                  widget.productList[index],
                                );
                              },
                              icon: Icon(
                                context.watch<ProductCubit>().isFavorite(
                                      widget.productList[index],
                                    )
                                    ? Icons.favorite
                                    : Icons.favorite,
                                color:
                                    context.watch<ProductCubit>().isFavorite(
                                      widget.productList[index],
                                    )
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
                              favorite: context
                                  .watch<ProductCubit>()
                                  .isFavorite(widget.productList[index]),
                              onFavoritePressed: () {},
                              product: widget.productList[index],
                            );
                          },
                        ),
                      );
                    },
                    child: Image.network(
                      widget.productList[index].thumbnail,
                      height: 115,
                      width: 125,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const Center(child: CircularProgressIndicator());
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
  }
}
