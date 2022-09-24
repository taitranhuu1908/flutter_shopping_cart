import 'package:flutter/widgets.dart';
import '../model/product.dart';

class CartProvider with ChangeNotifier {
  int _counter = 0;
  int _quantity = 1;
  int get counter => _counter;
  int get quantity => _quantity;
  num _totalPrice = 0.0;
  num get totalPrice => _totalPrice;

  List<Product> cart = [];

  void addCart(Product product) {
    if (cart.contains(product)) {
      product.quantity = product.quantity! + 1;
    } else {
      cart.add(product);
      _counter++;
      product.quantity = _quantity;
      _totalPrice += (product.price!);
      notifyListeners();
    }
  }

  List getCartList() {
    return cart;
  }

  int getCounter() {
    return _counter;
  }

  void decrementQuantity(int index) {
    if (cart[index].quantity! > 1) {
      cart[index].quantity = cart[index].quantity! - 1;
      _totalPrice -= (cart[index].price!);
      notifyListeners();
    }
  }

  void incrementQuantity(int index) {
    cart[index].quantity = cart[index].quantity! + 1;
    _totalPrice += (cart[index].price!);
    notifyListeners();
  }

  void removeCart(int index) {
    _totalPrice -= (cart[index].price!) * cart[index].quantity!;
    cart.removeAt(index);
    _counter--;
    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    _counter = 0;
    _totalPrice = 0.0;
    notifyListeners();
  }
}
