import 'package:flutter/material.dart';
import 'package:minha_loja/models/product_list.dart';
import 'package:minha_loja/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoritesOnly;

  ProductGrid({super.key, required this.showFavoritesOnly});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final loadedProducts =
        showFavoritesOnly ? provider.favoriteItems : provider.items;

    return GridView(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children:
          loadedProducts
              .map(
                (prod) => ChangeNotifierProvider.value(
                  value: prod,
                  child: ProductItem(),
                ),
              ) // direto aqui
              .toList(),
    );
  }
}
