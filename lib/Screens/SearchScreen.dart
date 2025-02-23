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
      print("Text changed: ${searchController.text}"); // Debugging
      _filterResults();
    });
  }

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

    print("Loaded headers: ${allHeaders.length}"); // Debugging
  }

  void _filterResults() {
    String query = searchController.text.toLowerCase();
    print("Search query: $query"); // Debugging

    if (query.isEmpty) {
      setState(() {
        filteredResults = List.from(allHeaders);
      });
      return;
    }

    setState(() {
      filteredResults = allHeaders
          .where((item) =>
              item['header'].toLowerCase().contains(query) ||
              item['subheaders']
                  .any((sub) => sub['title'].toLowerCase().contains(query)))
          .toList();
    });

    print("Filtered results: ${filteredResults.length}"); // Debugging
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
                        return ListTile(
                          title: Text(filteredResults[index]['header'],
                              style: questionSubHeader),
                          onTap: () =>
                              _navigateToRulesHeader(filteredResults[index]),
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
