import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:redlabeldistrict/models/Cart.dart';
import 'package:redlabeldistrict/screens/cart/components/check_out_card.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double amount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: getProportionateScreenHeight(450),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: (demoCarts.length > 0)
                ? ListView.builder(
                    itemCount: demoCarts.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Dismissible(
                        key: Key(demoCarts[index].product.id.toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            demoCarts.removeAt(index);
                          });
                        },
                        background: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFE6E6),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Spacer(),
                              SvgPicture.asset("assets/icons/Trash.svg"),
                            ],
                          ),
                        ),
                        child: CartCard(cart: demoCarts[index], check: 0),
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
                            "Looks Like your Cart is Empty!!!",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
        demoCarts.length == 0 ? SizedBox.shrink() : CheckoutCard(demoCarts),
      ],
    );
  }
}
