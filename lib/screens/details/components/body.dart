import 'package:flutter/material.dart';
import 'package:redlabeldistrict/components/default_button.dart';
import 'package:redlabeldistrict/components/rounded_icon_btn.dart';
import 'package:redlabeldistrict/constants.dart';
import 'package:redlabeldistrict/models/Cart.dart';
import 'package:redlabeldistrict/models/Product.dart';
import 'package:redlabeldistrict/size_config.dart';

import 'product_description.dart';
import 'product_images.dart';
import 'top_rounded_container.dart';

class Body extends StatefulWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: widget.product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: widget.product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    // ColorDots(product: product),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: Row(
                        children: [
                          // ...List.generate(
                          //   product.colors.length,
                          //   (index) => ColorDot(
                          //     color: product.colors[index],
                          //     isSelected: index == selectedColor,
                          //   ),
                          // ),
                          Spacer(),
                          RoundedIconBtn(
                            icon: Icons.remove,
                            press: () {
                              if (count > 1) {
                                setState(() {
                                  count--;
                                });
                              } else {
                                showToast(
                                    message: "Count Cannot be less then 1");
                              }
                            },
                          ),
                          SizedBox(width: getProportionateScreenWidth(10)),
                          Text(
                            '$count',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: getProportionateScreenWidth(10)),
                          RoundedIconBtn(
                            icon: Icons.add,
                            showShadow: true,
                            press: () {
                              if (count < 20) {
                                setState(() {
                                  count++;
                                });
                              } else {
                                showToast(
                                    message: "Count Cannot be Greater then 20");
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    TopRoundedContainer(
                      color: kPrimaryLightColor,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(42),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Add To Cart",
                          press: () {

                            /// need to work on this to make sure that each product is getting added into the cart properly
                            if (demoCarts.length != 0) {
                              for (int i = 0; i < demoCarts.length; i++) {
                                print("debuging 1");
                                if (demoCarts[i].product.id == widget.product.id) {
                                  print("debuging 2");
                                  print("number of items before : " + demoCarts[i].numOfItem.toString());
                                  demoCarts[i].numOfItem = count + demoCarts[i].numOfItem;
                                  print("number of items after : " + demoCarts[i].numOfItem.toString());
                                  showToast(message: "Product Added to Cart Successfully");
                                  break;
                                } else {
                                  print("debuging 3");
                                  demoCarts.add(Cart(product: widget.product, numOfItem: count));
                                  showToast(message: "Product Added to Cart Successfully");
                                  break;
                                }
                              }
                            } else {
                              print("debuging 4");
                              demoCarts.add(Cart(product: widget.product, numOfItem: count));
                              showToast(message: "Product Added to Cart Successfully");
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
