import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:redlabeldistrict/components/default_button.dart';
import 'package:redlabeldistrict/models/Cart.dart';
import 'package:redlabeldistrict/screens/cart/components/voucher.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'checkout.dart';

class CheckoutCard extends StatelessWidget {
  // const CheckoutCard({
  //   Key? key,
  // }) : super(key: key);

  List<Cart> demoCarts = [];
  double total = 0;

  CheckoutCard(List<Cart> demoCart) {
    this.demoCarts = demoCart;
    getTotal();
  }

  getTotal() {
    if (demoCarts.length > 0) {
      for (int i = 0; i < demoCarts.length; i++) {
        double amount = double.parse(demoCarts[i].product.salePrice);
        total = total + amount;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => showBarModalBottomSheet(
                    expand: false,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => ModalInsideModal(),
                  ),
                  child: Text("Add voucher code"),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "\$$total",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Check Out",
                    press: () {
                      showBarModalBottomSheet(
                        expand: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => Checkout(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
