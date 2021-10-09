import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'popular_product.dart';

class Body extends StatelessWidget {
  List<dynamic> products = [];
  int categoryid = 0;

  Body(int categoryId, List<dynamic> product) {
    this.categoryid = categoryId;
    this.products = product;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            PopularProducts(categoryid, products),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
