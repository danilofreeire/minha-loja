import 'package:flutter/material.dart';
import 'package:minha_loja/providers/product_list.dart';

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
                    child: const Text('Favoritos'),
                    value: FilterOptions.favorites,
                  ),
                  PopupMenuItem(
                    child: const Text('Todos'),
                    value: FilterOptions.all,
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
        ],
      ),
      body: ProductGrid(showFavoritesOnly: _showFavoritesOnly),
    );
  }
}
