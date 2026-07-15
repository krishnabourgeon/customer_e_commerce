/// Represents a single sellable product within the app.
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? discountPrice;
  final String imageUrl;
  final List<String> imageGallery;
  final String category;
  final double rating;
  final int ratingCount;
  final String storeId;
  final String unit; // e.g. "1 kg", "500 ml", "1 pc"
  final bool isAvailable;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discountPrice,
    required this.imageUrl,
    this.imageGallery = const [],
    required this.category,
    required this.rating,
    required this.ratingCount,
    required this.storeId,
    required this.unit,
    this.isAvailable = true,
  });

  /// Whether the product currently has an active discount.
  bool get hasDiscount => discountPrice != null && discountPrice! < price;

  /// Percentage discount, rounded to nearest whole number.
  int get discountPercent {
    if (!hasDiscount) return 0;
    return (((price - discountPrice!) / price) * 100).round();
  }

  /// The price the customer actually pays.
  double get effectivePrice => hasDiscount ? discountPrice! : price;
}
