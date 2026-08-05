import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';

class DisplayProducts extends StatefulWidget {
  const DisplayProducts({super.key, required this.productList});
  final List<ProductModel> productList;

  @override
  State<DisplayProducts> createState() => _DisplayProductsState();
}

class _DisplayProductsState extends State<DisplayProducts> {
  late List<bool> favorites;
  ProductModel? selectedProduct;

  @override
  void initState() {
    super.initState();

    favorites = List.generate(widget.productList.length, (_) => false);
  }

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
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedProduct = widget.productList[index];
                });
              },
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
                              Text("\$${widget.productList[index].price}"),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    favorites[index] = !favorites[index];
                                  });
                                },
                                icon: Icon(
                                  favorites[index]
                                      ? Icons.favorite
                                      : Icons.favorite,
                                  color: favorites[index]
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
                    child: Image.network(
                      widget.productList[index].image,
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
