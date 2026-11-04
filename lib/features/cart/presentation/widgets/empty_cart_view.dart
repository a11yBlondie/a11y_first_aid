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
            // TODO(a11y): [S17 Semantics]
            // Decorative emojis are read aloud: "basket, leaf, leaf".
            // Fix:
            //
            //   const ExcludeSemantics(
            //     child: Text('🧺 🍃 🍃', style: TextStyle(fontSize: 48)),
            //   ),
            const Text('🧺 🍃 🍃', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 16),
            // TODO(a11y): [H5 Heading]
            // This is the main message of the screen.
            // Fix: give it heading level 2 (a section inside the screen).
            //
            //   Semantics(
            //     headingLevel: 2,
            //     child: Text('Your basket is empty', style: textTheme.titleLarge),
            //   ),
            Text('Your basket is empty', style: textTheme.titleLarge),
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
