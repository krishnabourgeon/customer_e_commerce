class Address {
  final String id;
  final String label;
  final String fullAddress;
  final bool isDefault;
  final double? latitude;
  final double? longitude;

  const Address({
    required this.id,
    required this.label,
    required this.fullAddress,
    this.isDefault = false,
    this.latitude,
    this.longitude,
  });

  Address copyWith({
    String? id,
    String? label,
    String? fullAddress,
    bool? isDefault,
    double? latitude,
    double? longitude,
  }) {
    return Address(
      id: id ?? this.id,
      label: label ?? this.label,
      fullAddress: fullAddress ?? this.fullAddress,
      isDefault: isDefault ?? this.isDefault,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}