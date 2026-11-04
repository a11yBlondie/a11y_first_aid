import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    required this.products,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.onAddPressed,
  });

  static const _maxCardWidth = 220.0;
  static const _spacing = 12.0;

  final List<Product> products;
  final bool Function(Product product) isFavorite;
  final ValueChanged<Product> onFavoritePressed;
  final ValueChanged<Product> onAddPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = (constraints.maxWidth / _maxCardWidth).ceil();
        final cardWidth =
            (constraints.maxWidth - _spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: _spacing,
          runSpacing: _spacing,
          children: [
            for (final product in products)
              SizedBox(
                width: cardWidth,
                height: ProductCard.height,
                child: ProductCard(
                  product: product,
                  isFavorite: isFavorite(product),
                  onFavoritePressed: () => onFavoritePressed(product),
                  onAddPressed: () => onAddPressed(product),
                ),
              ),
          ],
        );
      },
    );
  }
}
