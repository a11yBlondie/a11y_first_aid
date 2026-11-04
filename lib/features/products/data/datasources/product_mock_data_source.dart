class ProductMockDataSource {
  const ProductMockDataSource({this.latency = Duration.zero});

  final Duration latency;

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    await Future<void>.delayed(latency);
    return _products;
  }

  static const _products = <Map<String, dynamic>>[
    {
      'id': 'p-001',
      'name': 'Red Apples',
      'unit': '1 kg',
      'price_cents': 299,
      'image': 'assets/images/apples.png',
      'rating': 4.6,
      'reviews': 128,
      'organic': true,
      'popular': true,
    },
    {
      'id': 'p-002',
      'name': 'Hass Avocado',
      'unit': '2 pcs',
      'price_cents': 349,
      'image': 'assets/images/avocado.png',
      'rating': 4.2,
      'reviews': 86,
      'organic': false,
      'popular': true,
    },
    {
      'id': 'p-003',
      'name': 'Strawberries',
      'unit': '500 g',
      'price_cents': 459,
      'image': 'assets/images/strawberries.png',
      'rating': 4.8,
      'reviews': 212,
      'organic': true,
      'popular': true,
    },
    {
      'id': 'p-004',
      'name': 'Carrots',
      'unit': '1 kg',
      'price_cents': 149,
      'image': 'assets/images/carrots.png',
      'rating': 4.1,
      'reviews': 54,
      'organic': true,
      'popular': false,
    },
    {
      'id': 'p-005',
      'name': 'Broccoli',
      'unit': '1 pc',
      'price_cents': 199,
      'image': 'assets/images/broccoli.png',
      'rating': 3.9,
      'reviews': 37,
      'organic': false,
      'popular': false,
    },
    {
      'id': 'p-006',
      'name': 'Oranges',
      'unit': '1 kg',
      'price_cents': 279,
      'image': 'assets/images/oranges.png',
      'rating': 4.4,
      'reviews': 99,
      'organic': false,
      'popular': true,
    },
    {
      'id': 'p-007',
      'name': 'Lemons',
      'unit': '4 pcs',
      'price_cents': 189,
      'image': 'assets/images/lemons.png',
      'rating': 4.0,
      'reviews': 41,
      'organic': false,
      'popular': false,
    },
    {
      'id': 'p-008',
      'name': 'Green Grapes',
      'unit': '500 g',
      'price_cents': 399,
      'image': 'assets/images/grapes.png',
      'rating': 4.5,
      'reviews': 73,
      'organic': true,
      'popular': false,
    },
  ];
}
