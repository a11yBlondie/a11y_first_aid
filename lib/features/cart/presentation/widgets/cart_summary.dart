import 'package:flutter/material.dart';

import '../../../../core/formatting/price_formatter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/decorative_divider.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({
    super.key,
    required this.subtotalCents,
    required this.deliveryCents,
    required this.totalCents,
    required this.onPlaceOrder,
  });

  final int subtotalCents;
  final int deliveryCents;
  final int totalCents;
  final VoidCallback onPlaceOrder;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 16)],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TODO(a11y): [H4 Heading]
            // "Order summary" looks like a heading but is not announced as one.
            // Fix: give it heading level 2 (a section inside the screen).
            //
            //   Semantics(
            //     headingLevel: 2,
            //     child: Text('Order summary', style: textTheme.titleMedium),
            //   ),
            Text('Order summary', style: textTheme.titleMedium),
            const SizedBox(height: 12),
            _SummaryRow(
              label: 'Subtotal',
              value: PriceFormatter.format(subtotalCents),
            ),
            // TODO(a11y): [S16 Semantics]
            // "Free 🎉" is read as "Free, party popper".
            // Fix: give _SummaryRow a clean spoken value, e.g. add a
            // `semanticsValue` parameter and pass it to the value Text:
            //
            //   _SummaryRow(
            //     label: 'Delivery',
            //     value: deliveryCents == 0 ? 'Free 🎉' : ...,
            //     semanticsValue: deliveryCents == 0 ? 'Free' : null,
            //   ),
            //
            //   // inside _SummaryRow:
            //   Text(value, semanticsLabel: semanticsValue, style: style),
            _SummaryRow(
              label: 'Delivery',
              value: deliveryCents == 0
                  ? 'Free 🎉'
                  : PriceFormatter.format(deliveryCents),
            ),
            const DecorativeDivider(),
            _SummaryRow(
              label: 'Total',
              value: PriceFormatter.format(totalCents),
              emphasized: true,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onPlaceOrder,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Place order'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.emphasized = false,
  });

  final String label;
  final String value;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final style = emphasized ? textTheme.titleLarge : textTheme.bodyMedium;

    // TODO(a11y): [S15 Semantics]
    // Label and value are two separate stops: "Subtotal", then "$6.48". Read
    // them together: "Subtotal, $6.48".
    // Fix: wrap the Row in MergeSemantics.
    //
    //   child: MergeSemantics(
    //     child: Row(...),
    //   ),
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }
}
