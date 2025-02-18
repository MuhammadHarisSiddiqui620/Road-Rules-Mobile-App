import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:traffic_law_app/Screens/BaseScreen.dart';
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
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const String backgroundAsset = 'assets/splashscreen.png';

    return Scaffold(
      body: Center(
        child: Image.asset(
          backgroundAsset, // Try BoxFit.cover, BoxFit.fill, or BoxFit.fitWidth if needed
        ),
      ),
    );
  }
}
