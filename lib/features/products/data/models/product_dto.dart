import '../../domain/entities/product.dart';

class ProductDto {
  const ProductDto({
    required this.id,
    required this.name,
    required this.unit,
    required this.priceCents,
    required this.image,
    required this.rating,
    required this.reviews,
    required this.organic,
    required this.popular,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: json['id'] as String,
      name: json['name'] as String,
      unit: json['unit'] as String,
      priceCents: json['price_cents'] as int,
      image: json['image'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviews: json['reviews'] as int,
      organic: json['organic'] as bool? ?? false,
      popular: json['popular'] as bool? ?? false,
    );
  }

  final String id;
  final String name;
  final String unit;
  final int priceCents;
  final String image;
  final double rating;
  final int reviews;
  final bool organic;
  final bool popular;

  Product toEntity() {
    return Product(
      id: id,
      name: name,
      unit: unit,
      priceCents: priceCents,
      imageAsset: image,
      rating: rating,
      reviewCount: reviews,
      isOrganic: organic,
      isPopular: popular,
    );
  }
}
