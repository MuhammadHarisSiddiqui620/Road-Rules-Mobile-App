import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:traffic_law_app/Screens/DetailRuleScreen.dart';
import 'package:traffic_law_app/Screens/RulesHeader.dart';

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
    loadJsonData();
    searchController.addListener(_filterResults);
  }

  Future<void> loadJsonData() async {
    String drivingRulesJson =
        await rootBundle.loadString('assets/driving_rules.json');
    String roadRulesJson =
        await rootBundle.loadString('assets/road_rules.json');

    List<dynamic> drivingData = jsonDecode(drivingRulesJson);
    List<dynamic> roadData = jsonDecode(roadRulesJson);

    List<Map<String, dynamic>> tempHeaders = [];

    // Extract headers and subheaders from both JSON files
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
    });
  }

  void _filterResults() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredResults = allHeaders
          .where((item) =>
              item['header'].toLowerCase().contains(query) ||
              item['subheaders']
                  .any((sub) => sub['title'].toLowerCase().contains(query)))
          .toList();
    });
  }

  void _navigateToRulesHeader(Map<String, dynamic> selectedItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailRuleScreen(
          header: selectedItem['header'],
          subHeaders:
              List<Map<String, dynamic>>.from(selectedItem['subheaders']),
          description: selectedItem['description'],
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
    return Scrollbar(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Content",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
              Text(
                "Enter a name to search for articles and road signs",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 55),
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
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              filteredResults.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(filteredResults[index]['header'],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          onTap: () =>
                              _navigateToRulesHeader(filteredResults[index]),
                        );
                      },
                    )
                  : Text("No results found",
                      style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
