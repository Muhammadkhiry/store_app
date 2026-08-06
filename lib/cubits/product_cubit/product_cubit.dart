import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:store_app/cubits/product_cubit/product_cubit_states.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/add_new_product.dart';
import 'package:store_app/services/get_all_categories.dart';
import 'package:store_app/services/get_all_products.dart';
import 'package:store_app/services/get_products_by_category.dart';
import 'package:store_app/services/update_product.dart';

class ProductCubit extends Cubit<ProductCubitStates> {
  ProductCubit() : super(InitialProductsState());

  List<ProductModel> productsList = [];
  List<ProductModel> favoriteList = [];
  List<String> categoriesList = [];
  List<ProductModel> categoryProducts = [];
  final Dio dio = Dio();

  Future<void> getAllProducts() async {
    emit(LoadingProductsState());
    try {
      productsList = await GetAllProducts(dio: dio).getAllProducts();
      emit(LoadedProductsState(productsList: productsList));
    } on Exception catch (e) {
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

  void addNewProduct(ProductModel newProduct) async {
    try {
      ProductModel model = await AddNewProduct(dio: dio).addNewProduct(
        title: newProduct.title,
        price: newProduct.price.toString(),
        description: newProduct.description,
        image: newProduct.image,
        category: newProduct.category!,
      );
      productsList.add(model);
      emit(LoadedProductsState(productsList: productsList));
    } on Exception catch (e) {
      emit(FailureState(e.toString()));
    }
  }

  void toggleFavorite(ProductModel product) {
    if (favoriteList.any((item) => item.id == product.id)) {
      favoriteList.removeWhere((item) => item.id == product.id);
    } else {
      favoriteList.add(product);
    }

    emit(FavoriteUpdatedState(favoriteList: List.from(favoriteList)));
  }

  void updateProduct({required ProductModel product}) async {
    try {
      ProductModel updated = await UpdateProduct(
        dio: dio,
      ).updateProduct(product: product);
      productsList[product.id] = updated;
      emit(LoadedProductsState(productsList: productsList));
      emit(ProductUpdatedState(model: product));
    } on Exception catch (e) {
      emit(FailureState(e.toString()));
    }
  }
}
