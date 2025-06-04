import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:minha_loja/exceptions/http_exception.dart';
import 'package:minha_loja/models/product.dart';
import 'package:minha_loja/utils/constants.dart';

class ProductList with ChangeNotifier {
  final String _userId;
  String _token;
  List<Product> _items = [];
  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  ProductList([this._token = ' ', this._userId = '', this._items = const []]);

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(
      Uri.parse('${Constants.PRODUCT_BASE_URL}.json?auth=$_token'),
    );
    if (response.body == 'null') {
      return;
    }
    final favResponse = await http.get(
      Uri.parse('${Constants.USER_FAVORITES_URL}/${_userId}.json?auth=$_token'),
    );

    Map<String, dynamic> favData =
        favResponse.body == 'null'
            ? {}
            : jsonDecode(favResponse.body) as Map<String, dynamic>;

    final Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((productId, productData) {
      final isFavorite = favData[productId] ?? false;
      _items.add(
        Product(
          id: productId,
          name: productData['name'],
          price: productData['price'],
          description: productData['description'],
          imageUrl: productData['imageUrl'],
          isFavorite: isFavorite as bool,
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      price: data['price'] as double,
      description: data['description'] as String,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('${Constants.PRODUCT_BASE_URL}.json?auth=$_token'),
      body: jsonEncode({
        'name': product.name,
        'price': product.price,
        'description': product.description,
        'imageUrl': product.imageUrl,
      }),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(
      Product(
        id: id,
        name: product.name,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl,
      ),
    );
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse(
          '${Constants.PRODUCT_BASE_URL}/${product.id}.json?auth=$_token',
        ),
        body: jsonEncode({
          'name': product.name,
          'price': product.price,
          'description': product.description,
          'imageUrl': product.imageUrl,
        }),
      );

      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();
      final response = await http.delete(
        Uri.parse(
          '${Constants.PRODUCT_BASE_URL}/${product.id}.json?auth=$_token',
        ),
      );
      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
          message: 'Não foi possível excluir o produto.',
          statusCode: response.statusCode,
        );
      }
    }
  }
}
