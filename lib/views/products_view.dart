import 'package:flutter/material.dart';
import 'package:minha_loja/models/product_item.dart';
import 'package:minha_loja/models/product_list.dart';
import 'package:minha_loja/utils/app_routes.dart';
import 'package:minha_loja/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder:
              (ctx, i) => Column(
                children: [
                  ProductItem(product: products.items[i]),
                  const Divider(),
                ],
              ),
        ),
      ),
    );
  }
}
