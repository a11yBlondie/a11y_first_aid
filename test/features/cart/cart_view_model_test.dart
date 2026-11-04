import 'package:a11y_first_aid/features/cart/data/repositories/in_memory_cart_repository.dart';
import 'package:a11y_first_aid/features/cart/presentation/viewmodels/cart_view_model.dart';
import 'package:a11y_first_aid/features/products/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const apples = Product(
    id: 'p-001',
    name: 'Red Apples',
    unit: '1 kg',
    priceCents: 299,
    imageAsset: 'assets/images/apples.png',
    rating: 4.6,
    reviewCount: 128,
  );

  late CartViewModel viewModel;

  setUp(() {
    viewModel = CartViewModel(repository: InMemoryCartRepository());
  });

  test('adding the same product twice increases its quantity', () {
    viewModel
      ..addProduct(apples)
      ..addProduct(apples);

    expect(viewModel.items, hasLength(1));
    expect(viewModel.itemCount, 2);
    expect(viewModel.subtotalCents, 598);
  });

  test('charges delivery below the free delivery threshold', () {
    viewModel.addProduct(apples);

    expect(viewModel.deliveryCents, CartViewModel.deliveryFeeCents);
    expect(viewModel.totalCents, 299 + CartViewModel.deliveryFeeCents);
  });

  test('decrementing the last unit removes the item', () {
    viewModel.addProduct(apples);
    viewModel.decrement(viewModel.items.single);

    expect(viewModel.isEmpty, isTrue);
    expect(viewModel.deliveryCents, 0);
  });

  test('placing an order empties the cart', () {
    viewModel
      ..addProduct(apples)
      ..placeOrder();

    expect(viewModel.isEmpty, isTrue);
  });
}
