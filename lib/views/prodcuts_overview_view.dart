import 'package:flutter/material.dart';
import 'package:minha_loja/models/cart.dart';
import 'package:minha_loja/models/product_list.dart';
import 'package:minha_loja/utils/app_routes.dart';
import 'package:minha_loja/widgets/app_drawer.dart';
import 'package:minha_loja/widgets/badgee.dart';

import 'package:minha_loja/widgets/product_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions { favorites, all }

class ProdcutsOverviewView extends StatefulWidget {
  const ProdcutsOverviewView({super.key});

  @override
  State<ProdcutsOverviewView> createState() => _ProdcutsOverviewViewState();
}

class _ProdcutsOverviewViewState extends State<ProdcutsOverviewView> {
  bool _showFavoritesOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductList>(context, listen: false).loadProducts().then((
      value,
    ) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder:
                (_) => [
                  PopupMenuItem(
                    value: FilterOptions.favorites,
                    child: const Text('Favoritos'),
                  ),
                  PopupMenuItem(
                    value: FilterOptions.all,
                    child: const Text('Todos'),
                  ),
                ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CART);
              },
              icon: Icon(Icons.shopping_cart),
            ),
            builder:
                (ctx, cart, child) =>
                    Badgee(value: cart.itemsCount.toString(), child: child!),
          ),
        ],
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : ProductGrid(showFavoritesOnly: _showFavoritesOnly),
      drawer: AppDrawer(),
    );
  }
}
