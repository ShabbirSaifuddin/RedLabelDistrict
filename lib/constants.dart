import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redlabeldistrict/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kPrimaryColor = Color(0xFF9E701E);
const kPrimaryLightColor = Color(0xFFFFDFA6);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF232323), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String kfNamelNullError = "Please Enter your first name";
const String klNamelNullError = "Please Enter your last name";
const String kCountrylNullError = "Please Enter your Country";
const String kStatelNullError = "Please Enter your State";
const String kCitylNullError = "Please Enter your City";
const String kZiplNullError = "Please Enter your Zip";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

// API constants

const String BASE_URL = "https://www.redlabeldistrict.com/wp-json/wc/v3/";
const String KEY = "?consumer_key=ck_083bbae5611b944393ea50f6fe13bb2b64f65e15&consumer_secret=cs_56fa133e800048bcda80aa56f8001b092bd33ea3";
const String CATEGORIES = "products/categories";
const String PRODUCTS = "products";
const String ORDERS = "orders";
const String PERPAGE = "&per_page=100";
const String PERPAGE2 = "&per_page=15";

// Check Variables

// Common Methods

showToast({required String message}) {
  Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
}

List<dynamic> SavedProducts = [];

saveProducts(List<dynamic> prod) {
  SavedProducts = prod;
}

List<dynamic> SavedCategories = [];

saveCategories(List<dynamic> prod) {
  SavedCategories = prod;
}
