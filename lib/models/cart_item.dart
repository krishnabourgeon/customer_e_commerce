import 'product.dart';

/// Represents a single line item inside the shopping cart.
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.effectivePrice * quantity;
}
