import 'package:flutter/material.dart';
import 'package:redlabeldistrict/models/Wishlist.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.wishlist,
  }) : super(key: key);

  final Wishlist wishlist;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(wishlist.product.images[0]['src']),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: getProportionateScreenWidth(230),
              child: Text(
                wishlist.product.name,
                style: TextStyle(color: Colors.black, fontSize: 14),
                maxLines: 3,
              ),
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: wishlist.product.salePrice,
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
              ),
            )
          ],
        )
      ],
    );
  }
}
