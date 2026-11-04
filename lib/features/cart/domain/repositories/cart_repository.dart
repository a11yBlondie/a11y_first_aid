import '../../../products/domain/entities/product.dart';
import '../entities/cart_item.dart';

abstract interface class CartRepository {
  List<CartItem> get items;

  void add(Product product);

  void updateQuantity(String productId, int quantity);

  void remove(String productId);

  void clear();
}
