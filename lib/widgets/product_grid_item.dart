import 'package:flutter/material.dart';
import 'package:minha_loja/models/cart.dart';
import 'package:minha_loja/models/product.dart';
import 'package:minha_loja/utils/app_routes.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder:
                (ctx, product, child) => IconButton(
                  onPressed: () {
                    product.toggleFavorite();
                  },
                  icon: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Theme.of(context).hintColor,
                  ),
                ),
          ),

          title: Text(product.name, textAlign: TextAlign.center),
          trailing: IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Produto adicionado com sucesso!'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'Desfazer',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
              cart.addItem(product);
            },
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).hintColor,
          ),

          backgroundColor: Colors.black87,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(
              context,
            ).pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: product);
          },
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
