import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/order.dart';
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/order-screen';
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AapDrawer(),
      body: ordersData.orders.isEmpty
          ? Center(
              child: Text('No Orders!!'),
            )
          : ListView.builder(
              itemCount: ordersData.orders.length,
              itemBuilder: (ctx, i) => Orderitem(ordersData.orders[i]),
            ),
    );
  }
}
