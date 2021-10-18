import 'package:flutter/material.dart';
import 'package:redlabeldistrict/components/coustom_bottom_nav_bar.dart';
import 'package:redlabeldistrict/models/Wishlist.dart';

import '../../enums.dart';
import 'components/body.dart';

class Wishlist extends StatelessWidget {
  static String routeName = "/wishlist";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.wishlist),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Wishlist",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${wishList.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
