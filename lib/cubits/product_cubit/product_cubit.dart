import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_app/cubits/product_cubit/product_cubit_states.dart';
import 'package:store_app/firestore/firestore_service.dart';
import 'package:store_app/models/product_model.dart';

import 'package:store_app/services/get_all_categories.dart';
import 'package:store_app/services/get_all_products.dart';
import 'package:store_app/services/get_products_by_category.dart';

class ProductCubit extends Cubit<ProductCubitStates> {
  ProductCubit() : super(InitialProductsState()) {
    listenToFavorites();
    listenToCart();
  }

  List<ProductModel> apiProducts = [];
  List<ProductModel> firestoreProducts = [];
  List<ProductModel> allProducts = [];

  List<ProductModel> favoriteList = [];
  List<ProductModel> cartList = [];

  List categoriesList = [];
  List<ProductModel> categoryProducts = [];

  late StreamSubscription favSubscription;
  late StreamSubscription cartSubscription;

  final Dio dio = Dio();

  // ============================================================
  // FAVORITES STREAM
  // ============================================================

  void listenToFavorites() {
    favSubscription = FirebaseFirestore.instance
        .collection("favorite")
        .snapshots()
        .listen((snapshot) {
          favoriteList = snapshot.docs
              .map((doc) => ProductModel.fromFirestore(doc.data()))
              .toList();

          emit(FavoriteUpdatedState(favoriteList: favoriteList));
        });
  }

  // ============================================================
  // CART STREAM
  // ============================================================

  void listenToCart() {
    cartSubscription = FirebaseFirestore.instance
        .collection("cart_products")
        .snapshots()
        .listen((snapshot) {
          cartList = snapshot.docs
              .map((doc) => ProductModel.fromFirestore(doc.data()))
              .toList();

          emit(CartUpdatedState(cartList));
        });
  }

  // ============================================================
  // CLOSE
  // ============================================================

  @override
  Future<void> close() {
    favSubscription.cancel();
    cartSubscription.cancel();

    return super.close();
  }

  // ============================================================
  // GET ALL PRODUCTS
  // ============================================================

  Future<void> getAllProducts() async {
    emit(LoadingProductsState());

    try {
      apiProducts = await GetAllProducts(dio: dio).getAllProducts();

      firestoreProducts = await FirestoreService().getProducts();

      allProducts = [...apiProducts, ...firestoreProducts];

      emit(LoadedProductsState(productsList: allProducts));
    } catch (e) {
      emit(FailureState(e.toString()));
    }
  }

  // ============================================================
  // CATEGORIES
  // ============================================================

  Future<void> getAllCategories() async {
    try {
      categoriesList = await GetAllCategories(dio: dio).getAllCategories();

      emit(LoadedCategoriesState(categoriesList: categoriesList as List<String>));
    } catch (e) {
      emit(FailureState(e.toString()));
    }
  }

  // ============================================================
  // SEARCH BY CATEGORY
  // ============================================================

  Future<List<ProductModel>> getProductsByCategory({
    required String categoryTitle,
  }) async {
    emit(LoadingProductsState());

    try {
      categoryProducts = await GetProductsByCategory(
        dio: dio,
      ).getProductsByCategory(categoryTitle: categoryTitle);

      emit(LoadedCategoryProductsState(categoryProducts: categoryProducts));
    } catch (e) {
      emit(FailureState(e.toString()));
    }

    return categoryProducts;
  }

  // ============================================================
  // ADD PRODUCT
  // ============================================================

  Future<void> addProduct(ProductModel product) async {
    try {
      await FirestoreService().addProduct(product);

      firestoreProducts.add(product);
      allProducts.add(product);

      emit(LoadedProductsState(productsList: allProducts));
    } catch (e) {
      emit(FailureState(e.toString()));
    }
  }

  // ============================================================
  // FAVORITE
  // ============================================================

  Future<void> toggleFavorite(ProductModel product) async {
    if (isFavorite(product)) {
      await FirestoreService().removeFromFav(product);
    } else {
      await FirestoreService().addToFav(product);
    }

    // IMPORTANT:
    // لا تعمل emit هنا.
    //
    // Firestore stream هيتعامل مع التحديث
    // ويعمل emit لـ FavoriteUpdatedState.
  }

  bool isFavorite(ProductModel product) {
    return favoriteList.any((item) => item.id == product.id);
  }

  // ============================================================
  // CART
  // ============================================================

  Future<void> toggleCart(ProductModel product) async {
    if (isInCart(product)) {
      await FirestoreService().removeFromCart(product);
    } else {
      await FirestoreService().addToCart(product);
    }

    // IMPORTANT:
    // لا تعمل emit هنا.
    //
    // Firestore stream هيعمل emit لـ CartUpdatedState.
  }

  bool isInCart(ProductModel product) {
    return cartList.any((item) => item.id == product.id);
  }
}
