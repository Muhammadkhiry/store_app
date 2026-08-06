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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          product.title,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: ListView(
            children: [
              Text(
                product.category ?? "Unknown category",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                product.description,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.orange),
                  Text(
                    "${product.rating}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 11),
                  Text(
                    product.availabilityStatus ?? "Unknown",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Image.network(
                product.image,
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
              Text(product.title, style: TextStyle(color: Colors.grey)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$${product.price.toStringAsFixed(2)}"),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_shopping_cart),
                  ),
                  IconButton(
                    onPressed: onFavoritePressed,
                    icon: Icon(
                      favorite ? Icons.favorite : Icons.favorite,
                      color: favorite ? Colors.red : Colors.grey,
                    ),
                  ),
                ],
              ),
              Text(
                "Data about the product....",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              Text(
                "${product.discountPercentage?.toStringAsFixed(2) ?? 0}\$ OFF",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              ListTile(
                leading: Icon(Icons.inventory),
                title: Text("Stock"),
                subtitle: Text("${product.stock ?? "Unknown"}item"),
              ),
              ListTile(
                leading: Icon(Icons.workspaces_filled),
                title: Text("Brand"),
                subtitle: Text("${product.brand ?? "Unknown"} "),
              ),
              ListTile(
                leading: Icon(Icons.line_weight),
                title: Text("Weight"),
                subtitle: Text("${product.weight ?? "Unknown"}kg"),
              ),
              Text(
                "dimensions:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${product.height ?? "_"} × ${product.width ?? "_"} × ${product.depth ?? "_"} cm",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
