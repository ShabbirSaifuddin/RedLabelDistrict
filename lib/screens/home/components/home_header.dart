import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  // const HomeHeader({
  //   Key? key,
  // }) : super(key: key);
  List<dynamic> products = [];

  HomeHeader( List<dynamic> Products){
    this.products = Products;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            width: double.infinity,
            child: Image.asset(
              "assets/images/Logo.png",
              height: SizeConfig.screenHeight * 0.09,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SearchField(products),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
