import 'package:flutter/material.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key, required this.onBrowse});

  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ExcludeSemantics(
              child: const Text('🧺 🍃 🍃', style: TextStyle(fontSize: 48)),
            ),
            const SizedBox(height: 16),
            Semantics(
              headingLevel: 2,
              child: Text('Your basket is empty', style: textTheme.titleLarge),
            ),
            const SizedBox(height: 8),
            Text(
              'Add some fresh products to get started.',
              style: textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: onBrowse,
              child: const Text('Browse products'),
            ),
          ],
        ),
      ),
    );
  }
}
