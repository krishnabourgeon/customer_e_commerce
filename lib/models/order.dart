import 'cart_item.dart';

/// Lifecycle status of an order.
enum OrderStatus { placed, confirmed, preparing, outForDelivery, delivered, cancelled }

extension OrderStatusX on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.placed:
        return 'Order Placed';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.outForDelivery:
        return 'Out For Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}

/// Represents a placed order, including items and delivery status.
class Order {
  final String id;
  final String storeName;
  final String storeImageUrl;
  final List<CartItem> items;
  final double total;
  final DateTime placedAt;
  final OrderStatus status;
  final String deliveryAddress;

  const Order({
    required this.id,
    required this.storeName,
    required this.storeImageUrl,
    required this.items,
    required this.total,
    required this.placedAt,
    required this.status,
    required this.deliveryAddress,
  });

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  /// Ordered list of statuses representing the full timeline, used to
  /// determine which steps are complete vs pending in the UI.
  static const List<OrderStatus> timelineSteps = [
    OrderStatus.placed,
    OrderStatus.confirmed,
    OrderStatus.preparing,
    OrderStatus.outForDelivery,
    OrderStatus.delivered,
  ];

  bool get isActive => status != OrderStatus.delivered && status != OrderStatus.cancelled;
  bool get isCompleted => status == OrderStatus.delivered;
  bool get isCancelled => status == OrderStatus.cancelled;
}
