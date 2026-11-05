import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: Material(
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 164,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/promo_banner.png',
                  excludeFromSemantics: true,
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight,
                ),
                const Positioned(
                  left: 20,
                  top: 20,
                  child: Text(
                    '🍓 Weekend deals 🍋',
                    semanticsLabel: 'Weekend deals',
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
      child: Text(
        'Shop now →',
        semanticsLabel: 'Shop now',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
