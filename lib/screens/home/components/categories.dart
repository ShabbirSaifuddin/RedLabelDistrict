import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:redlabeldistrict/network/network_calls.dart';
import 'package:redlabeldistrict/screens/products/products_page.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Categories extends StatefulWidget {
  List<dynamic> products = [];

  Categories(List<dynamic> product) {
    this.products = product;
  }

  @override
  State<Categories> createState() => _CategoriesState(products);
}

class _CategoriesState extends State<Categories> {
  List<dynamic> categories = [];
  List<dynamic> products = [];
  bool isLoading = true;

  _CategoriesState(List product) {
    this.products = product;
  }

  @override
  void initState() {
    super.initState();
    GetCategories();
  }

  void GetCategories() {


    if(SavedCategories.isEmpty){

      NetworkCalls nc = new NetworkCalls();
      nc.getCategories().then((value) {
        categories = value;
        saveCategories(categories);
        for (int i = 0; i < categories.length; i++) {
          print(categories[i].id);
          print(categories[i].name);
          print(categories[i].image);
        }
        setState(() {
          isLoading = false;
        });
      });
    }

    else{
      print(SavedCategories.length);
      setState(() {
        categories = SavedCategories;
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
        : Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  categories.length,
                  (index) => CategoryCard(
                    icon: categories[index].image,
                    text: categories[index].name,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductsScreen(categories[index].id, products)),
                      );
                    },
                  ),
                ),
              ),
            ));
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(100),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              padding: EdgeInsets.all(getProportionateScreenWidth(5)),
              height: getProportionateScreenWidth(100),
              width: getProportionateScreenWidth(100),
              decoration: BoxDecoration(
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(icon),
            ),
            SizedBox(height: 5),
            Text(text, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
