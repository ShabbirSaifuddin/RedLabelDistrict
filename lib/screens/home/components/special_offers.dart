import 'package:flutter/material.dart';
import 'package:redlabeldistrict/screens/products/products_page.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            // title: "Special for you",
            title: "Special for you",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: "assets/images/Image Banner 1.jpg",
                category: "Clothing",
                press: () =>
                    Navigator.pushNamed(context, ProductsScreen.routeName),
              ),
              SpecialOfferCard(
                image: "assets/images/Image Banner 2.jpg",
                category: "Electronics",
                press: () =>
                    Navigator.pushNamed(context, ProductsScreen.routeName),
              ),
              SpecialOfferCard(
                image: "assets/images/Image Banner 3.jpg",
                category: "Shoes",
                press: () =>
                    Navigator.pushNamed(context, ProductsScreen.routeName),
              ),
              SpecialOfferCard(
                image: "assets/images/Image Banner 4.jpg",
                category: "Furniture",
                press: () =>
                    Navigator.pushNamed(context, ProductsScreen.routeName),
              ),
              SpecialOfferCard(
                image: "assets/images/Image Banner 5.jpg",
                category: "Fashion",
                press: () =>
                    Navigator.pushNamed(context, ProductsScreen.routeName),
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(242),
          height: getProportionateScreenWidth(100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(45.0),
                    vertical: getProportionateScreenWidth(30.0),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(20),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
