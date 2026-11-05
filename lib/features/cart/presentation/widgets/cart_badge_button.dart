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
      builder: (context, _) {
        final count = viewModel.itemCount;
        return IconButton(
          tooltip: 'Basket, $count ${count == 1 ? 'item' : 'items'}',
          onPressed: onPressed,
          icon: Badge(
            isLabelVisible: count > 0,
            label: ExcludeSemantics(child: Text('$count')),
            child: const Icon(Icons.shopping_basket_outlined),
          ),
        );
      },
    );
  }
}
