import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:redlabeldistrict/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  void initState() {
    setpref();
  }

  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  Widget _buildFullscrenImage(String assetName) {
    return Image.asset(
      'assets/images/$assetName',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle =
        TextStyle(fontSize: 15.0, backgroundColor: Colors.transparent);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topRight,
      ),
      pages: [
        PageViewModel(
          title: "Variety of Products",
          body:
              "Life is a succession of lessons which must be lived to be understood.",
          image: _buildFullscrenImage('SCR-3.png'),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 8,
            imageFlex: 3,
          ),
        ),
        PageViewModel(
          title: "Shop Online From Anywhere",
          body:
              "You come into the world with nothing, and the purpose of your life is to make something out of nothing.",
          image: _buildFullscrenImage('SCR-2.png'),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 8,
            imageFlex: 3,
          ),
        ),
        PageViewModel(
          title: "Worldwide Delivery",
          body: "Life is what happens while you are busy making other plans.",
          image: _buildFullscrenImage('SCR-1.png'),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 8,
            imageFlex: 3,
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text(
        'Skip',
        style: TextStyle(color: Colors.white),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      done: const Text('Done',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFF868686),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          activeColor: Colors.white),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }

  setpref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("checker", 1);
  }
}
