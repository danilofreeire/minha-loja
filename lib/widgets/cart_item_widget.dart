import 'package:flutter/material.dart';
import 'package:minha_loja/models/cart.dart';
import 'package:minha_loja/models/cart_item.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        child: const Icon(Icons.delete, color: Colors.white, size: 28),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      confirmDismiss: (_) {
        return showDialog<bool>(
          context: context,
          builder:
              (ctx) => AlertDialog(
                title: Text('Tem Certeza?'),
                content: Text('Deseja remover o item do carrinho?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                    },
                    child: const Text('Não'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(true);
                    },
                    child: const Text('Sim'),
                  ),
                ],
              ),
        );
      },
      onDismissed: (_) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).removeItem(cartItem.productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(cartItem.imageUrl ?? ''),
            ),

            title: Text(cartItem.name),
            subtitle: Text(
              'Total: R\$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
            ),
            trailing: Text(
              '${cartItem.quantity}x',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
