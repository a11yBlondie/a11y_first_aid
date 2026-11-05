import 'package:flutter/material.dart';

import '../../../../app/app_routes.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../core/widgets/decorative_divider.dart';
import '../../../cart/presentation/viewmodels/cart_view_model.dart';
import '../../../cart/presentation/widgets/cart_badge_button.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../viewmodels/products_view_model.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/popular_products_list.dart';
import '../widgets/product_grid.dart';
import '../widgets/promo_banner.dart';
import '../widgets/section_title.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({
    super.key,
    required this.repository,
    required this.cartViewModel,
  });

  final ProductRepository repository;
  final CartViewModel cartViewModel;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late final ProductsViewModel _viewModel = ProductsViewModel(
    repository: widget.repository,
  );
  final _allProductsKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _viewModel.loadProducts();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _addToCart(Product product) {
    widget.cartViewModel.addProduct(product);
    // No change needed here: fixing task M1 in app_toast.dart also makes this
    // message spoken.
    AppToast.show(context, '${product.name} added to basket');
  }

  void _scrollToAllProducts() {
    final targetContext = _allProductsKey.currentContext;
    if (targetContext == null) return;
    Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) => switch (_viewModel.status) {
            // TODO(a11y): [M2 Status message]
            // The spinner is announced with no context, so users don't know
            // what is loading.
            // Fix:
            //
            //   ProductsStatus.loading => const Center(
            //     child: CircularProgressIndicator(
            //       semanticsLabel: 'Loading products',
            //     ),
            //   ),
            //
            // Test it by hand: the spinner shows for less than a second, so
            // TEMPORARILY make loading slower in lib/main.dart:
            //
            //   runApp(FreshMarketApp(dependencies: AppDependencies.mock(
            //     latency: const Duration(seconds: 10),
            //   )));
            //
            // Turn on TalkBack / VoiceOver and restart the app (hot reload is
            // not enough). Move to the spinner: you should hear "Loading
            // products". Undo the change when you're done.
            ProductsStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            ProductsStatus.failure => _ErrorView(
              onRetry: _viewModel.loadProducts,
            ),
            ProductsStatus.ready => _buildContent(),
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: HomeTopBar(
            trailing: CartBadgeButton(
              viewModel: widget.cartViewModel,
              onPressed: () => Navigator.of(context).pushNamed(AppRoutes.cart),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          sliver: SliverToBoxAdapter(
            child: PromoBanner(onTap: _scrollToAllProducts),
          ),
        ),
        const SliverToBoxAdapter(
          child: SectionTitle(title: 'Popular this week', decoration: '🔥🔥🔥'),
        ),
        SliverToBoxAdapter(
          child: PopularProductsList(
            products: _viewModel.popularProducts,
            isFavorite: _viewModel.isFavorite,
            onFavoritePressed: _viewModel.toggleFavorite,
            onAddPressed: _addToCart,
          ),
        ),
        const SliverToBoxAdapter(child: DecorativeDivider()),
        SliverToBoxAdapter(
          child: SectionTitle(
            key: _allProductsKey,
            title: 'All products',
            decoration: '🥕🍎🥦',
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
          sliver: SliverToBoxAdapter(
            child: ProductGrid(
              products: _viewModel.products,
              isFavorite: _viewModel.isFavorite,
              onFavoritePressed: _viewModel.toggleFavorite,
              onAddPressed: _addToCart,
            ),
          ),
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // TODO(a11y): [M3 Status message]
          // The error appears after loading, but nobody tells the screen reader
          // user about it.
          // Fix: make it a live region, so it is read as soon as it appears.
          //
          //   Semantics(
          //     liveRegion: true,
          //     child: const Text('Something went wrong'),
          //   ),
          //
          // Test it by hand: the mock data never fails, so TEMPORARILY make it
          // fail in
          // lib/features/products/data/datasources/product_mock_data_source.dart:
          //
          //   Future<List<Map<String, dynamic>>> fetchProducts() async {
          //     await Future<void>.delayed(latency);
          //     throw Exception('test'); // TEMP for M3
          //   }
          //
          // Turn on TalkBack / VoiceOver and restart the app. You should hear
          // "Something went wrong" as soon as it appears, without moving to it.
          // Tap "Try again": it should be read again. Undo the change when
          // you're done.
          const Text('Something went wrong'),
          const SizedBox(height: 12),
          OutlinedButton(onPressed: onRetry, child: const Text('Try again')),
        ],
      ),
    );
  }
}
