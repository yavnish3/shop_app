import 'package:flutter/material.dart';
import '../provider/order.dart' as ord;
import 'package:intl/intl.dart';
import 'dart:math';

class Orderitem extends StatefulWidget {
  final ord.OrderItem order;

  Orderitem(this.order);

  @override
  _OrderitemState createState() => _OrderitemState();
}

class _OrderitemState extends State<Orderitem> {
  bool _expand = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
                'Total Amount: \$${widget.order.price.toStringAsFixed(2)}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy  hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expand ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expand = !_expand;
                });
              },
            ),
          ),
          if (_expand)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.order.products.length * 20.0 + 10, 100),
              child: ListView(
                children: widget.order.products
                    .map(
                      (e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${e.quantity}x \$${e.price}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
