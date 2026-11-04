import 'package:flutter/material.dart';

import '../../../../core/formatting/price_formatter.dart';
import '../../domain/entities/product.dart';
import 'organic_badge.dart';
import 'rating_stars.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.onAddPressed,
  });

  static const height = 268.0;

  final Product product;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ProductImage(
            product: product,
            isFavorite: isFavorite,
            onFavoritePressed: onFavoritePressed,
          ),
          Expanded(
            child: _ProductDetails(
              product: product,
              onAddPressed: onAddPressed,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({
    required this.product,
    required this.isFavorite,
    required this.onFavoritePressed,
  });

  static const _height = 128.0;

  final Product product;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // TODO(a11y): [A1 Alt text]
          // The image has no alt text.
          // Ask yourself: does the image tell me something the text does not?
          // Here the product name is right below it, so the image is decorative.
          //
          // Fix:
          //
          //   Image.asset(
          //     product.imageAsset,
          //     excludeFromSemantics: true,
          //     fit: BoxFit.cover,
          //   ),
          //
          // (If an image does carry information, describe it instead:
          //  `semanticLabel: 'Short description of the image'`.)
          Image.asset(product.imageAsset, fit: BoxFit.cover),
          if (product.isOrganic)
            const Positioned(left: 8, top: 8, child: OrganicBadge()),
          Positioned(
            right: 0,
            top: 0,
            // TODO(a11y): [S2 Semantics]
            // Icon-only button with no name: the screen reader says only
            // "button", and does not say whether the product is already a
            // favourite.
            // Fix: add a tooltip and expose the selected state with isSelected.
            //
            //   IconButton(
            //     tooltip: isFavorite
            //         ? 'Remove ${product.name} from favourites'
            //         : 'Add ${product.name} to favourites',
            //     isSelected: isFavorite,
            //     onPressed: onFavoritePressed,
            //     icon: ...,
            //   ),
            child: IconButton(
              onPressed: onFavoritePressed,
              icon: Icon(
                isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: isFavorite ? Colors.redAccent : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails({required this.product, required this.onAddPressed});

  final Product product;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 8, 8),
      child: Stack(
        children: [
          // TODO(a11y): [S4 Semantics]
          // Name, unit, rating and price are four separate stops. Read them as
          // one: "Red Apples, 1 kg, Rated 4.6 out of 5, 128 reviews, $2.99".
          // Fix: wrap the Column in MergeSemantics.
          //
          //   MergeSemantics(
          //     child: Column(...),
          //   ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: 2),
              Text(product.unit, style: theme.textTheme.bodySmall),
              const SizedBox(height: 4),
              RatingStars(
                rating: product.rating,
                reviewCount: product.reviewCount,
              ),
              const Spacer(),
              Text(
                PriceFormatter.format(product.priceCents),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            bottom: 0,
            // TODO(a11y): [S3 Semantics]
            // Icon-only button with no name.
            // Fix: add a tooltip that names the product.
            //
            //   IconButton.filled(
            //     tooltip: 'Add ${product.name} to basket',
            //     onPressed: onAddPressed,
            //     icon: const Icon(Icons.add_rounded),
            //   ),
            child: IconButton.filled(
              onPressed: onAddPressed,
              icon: const Icon(Icons.add_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
