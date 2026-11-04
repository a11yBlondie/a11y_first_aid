import 'package:flutter/material.dart';

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.productName,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  final String productName;
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    // A semantic container keeps the stepper's parts together in reading order.
    return Semantics(
      container: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TODO(a11y): [S13 Semantics]
            // Icon-only buttons with no name, and a bare number ("2") with no
            // context.
            // Fix: add tooltips to both buttons and a label to the number.
            //
            //   IconButton(tooltip: 'Decrease $productName', ...),
            //   Text(
            //     '$quantity',
            //     semanticsLabel: 'Quantity: $quantity',
            //     ...
            //   ),
            //   IconButton(tooltip: 'Increase $productName', ...),
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: onDecrement,
              icon: const Icon(Icons.remove_rounded, size: 18),
            ),
            Text('$quantity', style: Theme.of(context).textTheme.titleSmall),
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: onIncrement,
              icon: const Icon(Icons.add_rounded, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
