import 'package:flutter/material.dart';
import 'package:traffic_law_app/Screens/DetailRuleScreen.dart';
import 'package:traffic_law_app/constants.dart';

class RulesHeader extends StatefulWidget {
  final String header;
  final List<Map<String, dynamic>> subHeaders;

  const RulesHeader({
    super.key,
    required this.header,
    required this.subHeaders,
  });

  @override
  _RulesHeaderState createState() => _RulesHeaderState();
}

class _RulesHeaderState extends State<RulesHeader> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 50),
            decoration: BoxDecoration(
              border: Border.all(
                  color: isExpanded ? Colors.red : Colors.white, width: 2),
              color: const Color(0xFF333350),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(widget.header, style: questionHeader),
            ),
          ),
          if (isExpanded) const SizedBox(height: 10),
          if (isExpanded)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.subHeaders.map((subHeader) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailRuleScreen(
                          header: widget.header,
                          subHeaders: [
                            subHeader
                          ], // Pass as a list instead of a string
                          description: subHeader['description'] ??
                              "No description available",
                          ruleSign: subHeader['picture'] ?? "No Picture",
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, bottom: 10),
                    child: Text(
                      subHeader['title'],
                      style: questionSubHeader,
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
