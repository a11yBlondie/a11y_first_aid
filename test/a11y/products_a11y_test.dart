import 'package:a11y_first_aid/core/widgets/decorative_divider.dart';
import 'package:a11y_first_aid/features/products/presentation/widgets/home_top_bar.dart';
import 'package:a11y_first_aid/features/products/presentation/widgets/organic_badge.dart';
import 'package:a11y_first_aid/features/products/presentation/widgets/product_card.dart';
import 'package:a11y_first_aid/features/products/presentation/widgets/promo_banner.dart';
import 'package:a11y_first_aid/features/products/presentation/widgets/rating_stars.dart';
import 'package:a11y_first_aid/features/products/presentation/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'a11y_test_utils.dart';

void main() {
  group('HomeTopBar', () {
    testWidgets('H1: "Fresh Market" is a level 1 heading', (tester) async {
      await pumpInApp(tester, const HomeTopBar(trailing: SizedBox()));
      expectHeading(tester, find.text('Fresh Market'), 1);
    });

    testWidgets('S9: greeting is read without the emoji', (tester) async {
      await pumpInApp(tester, const HomeTopBar(trailing: SizedBox()));
      expect(find.bySemanticsLabel('Good morning'), findsOneWidget);
      expectNotSpoken('👋');
    });
  });

  group('SectionTitle', () {
    testWidgets('H2: title is a level 2 heading', (tester) async {
      await pumpInApp(
        tester,
        const SectionTitle(title: 'Popular this week', decoration: '🔥🔥🔥'),
      );
      expectHeading(tester, find.text('Popular this week'), 2);
    });

    testWidgets('S7: emoji decoration is not read', (tester) async {
      await pumpInApp(
        tester,
        const SectionTitle(title: 'Popular this week', decoration: '🔥🔥🔥'),
      );
      expectNotSpoken('🔥');
    });
  });

  group('PromoBanner', () {
    testWidgets('S10: banner is a button', (tester) async {
      await pumpInApp(tester, PromoBanner(onTap: () {}));
      expect(
        tester.getSemantics(find.byType(PromoBanner)),
        isSemantics(isButton: true, hasTapAction: true),
      );
    });

    testWidgets('S10: emojis and arrow are not read', (tester) async {
      await pumpInApp(tester, PromoBanner(onTap: () {}));
      final label = semanticsOf(tester, find.byType(PromoBanner)).label;
      expect(label, contains('Weekend deals'));
      expect(label, contains('Shop now'));
      for (final symbol in ['🍓', '🍋', '→']) {
        expect(label, isNot(contains(symbol)));
      }
    });

    testWidgets('A2: background image is decorative', (tester) async {
      await pumpInApp(tester, PromoBanner(onTap: () {}));
      expectImagesDecorative(tester);
    });
  });

  group('OrganicBadge', () {
    testWidgets('S6: read as "Organic" without symbols', (tester) async {
      await pumpInApp(tester, const OrganicBadge());
      expect(find.bySemanticsLabel('Organic'), findsOneWidget);
      expectNotSpoken('✦');
    });
  });

  group('RatingStars', () {
    testWidgets('S5: read as one clear sentence', (tester) async {
      await pumpInApp(tester, const RatingStars(rating: 4.6, reviewCount: 128));
      expect(
        find.bySemanticsLabel('Rated 4.6 out of 5, 128 reviews'),
        findsOneWidget,
      );
      expectNotSpoken('★');
      expectNotSpoken('☆');
    });
  });

  group('DecorativeDivider', () {
    testWidgets('S8: is hidden from screen readers', (tester) async {
      await pumpInApp(tester, const DecorativeDivider());
      expectNotSpoken('•');
      expectNotSpoken('✿');
    });
  });

  group('ProductCard', () {
    Future<void> pumpCard(WidgetTester tester, {bool isFavorite = false}) {
      return pumpInApp(
        tester,
        Center(
          child: SizedBox(
            width: 180,
            height: ProductCard.height,
            child: ProductCard(
              product: apples,
              isFavorite: isFavorite,
              onFavoritePressed: () {},
              onAddPressed: () {},
            ),
          ),
        ),
      );
    }

    testWidgets('A1: product image is decorative', (tester) async {
      await pumpCard(tester);
      expectImagesDecorative(tester);
    });

    testWidgets('S2: favourite button has a name', (tester) async {
      await pumpCard(tester);
      expect(find.byTooltip('Add Red Apples to favourites'), findsOneWidget);

      await pumpCard(tester, isFavorite: true);
      expect(
        find.byTooltip('Remove Red Apples from favourites'),
        findsOneWidget,
      );
    });

    testWidgets('S2: favourite button exposes selected state', (tester) async {
      await pumpCard(tester, isFavorite: true);
      expect(
        tester.getSemantics(
          find.byTooltip('Remove Red Apples from favourites'),
        ),
        isSemantics(isButton: true, hasSelectedState: true, isSelected: true),
      );

      await pumpCard(tester);
      expect(
        tester.getSemantics(find.byTooltip('Add Red Apples to favourites')),
        isSemantics(isButton: true, hasSelectedState: true, isSelected: false),
      );
    });

    testWidgets('S3: add button names the product', (tester) async {
      await pumpCard(tester);
      expect(
        tester.getSemantics(find.byTooltip('Add Red Apples to basket')),
        isSemantics(isButton: true, tooltip: 'Add Red Apples to basket'),
      );
    });

    testWidgets('S4: details are read as one stop', (tester) async {
      await pumpCard(tester);
      final node = semanticsOf(tester, find.text('Red Apples'));
      for (final part in [
        'Red Apples',
        '1 kg',
        'Rated 4.6 out of 5, 128 reviews',
        r'$2.99',
      ]) {
        expect(node.label, contains(part));
      }
      // The price and name are in the same node, not separate stops.
      expect(
        tester.getSemantics(find.text(r'$2.99')),
        same(tester.getSemantics(find.text('Red Apples'))),
      );
    });
  });
}
