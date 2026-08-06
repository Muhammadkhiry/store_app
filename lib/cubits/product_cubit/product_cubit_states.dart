import 'package:store_app/models/product_model.dart';

class ProductCubitStates {
  ProductCubitStates();
}

class InitialProductsState extends ProductCubitStates {}

class LoadingProductsState extends ProductCubitStates {}

class LoadedProductsState extends ProductCubitStates {
  final List<ProductModel> productsList;

  LoadedProductsState({required this.productsList});
}

class LoadedCategoriesState extends ProductCubitStates {
  final List<String> categoriesList;

  LoadedCategoriesState({required this.categoriesList});
}

class LoadedCategoryProductsState extends ProductCubitStates {
  final List<ProductModel> categoryProducts;

  LoadedCategoryProductsState({required this.categoryProducts});
}

class FavoriteUpdatedState extends ProductCubitStates {
  final List<ProductModel> favoriteList;

  FavoriteUpdatedState({
    required this.favoriteList,
  });
}

class ProductUpdatedState extends ProductCubitStates {
  final ProductModel model;

  ProductUpdatedState({required this.model});
}

class FailureState extends ProductCubitStates {
  final String message;

  FailureState(this.message);
}
