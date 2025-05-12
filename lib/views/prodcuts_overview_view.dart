import 'package:flutter/material.dart';
import 'package:minha_loja/data/dummy_data.dart';
import 'package:minha_loja/models/product.dart';

class ProdcutsOverviewView extends StatelessWidget {
  final List<Product> loadedProducts = dummyProduct;
  ProdcutsOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minha Loja')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          children:
              loadedProducts
                  .map(
                    (prod) => Card(child: Column(children: [Text(prod.title)])),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
