import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minha_loja/models/cart_item.dart';
import 'package:minha_loja/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _item = {};

  Map<String, CartItem> get items => {..._item};

  int get itemsCount {
    return _item.length;
  }

  double get totalAmount {
    double total = 0.0;
    _item.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_item.containsKey(product.id)) {
      _item.update(
        product.id,
        (existingItem) => CartItem(
          id: existingItem.id,
          name: existingItem.name,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
          productId: product.id,
        ),
      );
    } else {
      _item.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          name: product.name,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _item.remove(productId);
    notifyListeners();
  }

  void clear() {
    _item = {};
    notifyListeners();
  }
}
