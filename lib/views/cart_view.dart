import 'package:flutter/material.dart';
import 'package:minha_loja/models/cart.dart';
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
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(25),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 20),

                  Text(
                    'R\$${cart.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Chip(
                  //   labelPadding: const EdgeInsets.all(4),
                  //   backgroundColor: Theme.of(context).primaryColor,
                  //   label: Text(
                  //     'R\$1000',
                  //     style: TextStyle(
                  //       color:
                  //           Theme.of(
                  //             context,
                  //           ).primaryTextTheme.headlineLarge?.color,
                  //     ),
                  //   ),
                  // ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text('COMPRAR'),
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor:
                          Theme.of(
                            context,
                          ).primaryTextTheme.headlineLarge?.color,
                      textStyle: TextStyle(
                        color:
                            Theme.of(
                              context,
                            ).primaryTextTheme.headlineLarge?.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: cart.itemsCount,
              itemBuilder: (ctx, i) => CartItemWidget(cartItem: items[i]),
            ),
          ),
        ],
      ),
    );
  }
}
