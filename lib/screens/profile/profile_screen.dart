import 'package:flutter/material.dart';
import 'package:redlabeldistrict/components/coustom_bottom_nav_bar.dart';
import 'package:redlabeldistrict/models/OrderHistory.dart';

import '../../enums.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Order History",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${demoHistory.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
