import 'package:flutter/material.dart';
import 'package:redlabeldistrict/components/coustom_bottom_nav_bar.dart';

import '../../enums.dart';
import 'components/body.dart';

class Wishlist extends StatelessWidget {
  static String routeName = "/wishlist";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist"),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.wishlist),
    );
  }
}
