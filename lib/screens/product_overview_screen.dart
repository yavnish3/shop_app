import 'package:flutter/material.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/widgets/product_grid.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/provider/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import '../widgets/app_drawer.dart';

enum filterOption {
  Favorite,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFav = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    //Provider.of<Products>(context).fetchAndSetProducts();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (filterOption selectedValue) {
              setState(() {
                if (selectedValue == filterOption.Favorite) {
                  _showFav = true;
                } else {
                  _showFav = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorite'),
                value: filterOption.Favorite,
              ),
              PopupMenuItem(child: Text('Show All'), value: filterOption.All),
            ],
          ),
          Consumer<Cart>(
            builder: (ctx, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
              color: Colors.green,
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AapDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(_showFav),
    );
  }
}
