
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:redlabeldistrict/network/network_calls.dart';
import 'package:redlabeldistrict/screens/home/components/categories.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<dynamic> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    GetProducts();
  }

  Future<void> GetProducts() async {
    if (SavedProducts.isEmpty) {
      NetworkCalls nc = new NetworkCalls();
      nc.getProducts().then((value) {
        print("helloi");
        products = value;
        saveProducts(products);

        setState(() {
          isLoading = false;
        });
      });
    } else {
      print(SavedProducts.length);
      setState(() {
        products = SavedProducts;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(20)),
            child: LoadingRotating.square(
              borderColor: kPrimaryColor,
            ),
          )
        : SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HomeHeader(),
                  SizedBox(height: getProportionateScreenWidth(10)),
                  DiscountBanner(),
                  Categories(products),
                  SpecialOffers(),
                  // SizedBox(height: getProportionateScreenWidth(30)),
                  PopularProducts(products),
                  SizedBox(height: getProportionateScreenWidth(30)),
                ],
              ),
            ),
          );
  }
}
