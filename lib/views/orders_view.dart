import 'package:flutter/material.dart';
import 'package:minha_loja/models/order_list.dart';
import 'package:minha_loja/widgets/app_drawer.dart';
import 'package:minha_loja/widgets/order_widget.dart';
import 'package:provider/provider.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  bool _isLoading = true;
  initState() {
    super.initState();
    Provider.of<OrderList>(context, listen: false).loadOrders().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of<OrderList>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: orders.ordersCount,
                itemBuilder: (ctx, i) => OrderWidget(order: orders.orders[i]),
              ),
      drawer: AppDrawer(),
    );
  }
}
