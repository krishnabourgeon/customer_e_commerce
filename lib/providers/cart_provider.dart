import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

/// Holds the in-memory shopping cart state for the session.
/// No persistence/backend — purely for UI demonstration purposes.
class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);

  double get total => subtotal;

  bool get isEmpty => _items.isEmpty;

  /// Returns the quantity of [product] currently in the cart (0 if absent).
  int quantityOf(Product product) {
    final existing = _items.where((i) => i.product.id == product.id);
    return existing.isEmpty ? 0 : existing.first.quantity;
  }

  void addProduct(Product product, {int quantity = 1}) {
    final index = _items.indexWhere((i) => i.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void decrementProduct(Product product) {
    final index = _items.indexWhere((i) => i.product.id == product.id);
    if (index < 0) return;
    if (_items[index].quantity > 1) {
      _items[index].quantity -= 1;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void removeProduct(Product product) {
    _items.removeWhere((i) => i.product.id == product.id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
