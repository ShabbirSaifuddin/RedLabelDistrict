import 'package:flutter/material.dart';

import 'components/body.dart';

class SearchScreen extends StatelessWidget {
  static String routeName = "/search";
  late String text = "";

  SearchScreen(String text) {
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("You Searched For " + '$text'),
      ),
      body: Body(),
    );
  }
}
