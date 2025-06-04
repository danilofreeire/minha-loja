import 'package:flutter/material.dart';
import 'package:minha_loja/models/auth.dart';
import 'package:minha_loja/models/cart.dart';
import 'package:minha_loja/models/order.dart';
import 'package:minha_loja/models/order_list.dart';
import 'package:minha_loja/models/product_list.dart';
import 'package:minha_loja/utils/app_routes.dart';
import 'package:minha_loja/views/auth_or_home_page.dart';
import 'package:minha_loja/views/auth_view.dart';
import 'package:minha_loja/views/cart_view.dart';
import 'package:minha_loja/views/orders_view.dart';
import 'package:minha_loja/views/prodcuts_overview_view.dart';
import 'package:minha_loja/views/product_detail_view.dart';
import 'package:minha_loja/views/product_form_view.dart';
import 'package:minha_loja/views/products_view.dart';
import 'package:minha_loja/widgets/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your applicat ion.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (ctx) => ProductList('', []),
          update: (ctx, auth, previous) {
            return ProductList(auth.token ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (ctx) => OrderList('', []),
          update: (ctx, auth, previous) {
            return OrderList(auth.token ?? '', previous?.orders ?? []);
          },
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.theme,
        routes: {
          AppRoutes.AUTH_OR_HOME: (ctx) => AuthOrHomePage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailView(),
          AppRoutes.CART: (ctx) => CartView(),
          AppRoutes.ORDERS: (ctx) => OrdersView(),
          AppRoutes.PRODUCTS: (ctx) => ProductsView(),
          AppRoutes.PRODUCT_FORM: (ctx) => ProductFormView(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
