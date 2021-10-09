import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:redlabeldistrict/models/Categories.dart';
import 'package:redlabeldistrict/models/Product.dart';

import '../constants.dart';
import 'connection.dart';

class NetworkCalls {
  Connection con = new Connection();
  var dio = Dio();
  List<CategoriesModel> categories = [];
  List<Product> product = [];

  Future<List> getCategories() async {
    print("Hitting : " + BASE_URL + CATEGORIES + KEY + PERPAGE2);
    if (await con.hasNetwork()) {
      try {
        final response = await http
            .get(Uri.parse(BASE_URL + CATEGORIES + KEY + PERPAGE2))
            .timeout(Duration(seconds: 90));
        if (response.statusCode == 200) {
          print(response.body);

          categories = (json.decode(response.body) as List).map((data) {
            return CategoriesModel.fromJSON(data);
          }).toList();
        }
        return categories;
      } catch (e) {
        showToast(message: "Error Getting Categories");
        print(e);
        return categories;
      }
    } else {
      showToast(message: "Error Getting Categories");
      print("Error In API");
      return categories;
    }
  }

  Future<List> getProducts() async {
    print("Hitting : " + BASE_URL + PRODUCTS + KEY + PERPAGE);
    if (await con.hasNetwork()) {
      try {
        final response = await http
            .get(Uri.parse(BASE_URL + PRODUCTS + KEY + PERPAGE))
            .timeout(Duration(seconds: 90));
        if (response.statusCode == 200) {
          print(response.body);

          product = (json.decode(response.body) as List).map((data) {
            return Product.fromJSON(data);
          }).toList();

          print(product.length);
        }
        return product;
      } catch (e) {
        showToast(message: "Error Getting Products");
        print(e);
        return product;
      }
    } else {
      showToast(message: "Error Getting Products");
      print("Error In API");
      return product;
    }
  }

  Future<List> createOrder(FormData body) async {
    print("Hitting : " + BASE_URL + ORDERS + KEY);
    if (await con.hasNetwork()) {
      try {
        final response = await http
            .post(Uri.parse(BASE_URL + ORDERS + KEY), body: body)
            .timeout(Duration(seconds: 90));
        if (response.statusCode == 200) {
          print(response.body);

          product = (json.decode(response.body) as List).map((data) {
            return Product.fromJSON(data);
          }).toList();

          print(product.length);
        }
        return product;
      } catch (e) {
        showToast(message: "Error Creating Order");
        print(e);
        return product;
      }
    } else {
      showToast(message: "Error Creating Order");
      print("Error In API");
      return product;
    }
  }
}
