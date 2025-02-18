import 'package:flutter/material.dart';

import '../constants.dart';

class DrivingRuleScreen extends StatelessWidget {
  const DrivingRuleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFAF9F7),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Content", style: primaryTextStyle),
            SizedBox(
              height: 21,
            ),
            QuestionHeader(header: "Introduction to traffic regulations"),
            SizedBox(
              height: 7,
            ),
            QuestionHeader(header: "Automatic or mechanical"),
            SizedBox(
              height: 7,
            ),
            QuestionHeader(
                header:
                    "Getting behind the wheel, adjusting mirrors, taxiing and shifting gears"),
            SizedBox(
              height: 7,
            ),
            QuestionHeader(header: "Car start"),
          ],
        ),
      ),
    );
  }
}

class QuestionHeader extends StatelessWidget {
  final String header;

  const QuestionHeader({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 50, minWidth: double.infinity),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        color: Color(0xFF333350),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          header,
          style: questionHeader,
        ),
      ),
    );
  }
}
