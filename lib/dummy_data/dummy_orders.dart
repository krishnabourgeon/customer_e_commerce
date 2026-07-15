import '../models/cart_item.dart';
import '../models/order.dart';
import 'dummy_products.dart';
import 'dummy_stores.dart';

/// Dummy order history used on My Orders and Order Tracking screens.
final List<Order> dummyOrders = [
  Order(
    id: 'ORD10231',
    storeName: dummyStores[1].name,
    storeImageUrl: dummyStores[1].imageUrl,
    items: [
      CartItem(product: dummyProducts[10], quantity: 2),
      CartItem(product: dummyProducts[12], quantity: 1),
    ],
    total: 457.0,
    placedAt: DateTime.now().subtract(const Duration(minutes: 18)),
    status: OrderStatus.outForDelivery,
    deliveryAddress: 'Door No. 24, Lake View Apartments, Kakkanad',
  ),
  Order(
    id: 'ORD10230',
    storeName: dummyStores[0].name,
    storeImageUrl: dummyStores[0].imageUrl,
    items: [
      CartItem(product: dummyProducts[0], quantity: 1),
      CartItem(product: dummyProducts[2], quantity: 1),
      CartItem(product: dummyProducts[7], quantity: 3),
    ],
    total: 318.0,
    placedAt: DateTime.now().subtract(const Duration(hours: 3)),
    status: OrderStatus.preparing,
    deliveryAddress: 'Door No. 24, Lake View Apartments, Kakkanad',
  ),
  Order(
    id: 'ORD10198',
    storeName: dummyStores[5].name,
    storeImageUrl: dummyStores[5].imageUrl,
    items: [
      CartItem(product: dummyProducts[13], quantity: 1),
      CartItem(product: dummyProducts[15], quantity: 2),
    ],
    total: 527.0,
    placedAt: DateTime.now().subtract(const Duration(days: 2)),
    status: OrderStatus.delivered,
    deliveryAddress: 'Office 3B, Tech Park, Infopark Road',
  ),
  Order(
    id: 'ORD10187',
    storeName: dummyStores[3].name,
    storeImageUrl: dummyStores[3].imageUrl,
    items: [
      CartItem(product: dummyProducts[27], quantity: 1),
    ],
    total: 1999.0,
    placedAt: DateTime.now().subtract(const Duration(days: 5)),
    status: OrderStatus.delivered,
    deliveryAddress: 'Door No. 24, Lake View Apartments, Kakkanad',
  ),
  Order(
    id: 'ORD10150',
    storeName: dummyStores[2].name,
    storeImageUrl: dummyStores[2].imageUrl,
    items: [
      CartItem(product: dummyProducts[20], quantity: 1),
      CartItem(product: dummyProducts[22], quantity: 1),
    ],
    total: 2098.0,
    placedAt: DateTime.now().subtract(const Duration(days: 9)),
    status: OrderStatus.cancelled,
    deliveryAddress: 'Door No. 24, Lake View Apartments, Kakkanad',
  ),
];
