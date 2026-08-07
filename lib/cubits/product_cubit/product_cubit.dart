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
import 'package:store_app/services/update_product.dart';

class ProductCubit extends Cubit<ProductCubitStates> {
  ProductCubit() : super(InitialProductsState());

  List<ProductModel> apiProducts = [];
  List<ProductModel> firestoreProducts = [];
  List<ProductModel> allProducts = [];
  List<ProductModel> favoriteList = [];
  List<ProductModel> cartList = [];
  List<String> categoriesList = [];
  List<ProductModel> categoryProducts = [];
  late StreamSubscription favSubscription;
  late StreamSubscription cartSubscription;
  final Dio dio = Dio();
  void listenToFavorites() {
    favSubscription = FirebaseFirestore.instance
        .collection("favorite")
        .snapshots()
        .listen((snapshot) {
          favoriteList = snapshot.docs
              .map((e) => ProductModel.fromFirestore(e.data()))
              .toList();

          emit(FavoriteUpdatedState(favoriteList: favoriteList));
        });
  }

  void listenToCart() {
    cartSubscription = FirebaseFirestore.instance
        .collection("cart_products")
        .snapshots()
        .listen((snapshot) {
          cartList = snapshot.docs
              .map((e) => ProductModel.fromFirestore(e.data()))
              .toList();

          emit(CartUpdatedState(cartList));
        });
  }

  @override
  Future<void> close() {
    favSubscription.cancel();
    cartSubscription.cancel();
    return super.close();
  }

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

  void getAllCategories() async {
    try {
      categoriesList = await GetAllCategories(dio: dio).getAllCategories();
      emit(LoadedCategoriesState(categoriesList: categoriesList));
    } on Exception catch (e) {
      emit(FailureState(e.toString()));
    }
  }

  void getProductsByCategory({required String categoryTitle}) async {
    try {
      categoryProducts = await GetProductsByCategory(
        dio: dio,
      ).getProductsByCategory(categoryTitle: categoryTitle);
      emit(LoadedCategoryProductsState(categoryProducts: categoryProducts));
    } on Exception catch (e) {
      emit(FailureState(e.toString()));
    }
  }

  Future<void> addProduct(ProductModel product) async {
    emit(LoadingProductsState());
    try {
      await FirestoreService().addProduct(product);
      emit(LoadedProductsState(productsList: allProducts));
    } catch (e) {
      emit(FailureState(e.toString()));
    }
  }

  Future<void> toggleFavorite(ProductModel product) async {
    if (favoriteList.any((item) => item.id == product.id)) {
      await FirestoreService().removeFromFav(product);
    } else {
      await FirestoreService().addToFav(product);
    }
    favoriteList = await FirestoreService().getAllFav();
    emit(FavoriteUpdatedState(favoriteList: favoriteList));
    emit(LoadedProductsState(productsList: allProducts));
  }

  bool isFavorite(ProductModel product) {
    return favoriteList.any((item) => item.id == product.id);
  }

  Future<List<ProductModel>> getAllFav() async {
    favoriteList = await FirestoreService().getAllFav();
    return favoriteList;
  }

  Future<void> toggleCart(ProductModel product) async {
    if (cartList.any((item) => item.id == product.id)) {
      await FirestoreService().removeFromCart(product);
    } else {
      await FirestoreService().addToCart(product);
    }
    favoriteList = await FirestoreService().getAllCart();
    emit(LoadedProductsState(productsList: allProducts));
  }

  Future<List<ProductModel>> getAllCart() async {
    cartList = await FirestoreService().getAllCart();
    return cartList;
  }

  bool isInCart(ProductModel product) {
    return cartList.any((item) => item.id == product.id);
  }

  void updateProduct({required ProductModel product}) async {
    try {
      ProductModel updated = await UpdateProduct(
        dio: dio,
      ).updateProduct(product: product);
      allProducts[product.id] = updated;
      emit(LoadedProductsState(productsList: allProducts));
      emit(ProductUpdatedState(model: product));
    } on Exception catch (e) {
      emit(FailureState(e.toString()));
    }
  }
}
