import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_mock_data_source.dart';
import '../models/product_dto.dart';

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl({required this._dataSource});

  final ProductMockDataSource _dataSource;

  @override
  Future<List<Product>> getProducts() async {
    final json = await _dataSource.fetchProducts();
    return json.map((item) => ProductDto.fromJson(item).toEntity()).toList();
  }
}
