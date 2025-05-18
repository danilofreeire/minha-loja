import 'package:flutter/material.dart';
import 'package:minha_loja/models/cart.dart';
import 'package:minha_loja/models/order_list.dart';
import 'package:minha_loja/models/product_list.dart';
import 'package:minha_loja/utils/app_routes.dart';
import 'package:minha_loja/views/cart_view.dart';
import 'package:minha_loja/views/orders_view.dart';
import 'package:minha_loja/views/prodcuts_overview_view.dart';
import 'package:minha_loja/views/product_detail_view.dart';
import 'package:minha_loja/views/products_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductList()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => OrderList()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          hintColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        routes: {
          AppRoutes.HOME: (ctx) => ProdcutsOverviewView(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailView(),
          AppRoutes.CART: (ctx) => CartView(),
          AppRoutes.ORDERS: (ctx) => OrdersView(),
          AppRoutes.PRODCUTS: (ctx) => ProductsView(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
