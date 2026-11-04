import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // TODO(a11y): [S10 Semantics]
    // The banner is tappable, but the screen reader does not say it is a
    // button.
    // Fix: wrap the Material in Semantics(button: true).
    //
    //   return Semantics(
    //     button: true,
    //     child: Material(...),
    //   );
    return Material(
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 164,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // TODO(a11y): [A2 Alt text]
              // The image has no alt text. It shows a basket of fruit behind
              // the text and adds no information.
              // Fix: mark it as decorative.
              //
              //   Image.asset(
              //     'assets/images/promo_banner.png',
              //     excludeFromSemantics: true,
              //     ...
              //   ),
              Image.asset(
                'assets/images/promo_banner.png',
                fit: BoxFit.cover,
                alignment: Alignment.centerRight,
              ),
              // TODO(a11y): [S10 Semantics]
              // The emojis are read aloud: "strawberry, Weekend deals, lemon".
              // Fix: add `semanticsLabel: 'Weekend deals'` to the Text.
              const Positioned(
                left: 20,
                top: 20,
                child: Text(
                  '🍓 Weekend deals 🍋',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Positioned(
                left: 20,
                top: 56,
                right: 150,
                child: Text(
                  'Up to 30% off fresh fruit this week',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ),
              const Positioned(left: 20, bottom: 18, child: _ShopNowPill()),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShopNowPill extends StatelessWidget {
  const _ShopNowPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      // TODO(a11y): [S10 Semantics]
      // The arrow is read aloud: "Shop now, right arrow".
      // Fix: add `semanticsLabel: 'Shop now'` to the Text.
      child: Text(
        'Shop now →',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
