/// Represents a store/vendor in the marketplace.
class Store {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final String bannerUrl;
  final double rating;
  final int ratingCount;
  final String deliveryTime; // e.g. "20-30 min"
  final String location;
  final bool isOpen;
  final double distanceKm;

  const Store({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.bannerUrl,
    required this.rating,
    required this.ratingCount,
    required this.deliveryTime,
    required this.location,
    this.isOpen = true,
    required this.distanceKm,
  });
}
