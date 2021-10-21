import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'popular_product.dart';

class Body extends StatelessWidget {
  List<dynamic> products = [];
  late String search;

  Body(List<dynamic> product, String Search) {
    this.products = product;
    this.search = Search;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            PopularProducts(search, products),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
