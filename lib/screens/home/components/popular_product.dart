import 'package:flutter/material.dart';
import 'package:redlabeldistrict/components/product_card.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  late List<dynamic> products = [];

  PopularProducts(List<dynamic> product) {
    this.products = product;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Products On Sale", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                products.length,
                (index) {
                  if (products[index].isSale)
                    return ProductCard(product: products[index]);

                  return SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
