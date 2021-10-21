import 'package:flutter/material.dart';
import 'package:redlabeldistrict/screens/search/search_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SearchField extends StatelessWidget {
  final fieldText = TextEditingController();

  // SearchField({
  //   Key? key,
  // }) : super(key: key);

  List<dynamic> products = [];

  SearchField(List<dynamic> Products) {
    this.products = Products;
  }

  void clearText() {
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.8,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: fieldText,
        onChanged: (value) => print(value),
        onSubmitted: (value) {
          clearText();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchScreen(value, products)),
          );
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(9)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search product",
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}
