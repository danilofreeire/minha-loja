import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:minha_loja/data/dummy_data.dart';
import 'package:minha_loja/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;
  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  void addProductFromData(Map<String, Object> data) {
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      name: data['name'] as String,
      price: data['price'] as double,
      description: data['description'] as String,
      imageUrl: data['imageUrl'] as String,
    );
    addProduct(newProduct);
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
// bool _showFavoritesOnly = false;

//   List<Product> get items {
//     if (_showFavoritesOnly) {
//       return _items.where((product) => product.isFavorite).toList();
//     }
//     return [..._items];
//   }

//   void showFavoritesOnly() {
//     _showFavoritesOnly = true;
//     notifyListeners();
//   }

//   void showAll() {
//     _showFavoritesOnly = false;
//     notifyListeners();
//   }
