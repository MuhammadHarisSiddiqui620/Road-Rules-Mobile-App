import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:traffic_law_app/Screens/BaseScreen.dart';

import '../constants.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Proper background color
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              Stack(
                children: [
                  SvgPicture.asset(
                    'assets/main_screen_logo.svg',
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 150,
                    left: 20,
                    child: Column(
                      children: [
                        Text("Welcome to our\n Traffic rules app",
                            style: mainScreenText),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Improve your skills with us!",
                            style: birthdaySecondaryText),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 14,
                  ),
                  ElevatedButton(
                    style: primaryButton,
                    onPressed: () async {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BaseScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Go',
                      style: TextStyle(
                          color: Color(0xFFF3F3F3),
                          fontSize: 16,
                          fontWeight:
                              FontWeight.w300), // ensure text color is white
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/main_screen_logo_2.svg',
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
