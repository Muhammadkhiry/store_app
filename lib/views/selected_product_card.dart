import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';

// ignore: must_be_immutable
class SelectedProductCard extends StatelessWidget {
  const SelectedProductCard({
    super.key,
    required this.favorite,
    required this.onFavoritePressed,
    required this.product,
  });

  final bool favorite;
  final VoidCallback onFavoritePressed;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                Text(product.title, style: TextStyle(color: Colors.grey)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$${product.price}"),
                    IconButton(
                      onPressed: onFavoritePressed,
                      icon: Icon(
                        favorite ? Icons.favorite : Icons.favorite,
                        color: favorite ? Colors.red : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -35,
          left: 0,
          right: 0,
          child: Image.network(
            product.image,
            height: 115,
            width: 125,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.broken_image,
                size: 80,
                color: Colors.grey,
              );
            },
          ),
        ),
      ],
    );
  }
}
