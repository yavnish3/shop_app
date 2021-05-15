import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/provider/products.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(create: (ctx) => Products()),
        ChangeNotifierProvider<Cart>(create: (ctx) => Cart()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        fontFamily: 'Lato',
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => ProductOverviewScreen(),
        ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        CartScreen.routeName: (ctx) => CartScreen(),
      },
    );
  }
}
