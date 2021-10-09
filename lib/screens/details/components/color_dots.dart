import 'package:flutter/material.dart';
import 'package:redlabeldistrict/components/rounded_icon_btn.dart';
import 'package:redlabeldistrict/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ColorDots extends StatefulWidget {
  const ColorDots({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<ColorDots> createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    int selectedColor = 3;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
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
                showToast(message: "Count Cannot be less then 1");
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
                showToast(message: "Count Cannot be Greater then 20");
              }
            },
          ),
        ],
      ),
    );
  }

  int Count() {
    return count;
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
            Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
