import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redlabeldistrict/models/Cart.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key? key,
    required this.cart,
    required this.check,
  }) : super(key: key);

  final Cart cart;
  final int check;

  @override
  State<CartCard> createState() => _CartCardState(check);
}

class _CartCardState extends State<CartCard> {
  late int check;

  _CartCardState(int Check) {
    this.check = Check;
  }

  double price = 0;

  @override
  Widget build(BuildContext context) {
    int count = widget.cart.numOfItem;
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
              // child: Image.network(widget.cart.product.images[0]['src']),
              child: CachedNetworkImage(
                imageUrl: widget.cart.product.images[0]['src'],
                placeholder: (context, url) =>
                    Image.asset("assets/images/Logo_b:w.png"),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/images/Logo_b:w.png"),
              ),
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
                widget.cart.product.name,
                style: TextStyle(color: Colors.black, fontSize: 14),
                maxLines: 3,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    text: widget.cart.product.salePrice,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(50)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (check == 0)
                        ? GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 6),
                                    blurRadius: 10,
                                    color: Color(0xFFB0B0B0).withOpacity(0.3),
                                  ),
                                ],
                              ),
                              child: Icon(Icons.remove),
                            ),
                            onTap: () {
                              if (count > 1) {
                                setState(() {
                                  count--;
                                  for (int i = 0; i < demoCarts.length; i++) {
                                    if (demoCarts[i].product.id ==
                                        widget.cart.product.id) {
                                      setState(() {
                                        demoCarts[i].numOfItem = count;
                                      });
                                      print("demoCarts[i].numOfItem  :" +
                                          widget.cart.numOfItem.toString());
                                    }
                                  }
                                });
                              } else {
                                showToast(
                                    message: "Count Cannot be less then 1");
                              }
                            },
                          )
                        : Text("Qty: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      '$count',
                    ),
                    (check == 0)
                        ? GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 6),
                                    blurRadius: 10,
                                    color: Color(0xFFB0B0B0).withOpacity(0.3),
                                  ),
                                ],
                              ),
                              child: Icon(Icons.add),
                            ),
                            onTap: () {
                              if (count < 20) {
                                setState(() {
                                  count++;
                                  for (int i = 0; i < demoCarts.length; i++) {
                                    if (demoCarts[i].product.id ==
                                        widget.cart.product.id) {
                                      setState(() {
                                        demoCarts[i].numOfItem = count;
                                      });
                                      print("demoCarts[i].numOfItem  :" +
                                          widget.cart.numOfItem.toString());
                                    }
                                  }
                                });
                              } else {
                                showToast(
                                    message: "Count Cannot be Greater then 20");
                              }
                            },
                          )
                        : SizedBox(
                            height: 0,
                          ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
