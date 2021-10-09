import 'package:flutter/material.dart';

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: double.infinity,
      // child: StaggeredGridView.countBuilder(
      //   crossAxisCount: demoProducts.length,
      //   itemCount: demoProducts.length,
      //   staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
      //   mainAxisSpacing: 4.0,
      //   crossAxisSpacing: 4.0,
      //   itemBuilder: (BuildContext context, int index) =>
      //       new ProductCard(product: demoProducts[index]),
      // ),
    );
  }
}
