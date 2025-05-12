import 'package:flutter/material.dart';
import 'package:minha_loja/utils/app_routes.dart';
import 'package:minha_loja/views/prodcuts_overview_view.dart';
import 'package:minha_loja/views/product_detail_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        hintColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      home: ProdcutsOverviewView(),
      routes: {AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailView()},
      debugShowCheckedModeBanner: false,
    );
  }
}
