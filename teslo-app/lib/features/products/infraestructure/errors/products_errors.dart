class ProductNotFound implements Exception {
  final String message;

  ProductNotFound([this.message = 'Product not found']);

  @override
  String toString() => message;
}
