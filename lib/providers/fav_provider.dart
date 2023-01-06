import '../models/product_model.dart';
import 'package:bloc/bloc.dart';

class FavoriteProvider extends Cubit<List<ProductModel>> {
  FavoriteProvider() : super([]);

  favorite(ProductModel product) {
    List<ProductModel> favorites = [...state];
    if (isFav(product)) {
      favorites.remove(product);
    } else {
      favorites.add(product);
    }
    emit(favorites);
  }

  isFav(ProductModel product) {
    if (state.indexWhere((element) => element == product) == -1) {
      return false;
    } else {
      return true;
    }
  }
}
