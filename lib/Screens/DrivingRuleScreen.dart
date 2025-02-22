import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:traffic_law_app/Screens/RulesHeader.dart';
import '../constants.dart';

class DrivingRuleScreen extends StatefulWidget {
  const DrivingRuleScreen({super.key});

  @override
  _DrivingRuleScreenState createState() => _DrivingRuleScreenState();
}

class _DrivingRuleScreenState extends State<DrivingRuleScreen> {
  late Future<List<Map<String, dynamic>>> futureHeaders;

  @override
  void initState() {
    super.initState();
    futureHeaders = loadRoadRules();
  }

  Future<List<Map<String, dynamic>>> loadRoadRules() async {
    String jsonString =
        await rootBundle.loadString('assets/driving_rules.json');
    List<dynamic> jsonList = json.decode(jsonString);

    return jsonList.take(4).map((item) {
      return {
        'header': item['header'],
        'subheaders': List<Map<String, dynamic>>.from(item['sub_headers']),
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Content", style: primaryTextStyle),
                SizedBox(height: 21),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: futureHeaders,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    List<Map<String, dynamic>> headersData = snapshot.data!;

                    return Column(
                      children: headersData
                          .map((data) => Column(
                                children: [
                                  RulesHeader(
                                    header: data['header'],
                                    subHeaders: List<Map<String, dynamic>>.from(
                                        data['subheaders']),
                                  ),
                                  SizedBox(height: 7),
                                ],
                              ))
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
