import '../../../products/domain/entities/product.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';

class InMemoryCartRepository implements CartRepository {
  final List<CartItem> _items = [];

  @override
  List<CartItem> get items => List.unmodifiable(_items);

  @override
  void add(Product product) {
    final index = _indexOf(product.id);
    if (index == -1) {
      _items.add(CartItem(product: product, quantity: 1));
    } else {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity + 1,
      );
    }
  }

  @override
  void updateQuantity(String productId, int quantity) {
    final index = _indexOf(productId);
    if (index == -1) return;

    if (quantity <= 0) {
      _items.removeAt(index);
    } else {
      _items[index] = _items[index].copyWith(quantity: quantity);
    }
  }

  @override
  void remove(String productId) =>
      _items.removeWhere((item) => item.product.id == productId);

  @override
  void clear() => _items.clear();

  int _indexOf(String productId) =>
      _items.indexWhere((item) => item.product.id == productId);
}
