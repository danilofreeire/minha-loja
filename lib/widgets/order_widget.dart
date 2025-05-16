import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minha_loja/models/order.dart';

class OrderWidget extends StatelessWidget {
  final Order order;

  const OrderWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Total: R\$ ${order.total.toStringAsFixed(2)}'),
        subtitle: Text(
          'Pedido em ${DateFormat('dd/MM/yyyy hh:mm').format(order.date)}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            // Implement navigation to order details
          },
        ),
      ),
    );
  }
}
