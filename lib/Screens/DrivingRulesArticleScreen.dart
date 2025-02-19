import 'package:flutter/material.dart';
import '../constants.dart';

class DrivingRulesArticleScreen extends StatelessWidget {
  final String header;
  final List<Map<String, dynamic>>
      subHeaders; // Change from String to List<Map<String, dynamic>>
  final String description;

  const DrivingRulesArticleScreen({
    super.key,
    required this.header,
    required this.subHeaders, // Now accepts a list instead of a string
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Container(
            color: Color(0xFFFAF9F7),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Content", style: primaryTextStyle),
                  SizedBox(height: 21),
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 50),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2),
                      color: const Color(0xFF333350),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(header, style: questionHeader),
                    ),
                  ),
                  SizedBox(height: 1),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: subHeaders.map((subHeader) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(subHeader['title'], style: questionSubHeader),
                            SizedBox(height: 1),
                            Text(subHeader['description'],
                                style: descriptionText),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
