import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redlabeldistrict/network/connection.dart';
import 'package:redlabeldistrict/screens/OnBoardingScreen/OnBoardingScreen.dart';
import 'package:redlabeldistrict/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../size_config.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getpref();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Image.asset(
        'assets/images/Comp 1_1.gif',
        fit: BoxFit.fill,
      ),
    );
  }

  void getpref() async {
    Connection con = new Connection();
    bool isOnline = await con.hasNetwork();
    SharedPreferences pref = await SharedPreferences.getInstance();
    int checker = (pref.getInt('checker') ?? 0);
    if (checker == 1) {
      if (isOnline) {
        Timer(
            Duration(seconds: 4),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen())));
      }
    } else {
      if (isOnline) {
        Timer(
            Duration(seconds: 4),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => OnBoardingPage())));
      }
    }
  }
}
