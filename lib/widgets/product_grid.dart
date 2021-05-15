import 'package:flutter/material.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool showFav;
  ProductGrid(this.showFav);
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final product = showFav ? productData.favItem : productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: product.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: product[i],
        child: ProductItem(
            // product[i].id,
            // product[i].title,
            // product[i].imageUrl,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
