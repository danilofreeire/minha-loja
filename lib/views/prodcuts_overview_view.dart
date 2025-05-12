import 'package:flutter/material.dart';
import 'package:minha_loja/data/dummy_data.dart';
import 'package:minha_loja/models/product.dart';
import 'package:minha_loja/widgets/product_item.dart';

class ProdcutsOverviewView extends StatelessWidget {
  final List<Product> loadedProducts = dummyProduct;
  ProdcutsOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children:
            loadedProducts
                .map((prod) => ProductItem(product: prod)) // direto aqui
                .toList(),
      ),
    );
  }
}
