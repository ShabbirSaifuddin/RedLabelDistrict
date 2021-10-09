import 'package:flutter/material.dart';

import 'components/body.dart';

class ProductsScreen extends StatelessWidget {
  List<dynamic> products = [];
  int categoryid = 0;

  ProductsScreen(int categoryId, List<dynamic> product) {
    this.categoryid = categoryId;
    this.products = product;
  }

  static String routeName = "/products";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: Body(categoryid, products),
    );
  }
}
