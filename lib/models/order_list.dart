import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minha_loja/models/cart.dart';
import 'package:minha_loja/models/order.dart';
import 'package:minha_loja/utils/constants.dart';

class OrderList with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  int get ordersCount => _orders.length;

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${Constants.ORDER_BASE_URL}.json'),
      body: jsonEncode({
        'total': cart.totalAmount,
        'date': date.toIso8601String(),
        'products':
            cart.items.values.map((item) {
              return {
                'id': item.id,
                'productId': item.productId,
                'name': item.name,
                'quantity': item.quantity,
                'price': item.price,
              };
            }).toList(),
      }),
    );
    final id = jsonDecode(response.body)['name'];

    _orders.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: date,
      ),
    );
    notifyListeners();
  }
}
