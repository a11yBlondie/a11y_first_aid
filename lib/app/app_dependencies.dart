import '../features/cart/data/repositories/in_memory_cart_repository.dart';
import '../features/cart/domain/repositories/cart_repository.dart';
import '../features/cart/presentation/viewmodels/cart_view_model.dart';
import '../features/products/data/datasources/product_mock_data_source.dart';
import '../features/products/data/repositories/product_repository_impl.dart';
import '../features/products/domain/repositories/product_repository.dart';

class AppDependencies {
  AppDependencies({
    required this.productRepository,
    required CartRepository cartRepository,
  }) : cartViewModel = CartViewModel(repository: cartRepository);

  factory AppDependencies.mock({
    Duration latency = const Duration(milliseconds: 600),
  }) {
    return AppDependencies(
      productRepository: ProductRepositoryImpl(
        dataSource: ProductMockDataSource(latency: latency),
      ),
      cartRepository: InMemoryCartRepository(),
    );
  }

  final ProductRepository productRepository;
  final CartViewModel cartViewModel;
}
