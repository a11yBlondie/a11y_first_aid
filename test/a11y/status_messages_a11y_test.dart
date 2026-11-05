import 'package:a11y_first_aid/app/app.dart';
import 'package:a11y_first_aid/app/app_dependencies.dart';
import 'package:a11y_first_aid/features/cart/data/repositories/in_memory_cart_repository.dart';
import 'package:a11y_first_aid/features/products/domain/entities/product.dart';
import 'package:a11y_first_aid/features/products/domain/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FailingRepository implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async => throw Exception('offline');
}

Future<AppDependencies> _pumpApp(
  WidgetTester tester, {
  Duration latency = Duration.zero,
}) async {
  final dependencies = AppDependencies.mock(latency: latency);
  await tester.pumpWidget(FreshMarketApp(dependencies: dependencies));
  return dependencies;
}

Future<void> _addApples(WidgetTester tester) async {
  await tester.tap(find.byTooltip('Add Red Apples to basket').first);
  // Let the toast fade in: at opacity 0 it is hidden from screen readers.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 250));
}

void main() {
  group('M1: toast is spoken', () {
    testWidgets('Android: toast is a live region', (tester) async {
      await _pumpApp(tester);
      await tester.pumpAndSettle();
      await _addApples(tester);

      expect(
        tester.getSemantics(find.text('Red Apples added to basket')),
        isSemantics(isLiveRegion: true, label: 'Red Apples added to basket'),
      );
      await tester.pumpAndSettle(const Duration(seconds: 3));
    }, variant: TargetPlatformVariant.only(TargetPlatform.android));

    testWidgets('iOS: toast is announced', (tester) async {
      await _pumpApp(tester);
      await tester.pumpAndSettle();
      tester.takeAnnouncements(); // clear anything from startup

      await _addApples(tester);
      await tester.pump(const Duration(milliseconds: 500));

      expect(
        tester.takeAnnouncements().map((a) => a.message),
        contains('Red Apples added to basket'),
      );
      await tester.pumpAndSettle(const Duration(seconds: 3));
    }, variant: TargetPlatformVariant.only(TargetPlatform.iOS));

    testWidgets('placing an order shows the order toast', (tester) async {
      final dependencies = await _pumpApp(tester);
      await tester.pumpAndSettle();
      await _addApples(tester);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byTooltip('Basket, 1 item'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Place order'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));

      expect(dependencies.cartViewModel.isEmpty, isTrue);
      expect(find.bySemanticsLabel(RegExp('Order placed!')), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 3));
    });
  });

  testWidgets('M2: spinner says what is loading', (tester) async {
    await _pumpApp(tester, latency: const Duration(seconds: 1));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.bySemanticsLabel('Loading products'), findsOneWidget);

    await tester.pumpAndSettle();
  });

  testWidgets('M3: error is a live region', (tester) async {
    await tester.pumpWidget(
      FreshMarketApp(
        dependencies: AppDependencies(
          productRepository: _FailingRepository(),
          cartRepository: InMemoryCartRepository(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      tester.getSemantics(find.text('Something went wrong')),
      isSemantics(isLiveRegion: true, label: 'Something went wrong'),
    );
  });
}
