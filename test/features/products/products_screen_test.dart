import 'package:a11y_first_aid/app/app.dart';
import 'package:a11y_first_aid/app/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('adding a product updates the basket', (tester) async {
    final dependencies = AppDependencies.mock(latency: Duration.zero);
    await tester.pumpWidget(FreshMarketApp(dependencies: dependencies));
    await tester.pumpAndSettle();

    expect(find.text('Fresh Market'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add_rounded).first);
    await tester.pump();

    expect(dependencies.cartViewModel.itemCount, 1);
    expect(find.text('Red Apples added to basket'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.shopping_basket_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Order summary'), findsOneWidget);
    expect(find.text('Red Apples'), findsOneWidget);
  });
}
