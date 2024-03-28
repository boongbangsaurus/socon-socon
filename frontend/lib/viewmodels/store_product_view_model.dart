import 'package:flutter/foundation.dart';
import 'package:socon/models/socon_card.dart';


class ProductViewModel with ChangeNotifier {
  final ProductService _productService = ProductService();
  List<Socon> products = [];

  Future<void> fetchProducts() async {
    products = await _productService.fetchProducts();
    notifyListeners();
  }

  Future<void> addProduct(Socon product) async {
    final newProduct = await _productService.addProduct(product);
    products.add(newProduct);
    notifyListeners();
  }
}
