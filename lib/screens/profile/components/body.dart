import 'package:flutter/material.dart';
import 'package:redlabeldistrict/models/OrderHistory.dart';

import '../../../size_config.dart';
import 'order_card.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    // return SingleChildScrollView(
    //   padding: EdgeInsets.symmetric(vertical: 20),
    //   child: Column(
    //     children: [
    //       ProfilePic(),
    //       SizedBox(height: 20),
    //       ProfileMenu(
    //         text: "My Account",
    //         icon: "assets/icons/User Icon.svg",
    //         press: () => {},
    //       ),
    //       ProfileMenu(
    //         text: "Previous Orders",
    //         icon: "assets/icons/Clock.svg",
    //         press: () {},
    //       ),
    //       ProfileMenu(
    //         text: "Settings",
    //         icon: "assets/icons/Settings.svg",
    //         press: () {},
    //       ),
    //       ProfileMenu(
    //         text: "Help Center",
    //         icon: "assets/icons/Question mark.svg",
    //         press: () {},
    //       ),
    //       ProfileMenu(
    //         text: "Log Out",
    //         icon: "assets/icons/Log out.svg",
    //         press: () {},
    //       ),
    //     ],
    //   ),
    // );
    return Column(
      children: [
        Container(
          height: getProportionateScreenHeight(450),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: (demoHistory.length > 0)
                ? ListView.builder(
                    itemCount: demoHistory.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: OrderCard(
                        orderhistory: demoHistory[index],
                      ),
                    ),
                  )
                : Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Column(
                        children: [
                          Image.asset("assets/images/emptycart.png"),
                          Text(
                            "Looks Like you Haven't Ordered Anything!!!",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
