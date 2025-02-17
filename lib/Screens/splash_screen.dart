import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'dart:async';

import 'package:traffic_law_app/Screens/MainScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Mainscreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const String backgroundAsset = 'assets/splashscreen.svg';

    return Scaffold(
      body: Stack(
        children: [
          // Background SVG
          SvgPicture.asset(
            backgroundAsset,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
