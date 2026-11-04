import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/cart/presentation/screens/cart_screen.dart';
import '../features/products/presentation/screens/products_screen.dart';
import 'app_dependencies.dart';
import 'app_routes.dart';

class FreshMarketApp extends StatelessWidget {
  const FreshMarketApp({super.key, required this.dependencies});

  final AppDependencies dependencies;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fresh Market',
      debugShowCheckedModeBanner: false,
      // Use it to spot missing labels, unwanted stops and wrong reading order.
      // showSemanticsDebugger: true,
      theme: AppTheme.light(),
      initialRoute: AppRoutes.products,
      routes: {
        AppRoutes.products: (_) => ProductsScreen(
          repository: dependencies.productRepository,
          cartViewModel: dependencies.cartViewModel,
        ),
        AppRoutes.cart: (_) =>
            CartScreen(viewModel: dependencies.cartViewModel),
      },
    );
  }
}
