import 'package:a11y_first_aid/features/cart/data/repositories/in_memory_cart_repository.dart';
import 'package:a11y_first_aid/features/cart/domain/entities/cart_item.dart';
import 'package:a11y_first_aid/features/cart/presentation/screens/cart_screen.dart';
import 'package:a11y_first_aid/features/cart/presentation/viewmodels/cart_view_model.dart';
import 'package:a11y_first_aid/features/cart/presentation/widgets/cart_badge_button.dart';
import 'package:a11y_first_aid/features/cart/presentation/widgets/cart_item_tile.dart';
import 'package:a11y_first_aid/features/cart/presentation/widgets/cart_summary.dart';
import 'package:a11y_first_aid/features/cart/presentation/widgets/empty_cart_view.dart';
import 'package:a11y_first_aid/features/cart/presentation/widgets/quantity_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'a11y_test_utils.dart';

void main() {
  group('CartBadgeButton', () {
    Future<CartViewModel> pumpBadge(WidgetTester tester, int count) async {
      final viewModel = CartViewModel(repository: InMemoryCartRepository());
      for (var i = 0; i < count; i++) {
        viewModel.addProduct(apples);
      }
      await pumpInApp(
        tester,
        CartBadgeButton(viewModel: viewModel, onPressed: () {}),
      );
      return viewModel;
    }

    testWidgets('S1: says what it is and how many items', (tester) async {
      await pumpBadge(tester, 2);
      expect(
        tester.getSemantics(find.byType(IconButton)),
        isSemantics(isButton: true, tooltip: 'Basket, 2 items'),
      );
    });

    testWidgets('S1: uses singular for one item', (tester) async {
      await pumpBadge(tester, 1);
      expect(find.byTooltip('Basket, 1 item'), findsOneWidget);
    });

    testWidgets('S1: name updates when items are added', (tester) async {
      final viewModel = await pumpBadge(tester, 0);
      expect(find.byTooltip('Basket, 0 items'), findsOneWidget);

      viewModel.addProduct(apples);
      await tester.pump();
      expect(find.byTooltip('Basket, 1 item'), findsOneWidget);
    });

    testWidgets('S1: bare badge number is not read', (tester) async {
      await pumpBadge(tester, 2);
      expect(find.bySemanticsLabel('2'), findsNothing);
    });
  });

  group('CartItemTile', () {
    const item = CartItem(product: apples, quantity: 2);

    Future<void> pumpTile(WidgetTester tester) {
      return pumpInApp(
        tester,
        CartItemTile(
          item: item,
          onDecrement: () {},
          onIncrement: () {},
          onRemove: () {},
        ),
      );
    }

    testWidgets('A3: product image is decorative', (tester) async {
      await pumpTile(tester);
      expectImagesDecorative(tester);
    });

    testWidgets('S14: name, unit and price are one stop', (tester) async {
      await pumpTile(tester);
      final name = tester.getSemantics(find.text('Red Apples'));
      expect(tester.getSemantics(find.text('1 kg')), same(name));
      expect(tester.getSemantics(find.text(r'$5.98')), same(name));
      expect(
        name.label,
        allOf(contains('Red Apples'), contains('1 kg'), contains(r'$5.98')),
      );
    });

    testWidgets('S12: remove button names the product', (tester) async {
      await pumpTile(tester);
      expect(
        tester.getSemantics(find.byTooltip('Remove Red Apples')),
        isSemantics(isButton: true, tooltip: 'Remove Red Apples'),
      );
    });
  });

  group('QuantityStepper', () {
    Future<void> pumpStepper(WidgetTester tester) {
      return pumpInApp(
        tester,
        QuantityStepper(
          productName: 'Red Apples',
          quantity: 2,
          onDecrement: () {},
          onIncrement: () {},
        ),
      );
    }

    testWidgets('S13: both buttons have names', (tester) async {
      await pumpStepper(tester);
      expect(
        tester.getSemantics(find.byTooltip('Decrease Red Apples')),
        isSemantics(isButton: true, tooltip: 'Decrease Red Apples'),
      );
      expect(
        tester.getSemantics(find.byTooltip('Increase Red Apples')),
        isSemantics(isButton: true, tooltip: 'Increase Red Apples'),
      );
    });

    testWidgets('S13: number has context', (tester) async {
      await pumpStepper(tester);
      expect(find.bySemanticsLabel('Quantity: 2'), findsOneWidget);
    });
  });

  group('CartSummary', () {
    Future<void> pumpSummary(WidgetTester tester, {int deliveryCents = 0}) {
      return pumpInApp(
        tester,
        CartSummary(
          subtotalCents: 648,
          deliveryCents: deliveryCents,
          totalCents: 648 + deliveryCents,
          onPlaceOrder: () {},
        ),
      );
    }

    testWidgets('H4: "Order summary" is a level 2 heading', (tester) async {
      await pumpSummary(tester);
      expectHeading(tester, find.text('Order summary'), 2);
    });

    testWidgets('S15: label and value are read together', (tester) async {
      await pumpSummary(tester);
      final subtotal = tester.getSemantics(find.text('Subtotal'));
      expect(tester.getSemantics(find.text(r'$6.48').first), same(subtotal));
      expect(subtotal.label, allOf(contains('Subtotal'), contains(r'$6.48')));
    });

    testWidgets('S16: free delivery is read without the emoji', (tester) async {
      await pumpSummary(tester);
      final label = semanticsOf(tester, find.text('Delivery')).label;
      expect(label, contains('Free'));
      expectNotSpoken('🎉');
    });

    testWidgets('S16: paid delivery reads the price', (tester) async {
      await pumpSummary(tester, deliveryCents: 499);
      expect(
        semanticsOf(tester, find.text('Delivery')).label,
        contains(r'$4.99'),
      );
    });

    testWidgets('S8: divider inside the summary is not read', (tester) async {
      await pumpSummary(tester);
      expectNotSpoken('•');
    });
  });

  group('EmptyCartView', () {
    testWidgets('S17: decorative emojis are not read', (tester) async {
      await pumpInApp(tester, EmptyCartView(onBrowse: () {}));
      for (final emoji in ['🧺', '🍃']) {
        expectNotSpoken(emoji);
      }
    });

    testWidgets('H5: main message is a level 2 heading', (tester) async {
      await pumpInApp(tester, EmptyCartView(onBrowse: () {}));
      expectHeading(tester, find.text('Your basket is empty'), 2);
    });
  });

  group('CartScreen top bar', () {
    Future<void> pumpCartScreen(WidgetTester tester) {
      return tester.pumpWidget(
        MaterialApp(
          home: CartScreen(
            viewModel: CartViewModel(repository: InMemoryCartRepository()),
          ),
        ),
      );
    }

    testWidgets('S11: back button has a name', (tester) async {
      await pumpCartScreen(tester);
      expect(
        tester.getSemantics(find.byTooltip('Back')),
        isSemantics(isButton: true, tooltip: 'Back'),
      );
    });

    testWidgets('H3: title is a level 1 heading without emoji', (tester) async {
      await pumpCartScreen(tester);
      expect(find.bySemanticsLabel('Your basket'), findsOneWidget);
      expectHeading(tester, find.text('Your basket 🛒'), 1);
      expectNotSpoken('🛒');
    });
  });
}
