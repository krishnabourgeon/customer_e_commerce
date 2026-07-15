import '../models/product.dart';

/// Generates 50 dummy products spread across categories and stores.
/// Built programmatically to keep the dummy data easy to extend while still
/// giving each item a realistic name, price, rating and image.
List<Product> _buildDummyProducts() {
  final List<Map<String, dynamic>> blueprint = [
    // Grocery (store_1, store_7)
    {'name': 'Fresh Bananas', 'cat': 'Grocery', 'store': 'store_1', 'price': 49.0, 'disc': 39.0, 'unit': '1 dozen'},
    {'name': 'Organic Tomatoes', 'cat': 'Grocery', 'store': 'store_1', 'price': 35.0, 'disc': null, 'unit': '1 kg'},
    {'name': 'Basmati Rice', 'cat': 'Grocery', 'store': 'store_1', 'price': 220.0, 'disc': 189.0, 'unit': '5 kg'},
    {'name': 'Toor Dal', 'cat': 'Grocery', 'store': 'store_7', 'price': 140.0, 'disc': 120.0, 'unit': '1 kg'},
    {'name': 'Sunflower Oil', 'cat': 'Grocery', 'store': 'store_7', 'price': 165.0, 'disc': null, 'unit': '1 L'},
    {'name': 'Whole Wheat Atta', 'cat': 'Grocery', 'store': 'store_1', 'price': 210.0, 'disc': 185.0, 'unit': '5 kg'},
    {'name': 'Farm Fresh Eggs', 'cat': 'Grocery', 'store': 'store_7', 'price': 75.0, 'disc': null, 'unit': '12 pcs'},
    {'name': 'Amul Milk', 'cat': 'Grocery', 'store': 'store_1', 'price': 30.0, 'disc': null, 'unit': '500 ml'},
    {'name': 'Red Onions', 'cat': 'Grocery', 'store': 'store_7', 'price': 28.0, 'disc': 24.0, 'unit': '1 kg'},
    {'name': 'Green Apples', 'cat': 'Grocery', 'store': 'store_1', 'price': 180.0, 'disc': 159.0, 'unit': '1 kg'},
    // Food (store_2, store_6)
    {'name': 'Classic Cheese Burger', 'cat': 'Food', 'store': 'store_2', 'price': 180.0, 'disc': 149.0, 'unit': '1 pc'},
    {'name': 'Spicy Chicken Burger', 'cat': 'Food', 'store': 'store_2', 'price': 199.0, 'disc': null, 'unit': '1 pc'},
    {'name': 'French Fries', 'cat': 'Food', 'store': 'store_2', 'price': 99.0, 'disc': 79.0, 'unit': 'Regular'},
    {'name': 'Margherita Pizza', 'cat': 'Food', 'store': 'store_6', 'price': 299.0, 'disc': 249.0, 'unit': 'Medium'},
    {'name': 'Pepperoni Pizza', 'cat': 'Food', 'store': 'store_6', 'price': 349.0, 'disc': null, 'unit': 'Medium'},
    {'name': 'Garlic Breadsticks', 'cat': 'Food', 'store': 'store_6', 'price': 129.0, 'disc': 99.0, 'unit': '6 pcs'},
    {'name': 'Veg Loaded Burger', 'cat': 'Food', 'store': 'store_2', 'price': 159.0, 'disc': null, 'unit': '1 pc'},
    {'name': 'Cold Coffee Shake', 'cat': 'Food', 'store': 'store_2', 'price': 119.0, 'disc': 99.0, 'unit': '350 ml'},
    {'name': 'Choco Lava Cake', 'cat': 'Food', 'store': 'store_6', 'price': 89.0, 'disc': null, 'unit': '1 pc'},
    {'name': 'Paneer Tikka Pizza', 'cat': 'Food', 'store': 'store_6', 'price': 329.0, 'disc': 279.0, 'unit': 'Medium'},
    // Fashion (store_3)
    {'name': 'Men Cotton T-Shirt', 'cat': 'Fashion', 'store': 'store_3', 'price': 599.0, 'disc': 399.0, 'unit': '1 pc'},
    {'name': 'Women Floral Dress', 'cat': 'Fashion', 'store': 'store_3', 'price': 1299.0, 'disc': 899.0, 'unit': '1 pc'},
    {'name': 'Denim Jacket', 'cat': 'Fashion', 'store': 'store_3', 'price': 1899.0, 'disc': 1499.0, 'unit': '1 pc'},
    {'name': 'Casual Sneakers', 'cat': 'Fashion', 'store': 'store_3', 'price': 2199.0, 'disc': 1699.0, 'unit': '1 pair'},
    {'name': 'Formal Shirt', 'cat': 'Fashion', 'store': 'store_3', 'price': 899.0, 'disc': null, 'unit': '1 pc'},
    {'name': 'Leather Belt', 'cat': 'Fashion', 'store': 'store_3', 'price': 499.0, 'disc': 349.0, 'unit': '1 pc'},
    {'name': 'Kids Hoodie', 'cat': 'Fashion', 'store': 'store_3', 'price': 799.0, 'disc': null, 'unit': '1 pc'},
    // Electronics (store_4)
    {'name': 'Wireless Earbuds', 'cat': 'Electronics', 'store': 'store_4', 'price': 2999.0, 'disc': 1999.0, 'unit': '1 pc'},
    {'name': 'Smart Watch', 'cat': 'Electronics', 'store': 'store_4', 'price': 4999.0, 'disc': 3499.0, 'unit': '1 pc'},
    {'name': 'Bluetooth Speaker', 'cat': 'Electronics', 'store': 'store_4', 'price': 1799.0, 'disc': 1299.0, 'unit': '1 pc'},
    {'name': 'Fast Charger 65W', 'cat': 'Electronics', 'store': 'store_4', 'price': 1299.0, 'disc': null, 'unit': '1 pc'},
    {'name': 'Power Bank 20000mAh', 'cat': 'Electronics', 'store': 'store_4', 'price': 2199.0, 'disc': 1799.0, 'unit': '1 pc'},
    {'name': 'Phone Back Cover', 'cat': 'Electronics', 'store': 'store_4', 'price': 299.0, 'disc': 199.0, 'unit': '1 pc'},
    {'name': 'USB-C Cable', 'cat': 'Electronics', 'store': 'store_4', 'price': 399.0, 'disc': null, 'unit': '1 pc'},
    // Beauty (store_5)
    {'name': 'Vitamin C Face Serum', 'cat': 'Beauty', 'store': 'store_5', 'price': 699.0, 'disc': 549.0, 'unit': '30 ml'},
    {'name': 'Matte Lipstick', 'cat': 'Beauty', 'store': 'store_5', 'price': 449.0, 'disc': null, 'unit': '1 pc'},
    {'name': 'Sunscreen SPF 50', 'cat': 'Beauty', 'store': 'store_5', 'price': 599.0, 'disc': 459.0, 'unit': '50 ml'},
    {'name': 'Hydrating Face Wash', 'cat': 'Beauty', 'store': 'store_5', 'price': 349.0, 'disc': null, 'unit': '100 ml'},
    {'name': 'Hair Growth Oil', 'cat': 'Beauty', 'store': 'store_5', 'price': 499.0, 'disc': 399.0, 'unit': '200 ml'},
    {'name': 'Compact Powder', 'cat': 'Beauty', 'store': 'store_5', 'price': 379.0, 'disc': null, 'unit': '1 pc'},
    // Pharmacy (store_10)
    {'name': 'Multivitamin Tablets', 'cat': 'Pharmacy', 'store': 'store_10', 'price': 299.0, 'disc': 249.0, 'unit': '30 tabs'},
    {'name': 'Digital Thermometer', 'cat': 'Pharmacy', 'store': 'store_10', 'price': 199.0, 'disc': null, 'unit': '1 pc'},
    {'name': 'Hand Sanitizer', 'cat': 'Pharmacy', 'store': 'store_10', 'price': 99.0, 'disc': 79.0, 'unit': '200 ml'},
    {'name': 'First Aid Kit', 'cat': 'Pharmacy', 'store': 'store_10', 'price': 449.0, 'disc': null, 'unit': '1 set'},
    // Pet Care (store_8)
    {'name': 'Dog Dry Food', 'cat': 'Pet Care', 'store': 'store_8', 'price': 899.0, 'disc': 749.0, 'unit': '3 kg'},
    {'name': 'Cat Litter', 'cat': 'Pet Care', 'store': 'store_8', 'price': 499.0, 'disc': null, 'unit': '5 L'},
    {'name': 'Pet Shampoo', 'cat': 'Pet Care', 'store': 'store_8', 'price': 349.0, 'disc': 299.0, 'unit': '250 ml'},
    // Home (store_9)
    {'name': 'Scented Candle Set', 'cat': 'Home', 'store': 'store_9', 'price': 599.0, 'disc': 449.0, 'unit': 'Set of 3'},
    {'name': 'Cotton Bedsheet', 'cat': 'Home', 'store': 'store_9', 'price': 1299.0, 'disc': 999.0, 'unit': 'King size'},
    {'name': 'Ceramic Dinner Set', 'cat': 'Home', 'store': 'store_9', 'price': 1899.0, 'disc': null, 'unit': '16 pcs'},
  ];

  return List.generate(blueprint.length, (i) {
    final item = blueprint[i];
    final seed = 'product${i + 1}';
    return Product(
      id: 'prod_${i + 1}',
      name: item['name'] as String,
      description:
          '${item['name']} - premium quality, carefully selected and delivered fresh to your doorstep. Loved by thousands of happy customers.',
      price: item['price'] as double,
      discountPrice: item['disc'] as double?,
      imageUrl: 'https://picsum.photos/seed/$seed/400/400',
      imageGallery: [
        'https://picsum.photos/seed/$seed/400/400',
        'https://picsum.photos/seed/${seed}b/400/400',
        'https://picsum.photos/seed/${seed}c/400/400',
      ],
      category: item['cat'] as String,
      rating: 3.8 + ((i % 12) / 10).clamp(0, 1.2),
      ratingCount: 50 + (i * 17) % 900,
      storeId: item['store'] as String,
      unit: item['unit'] as String,
    );
  });
}

/// 50 dummy products used across Home, Store Details and Product screens.
final List<Product> dummyProducts = _buildDummyProducts();
