import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:store/screens/home_page.dart';

import '../main_wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 6), () {
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainWrapper()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DelayedWidget(
              delayDuration: Duration(milliseconds: 200),
              animationDuration: Duration(milliseconds: 2000),
              animation: DelayedAnimations.SLIDE_FROM_TOP,
              child: Image.asset(
                'assets/images/amazon.png',
                width: width * 0.8,
              ),
            ),
            SizedBox(height: 50),
            LoadingAnimationWidget.threeArchedCircle(color: Colors.orangeAccent, size: 50)
          ],
        ),
      ),
    );
  }
}
