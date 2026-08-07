import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_app/models/product_model.dart';

final CollectionReference products = FirebaseFirestore.instance.collection(
  "products",
);
final CollectionReference favorites = FirebaseFirestore.instance.collection(
  "favorite",
);
final CollectionReference cart = FirebaseFirestore.instance.collection(
  "cart_products",
);

class FirestoreService {
  Future<void> addProduct(ProductModel product) async {
    await products.add(product.toJson());
  }

  Future<List<ProductModel>> getProducts() async {
    QuerySnapshot snapshot = await products.get();

    return snapshot.docs.map((doc) {
      return ProductModel.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<void> addToFav(ProductModel product) async {
    await favorites.doc(product.id.toString()).set(product.toJson());
  }

  Future<void> removeFromFav(ProductModel product) async {
    await favorites.doc(product.id.toString()).delete();
  }

  Future<List<ProductModel>> getAllFav() async {
    QuerySnapshot snapshot = await favorites.get();

    List<ProductModel> favs = snapshot.docs.map((doc) {
      return ProductModel.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();

    return favs;
  }

  Future<void> addToCart(ProductModel product) async {
    await cart.doc(product.id.toString()).set(product.toJson());
  }

  Future<void> removeFromCart(ProductModel product) async {
    await cart.doc(product.id.toString()).delete();
  }

  Future<List<ProductModel>> getAllCart() async {
    QuerySnapshot snapshot = await cart.get();

    List<ProductModel> cartProducts = snapshot.docs.map((doc) {
      return ProductModel.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();

    return cartProducts;
  }
}
