import 'package:flutter/material.dart';

import '../../../../core/widgets/app_toast.dart';
import '../viewmodels/cart_view_model.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/cart_summary.dart';
import '../widgets/empty_cart_view.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.viewModel});

  final CartViewModel viewModel;

  void _placeOrder(BuildContext context) {
    viewModel.placeOrder();
    // No change needed here: fixing task M1 in app_toast.dart also makes this
    // message spoken.
    AppToast.show(
      context,
      'Order placed! This is a demo, no payment was taken.',
      icon: Icons.local_shipping_rounded,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _CartTopBar(onBack: () => Navigator.of(context).pop()),
              Expanded(
                child: viewModel.isEmpty
                    ? EmptyCartView(onBrowse: () => Navigator.of(context).pop())
                    : _buildItems(),
              ),
              if (!viewModel.isEmpty)
                CartSummary(
                  subtotalCents: viewModel.subtotalCents,
                  deliveryCents: viewModel.deliveryCents,
                  totalCents: viewModel.totalCents,
                  onPlaceOrder: () => _placeOrder(context),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItems() {
    final items = viewModel.items;

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = items[index];
        return CartItemTile(
          item: item,
          onDecrement: () => viewModel.decrement(item),
          onIncrement: () => viewModel.increment(item),
          onRemove: () => viewModel.remove(item),
        );
      },
    );
  }
}

class _CartTopBar extends StatelessWidget {
  const _CartTopBar({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Back',
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          const SizedBox(width: 4),
          Semantics(
            headingLevel: 1,
            child: Text(
              'Your basket 🛒',
              semanticsLabel: 'Your basket',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
