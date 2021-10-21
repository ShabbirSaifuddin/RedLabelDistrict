import 'package:flutter/material.dart';

import 'components/body.dart';

class SearchScreen extends StatelessWidget {
  static String routeName = "/search";
  late String text = "";
  List<dynamic> products = [];

  SearchScreen(String text, List<dynamic> Products) {
    this.text = text;
    this.products = Products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("You Searched For " + '$text'),
      ),
      body: Body(products, text),
    );
  }
}
