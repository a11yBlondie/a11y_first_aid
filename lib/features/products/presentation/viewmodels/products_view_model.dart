import 'package:flutter/foundation.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

enum ProductsStatus { loading, ready, failure }

class ProductsViewModel extends ChangeNotifier {
  ProductsViewModel({required this._repository});

  final ProductRepository _repository;

  ProductsStatus _status = ProductsStatus.loading;
  List<Product> _products = const [];
  final Set<String> _favoriteIds = {};

  ProductsStatus get status => _status;
  List<Product> get products => List.unmodifiable(_products);
  List<Product> get popularProducts =>
      _products.where((product) => product.isPopular).toList();

  bool isFavorite(Product product) => _favoriteIds.contains(product.id);

  Future<void> loadProducts() async {
    _status = ProductsStatus.loading;
    notifyListeners();

    try {
      _products = await _repository.getProducts();
      _status = ProductsStatus.ready;
    } catch (_) {
      _status = ProductsStatus.failure;
    }
    notifyListeners();
  }

  void toggleFavorite(Product product) {
    if (!_favoriteIds.remove(product.id)) {
      _favoriteIds.add(product.id);
    }
    notifyListeners();
  }
}
