import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/order.dart';
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/order-screen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future _ordersFuture;

  Future _obtainOrserFuture() {
    return Provider.of<Order>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrserFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final ordersData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AapDrawer(),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('AN Error Occered'),
              );
            } else {
              return Consumer<Order>(
                builder: (ctx, ordersData, child) => ListView.builder(
                  itemCount: ordersData.orders.length,
                  itemBuilder: (ctx, i) => Orderitem(ordersData.orders[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
