import '../../../products/domain/entities/product.dart';

class CartItem {
  const CartItem({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  int get totalCents => product.priceCents * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(product: product, quantity: quantity ?? this.quantity);
  }
}
