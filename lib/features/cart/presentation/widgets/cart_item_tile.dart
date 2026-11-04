import 'package:flutter/material.dart';

import '../../../../core/formatting/price_formatter.dart';
import '../../domain/entities/cart_item.dart';
import 'quantity_stepper.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.item,
    required this.onDecrement,
    required this.onIncrement,
    required this.onRemove,
  });

  final CartItem item;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = item.product;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              // TODO(a11y): [A3 Alt text]
              // The image has no alt text. The product name is right next to
              // it, so the image adds no new information.
              // Fix: mark it as decorative.
              //
              //   Image.asset(
              //     product.imageAsset,
              //     excludeFromSemantics: true,
              //     ...
              //   ),
              child: Image.asset(
                product.imageAsset,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            // TODO(a11y): [S14 Semantics]
            // Name, unit and price are three separate stops. Read them as one:
            // "Red Apples, 1 kg, $5.98".
            // Fix: wrap the Expanded's child Column in MergeSemantics.
            //
            //   Expanded(
            //     child: MergeSemantics(
            //       child: Column(...),
            //     ),
            //   ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: theme.textTheme.titleSmall),
                  Text(product.unit, style: theme.textTheme.bodySmall),
                  const SizedBox(height: 6),
                  Text(
                    PriceFormatter.format(item.totalCents),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // TODO(a11y): [S12 Semantics]
                // Icon-only button with no name.
                // Fix: add a tooltip that names the product.
                //
                //   IconButton(
                //     tooltip: 'Remove ${product.name}',
                //     ...
                //   ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline_rounded),
                ),
                QuantityStepper(
                  productName: product.name,
                  quantity: item.quantity,
                  onDecrement: onDecrement,
                  onIncrement: onIncrement,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
