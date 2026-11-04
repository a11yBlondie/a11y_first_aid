import 'package:flutter/foundation.dart';

import '../../../products/domain/entities/product.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';

class CartViewModel extends ChangeNotifier {
  CartViewModel({required this._repository});

  static const freeDeliveryThresholdCents = 3000;
  static const deliveryFeeCents = 499;

  final CartRepository _repository;

  List<CartItem> get items => _repository.items;
  bool get isEmpty => items.isEmpty;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  int get subtotalCents => items.fold(0, (sum, item) => sum + item.totalCents);

  int get deliveryCents =>
      isEmpty || subtotalCents >= freeDeliveryThresholdCents
      ? 0
      : deliveryFeeCents;

  int get totalCents => subtotalCents + deliveryCents;

  void addProduct(Product product) {
    _repository.add(product);
    notifyListeners();
  }

  void increment(CartItem item) {
    _repository.updateQuantity(item.product.id, item.quantity + 1);
    notifyListeners();
  }

  void decrement(CartItem item) {
    _repository.updateQuantity(item.product.id, item.quantity - 1);
    notifyListeners();
  }

  void remove(CartItem item) {
    _repository.remove(item.product.id);
    notifyListeners();
  }

  void placeOrder() {
    _repository.clear();
    notifyListeners();
  }
}
