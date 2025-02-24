import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnBoardingScreen(), // Navigate to OnBoardingScreen
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SvgPicture.asset(
          'assets/images/logo.svg', // Update the asset path to your SVG file
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
