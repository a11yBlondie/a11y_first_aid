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
            ProductsStatus.loading => const Center(
              child: CircularProgressIndicator(
                semanticsLabel: 'Loading products',
              ),
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
          Semantics(
            liveRegion: true,
            child: const Text('Something went wrong'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(onPressed: onRetry, child: const Text('Try again')),
        ],
      ),
    );
  }
}
