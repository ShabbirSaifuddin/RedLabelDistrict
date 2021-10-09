import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:redlabeldistrict/models/Product.dart';
import 'package:redlabeldistrict/models/Wishlist.dart';
import 'package:redlabeldistrict/screens/details/components/details.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    required this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback pressOnSeeMore;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  var background = Color(0xFFF5F6F9);

  // widget.product.isFavourite ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),

  var icon = Color(0xFFDBDEE4);

  // widget.product.isFavourite ? Color(0xFFFF4848) : Color(0xFFDBDEE4),

  bool isAvailable = false;

  @override
  void initState() {
    super.initState();
    checkWishlist();
  }

  void checkWishlist() {
    print("we are here");
    if (wishList.length != 0) {
      for (int i = 0; i < wishList.length; i++) {
        if (wishList[i].product.id == widget.product.id) {
          print("we are here 2");

          setState(() {
            background = Color(0xFFFFE6E6);
            icon = Color(0xFFFF4848);
            isAvailable == true;
          });
        } else {
          setState(() {
            print("we are here 3");
            background = Color(0xFFF5F6F9);
            icon = Color(0xFFDBDEE4);
            isAvailable == false;
          });
        }
      }
    } else {
      setState(() {
        print("we are here 4");
        isAvailable == false;
        background = Color(0xFFF5F6F9);
        icon = Color(0xFFDBDEE4);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            widget.product.name,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(15)),
            width: getProportionateScreenWidth(64),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: GestureDetector(
              onTap: () {
                if (isAvailable == false) {
                  print("we are here 5");
                  wishList.add(Wishlist(product: widget.product));
                  showToast(message: 'Product Added to Wishlist');
                  setState(() {
                    background = Color(0xFFFFE6E6);
                    icon = Color(0xFFFF4848);
                    isAvailable == true;
                  });
                } else if (isAvailable == true) {
                  print("we are here 6");
                  showToast(message: 'Please Remove Product from Wishlist');
                }
              },
              child: SvgPicture.asset(
                "assets/icons/Heart Icon_2.svg",
                color: icon,
                height: getProportionateScreenWidth(16),
              ),
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(64),
            ),
            child: SingleChildScrollView(
              child: Html(
                data: widget.product.shortDescription,
              ),
            )),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => showBarModalBottomSheet(
                    expand: false,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) =>
                        ModalInsideModal(false, widget.product.description),
                  ),
                  child: Text(
                    "See More Detail",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
