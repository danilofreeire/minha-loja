import 'package:flutter/material.dart';
import 'package:minha_loja/models/order_list.dart';
import 'package:minha_loja/widgets/app_drawer.dart';
import 'package:minha_loja/widgets/order_widget.dart';
import 'package:provider/provider.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of<OrderList>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: orders.ordersCount,
        itemBuilder: (ctx, i) => OrderWidget(order: orders.orders[i]),
      ),
      drawer: AppDrawer(),
    );
  }
}
