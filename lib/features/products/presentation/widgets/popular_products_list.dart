import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import 'product_card.dart';

class PopularProductsList extends StatelessWidget {
  const PopularProductsList({
    super.key,
    required this.products,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.onAddPressed,
  });

  static const _cardWidth = 168.0;

  final List<Product> products;
  final bool Function(Product product) isFavorite;
  final ValueChanged<Product> onFavoritePressed;
  final ValueChanged<Product> onAddPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        spacing: 12,
        children: [
          for (final product in products)
            SizedBox(
              width: _cardWidth,
              height: ProductCard.height,
              child: ProductCard(
                product: product,
                isFavorite: isFavorite(product),
                onFavoritePressed: () => onFavoritePressed(product),
                onAddPressed: () => onAddPressed(product),
              ),
            ),
        ],
      ),
    );
  }
}
