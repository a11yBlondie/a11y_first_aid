class Product {
  const Product({
    required this.id,
    required this.name,
    required this.unit,
    required this.priceCents,
    required this.imageAsset,
    required this.rating,
    required this.reviewCount,
    this.isOrganic = false,
    this.isPopular = false,
  });

  final String id;
  final String name;
  final String unit;
  final int priceCents;
  final String imageAsset;
  final double rating;
  final int reviewCount;
  final bool isOrganic;
  final bool isPopular;

  @override
  bool operator ==(Object other) => other is Product && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
