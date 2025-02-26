import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:traffic_law_app/Screens/DetailRuleScreen.dart';
import 'package:traffic_law_app/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> allHeaders = [];
  List<Map<String, dynamic>> filteredResults = [];

  @override
  void initState() {
    super.initState();
    loadJsonData().then((_) {
      setState(() {}); // Ensure UI updates after data loads
    });
    searchController.addListener(() {
      _filterResults();
    });
  }

  /// Loads JSON data from assets
  Future<void> loadJsonData() async {
    String drivingRulesJson =
        await rootBundle.loadString('assets/driving_rules.json');
    String roadRulesJson =
        await rootBundle.loadString('assets/road_rules.json');

    List<dynamic> drivingData = jsonDecode(drivingRulesJson);
    List<dynamic> roadData = jsonDecode(roadRulesJson);

    List<Map<String, dynamic>> tempHeaders = [];

    for (var item in drivingData) {
      tempHeaders.add({
        'header': item['header'],
        'subheaders': List<Map<String, dynamic>>.from(item['sub_headers']),
      });
    }

    for (var item in roadData) {
      tempHeaders.add({
        'header': item['header'],
        'subheaders': List<Map<String, dynamic>>.from(item['sub_headers']),
      });
    }

    setState(() {
      allHeaders = tempHeaders;
      filteredResults = List.from(allHeaders);
    });
  }

  /// Cleans text by removing leading numbers, dots, and spaces
  String _cleanText(String text) {
    return text.replaceAll(RegExp(r'^\d+(\.\d+)*\s*'), '').trim();
  }

  /// Filters search results based on query (matches first letter of titles)
  void _filterResults() {
    String query = searchController.text.toLowerCase();

    if (query.isEmpty) {
      setState(() {
        filteredResults = List.from(allHeaders);
      });
      return;
    }

    setState(() {
      filteredResults = allHeaders
          .where((item) =>
              _cleanText(item['header']).toLowerCase().startsWith(query) ||
              item['subheaders'].any((sub) => _cleanText(sub['title'])
                  .toLowerCase()
                  .startsWith(query))) // Matches first letter
          .map((item) => {
                'header': item['header'],
                'subheaders': item['subheaders']
                    .where((sub) => _cleanText(sub['title'])
                        .toLowerCase()
                        .startsWith(query))
                    .toList()
              })
          .toList();
    });
  }

  /// Navigates to details screen when a title is tapped
  void _navigateToRulesHeader(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailRuleScreen(
          header: title,
          subHeaders: [],
          description: '',
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Content", style: primaryTextStyle),
            SizedBox(height: 15),
            Text(
              "Enter a name to search for articles and road signs",
              style: searchScreen,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            TextField(
              controller: searchController,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Color(0xFFB32D35),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                fillColor: Color(0XFF333350),
                filled: true,
                contentPadding: EdgeInsets.all(20),
                hintText: 'Search',
                hintTextDirection: TextDirection.rtl,
                hintStyle: hintText,
                prefixIcon: Icon(Icons.search, color: Colors.white, size: 40),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: filteredResults.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredResults.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...filteredResults[index]['subheaders']
                                .map<Widget>((sub) {
                              String cleanTitle = _cleanText(sub['title']);
                              return Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: ListTile(
                                  title: Text(cleanTitle,
                                      style: questionSubHeader),
                                  onTap: () =>
                                      _navigateToRulesHeader(cleanTitle),
                                ),
                              );
                            }).toList(),
                          ],
                        );
                      },
                    )
                  : Center(
                      child: Text("No results found",
                          style: TextStyle(color: Colors.grey)),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
