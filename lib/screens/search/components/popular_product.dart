import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:redlabeldistrict/components/product_card.dart';

class PopularProducts extends StatelessWidget {

  List<dynamic> products = [];
  String search = "";

  PopularProducts(String Search, List<dynamic> product) {
    this.search = Search;
    this.products = product;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: double.infinity,
      child: StaggeredGridView.countBuilder(
        scrollDirection: Axis.vertical,
        crossAxisCount: 4,
        itemCount: products.length,
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        itemBuilder: (BuildContext context, int index) =>
        products[index].name.contains(search)
            ? ProductCard(product: products[index])
            : SizedBox.shrink(),
      ),
    );
  }
}
