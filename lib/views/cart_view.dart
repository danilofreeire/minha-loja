import 'package:flutter/material.dart';
import 'package:minha_loja/models/cart.dart';
import 'package:minha_loja/models/order.dart';
import 'package:minha_loja/models/order_list.dart';
import 'package:minha_loja/widgets/cart_item_widget.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(
          bottom: 100,
        ), // espaço para não cobrir o botão
        itemCount: cart.itemsCount,
        itemBuilder: (ctx, i) => CartItemWidget(cartItem: items[i]),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F2FB),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, -1),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:', style: TextStyle(fontSize: 18)),
                Text(
                  'R\$${cart.totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<OrderList>(context, listen: false).addOrder(cart);
                  cart.clear();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'COMPRAR',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
