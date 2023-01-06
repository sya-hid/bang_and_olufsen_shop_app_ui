import '../models/cart_model.dart';
import '../models/product_model.dart';
import 'package:bloc/bloc.dart';

class CartProvider extends Cubit<List<CartModel>> {
  CartProvider() : super([]);
  cartExist(ProductModel product) {
    if (state.indexWhere((element) => element.product == product) == -1) {
      return false;
    } else {
      return true;
    }
  }

  addCart(ProductModel product, int quantity) {
    List<CartModel> carts = [...state];
    if (cartExist(product)) {
      int index = carts.indexWhere((element) => element.product == product);
      carts[index].quantity = carts[index].quantity + quantity;
    } else {
      carts.add(CartModel(product: product, quantity: quantity));
    }
    emit(carts);
  }

  addQuantity(ProductModel product) {
    List<CartModel> carts = [...state];
    int index = carts.indexWhere((element) => element.product == product);
    carts[index].quantity++;
    emit(carts);
  }

  reduceQuantity(ProductModel product) {
    List<CartModel> carts = [...state];
    int index = carts.indexWhere((element) => element.product == product);
    if (carts[index].quantity > 1) {
      carts[index].quantity--;
    }
    emit(carts);
  }

  removeCart(ProductModel product) {
    List<CartModel> carts = [...state];
    carts.removeWhere((element) => element.product == product);
    emit(carts);
  }

  getTotal() {
    double total = 0;
    for (var element in state) {
      total += element.product.price * element.quantity;
    }
    return total;
  }
}
