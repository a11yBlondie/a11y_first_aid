import 'package:flutter/material.dart';

import '../viewmodels/cart_view_model.dart';

class CartBadgeButton extends StatelessWidget {
  const CartBadgeButton({
    super.key,
    required this.viewModel,
    required this.onPressed,
  });

  final CartViewModel viewModel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      // TODO(a11y): [S1 Semantics]
      // Icon-only button with no name. The screen reader says only the badge
      // number: "2, button".
      // Fix: add a tooltip that says what the button does and how many items
      // are in the basket.
      //
      //   builder: (context, _) => IconButton(
      //     tooltip: 'Basket, ${viewModel.itemCount} items',
      //     onPressed: onPressed,
      //     icon: ...,
      //   ),
      builder: (context, _) => IconButton(
        onPressed: onPressed,
        icon: Badge(
          isLabelVisible: viewModel.itemCount > 0,
          label: Text('${viewModel.itemCount}'),
          child: const Icon(Icons.shopping_basket_outlined),
        ),
      ),
    );
  }
}
