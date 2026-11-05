import 'package:a11y_first_aid/features/products/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';

const apples = Product(
  id: 'p-001',
  name: 'Red Apples',
  unit: '1 kg',
  priceCents: 299,
  imageAsset: 'assets/images/apples.png',
  rating: 4.6,
  reviewCount: 128,
  isOrganic: true,
  isPopular: true,
);

/// Pumps [child] inside a minimal Material app.
Future<void> pumpInApp(WidgetTester tester, Widget child) {
  return tester.pumpWidget(MaterialApp(home: Scaffold(body: child)));
}

/// What the screen reader gets for the node that owns [finder].
SemanticsData semanticsOf(WidgetTester tester, Finder finder) {
  return tester.getSemantics(finder).getSemanticsData();
}

/// Asserts that [finder] is announced as a heading of [level].
void expectHeading(WidgetTester tester, Finder finder, int level) {
  expect(
    semanticsOf(tester, finder).headingLevel,
    level,
    reason: 'should be announced as a level $level heading',
  );
}

/// Asserts that nothing in the semantics tree contains [text].
void expectNotSpoken(String text) {
  expect(
    find.bySemanticsLabel(RegExp(RegExp.escape(text))),
    findsNothing,
    reason: '"$text" is decorative and should not be read aloud',
  );
}

/// Asserts that every [Image] under the tree is hidden from screen readers.
void expectImagesDecorative(WidgetTester tester) {
  final images = tester.widgetList<Image>(find.byType(Image));
  expect(images, isNotEmpty);
  for (final image in images) {
    expect(
      image.excludeFromSemantics,
      isTrue,
      reason: 'decorative image ${image.image} should be excluded',
    );
  }
}
