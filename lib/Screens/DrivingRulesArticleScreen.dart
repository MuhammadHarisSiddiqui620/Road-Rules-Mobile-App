import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For encoding/decoding JSON
import '../constants.dart';

class DrivingRulesArticleScreen extends StatefulWidget {
  final String header;
  final List<Map<String, dynamic>> subHeaders;
  final String description;

  const DrivingRulesArticleScreen({
    super.key,
    required this.header,
    required this.subHeaders,
    required this.description,
  });

  @override
  _DrivingRulesArticleScreenState createState() =>
      _DrivingRulesArticleScreenState();
}

class _DrivingRulesArticleScreenState extends State<DrivingRulesArticleScreen> {
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
    _loadFavouriteStatus();
  }

  // Load favorite status from SharedPreferences
  Future<void> _loadFavouriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favData = prefs.getString("favourites");

    if (favData != null) {
      List<Map<String, dynamic>> favList =
          List<Map<String, dynamic>>.from(jsonDecode(favData));

      setState(() {
        isFavourite = favList.any((item) =>
            item['header'] == widget.header &&
            item['subheaders'] is List &&
            (item['subheaders'] as List).any((sub) =>
                widget.subHeaders.any((s) => s['title'] == sub['title'])));
      });
    }
  }

  // Toggle favorite status
  Future<void> _toggleFavourite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favData = prefs.getString("favourites");

    List<Map<String, dynamic>> favList = favData != null
        ? List<Map<String, dynamic>>.from(jsonDecode(favData))
        : [];

    bool exists = favList.any((item) => item['header'] == widget.header);

    if (isFavourite) {
      // Remove favorite
      favList.removeWhere((item) => item['header'] == widget.header);
    } else {
      // Add favorite with all subheaders
      favList.add({
        'header': widget.header,
        'subheaders': widget.subHeaders, // Store all subheaders properly
        'description': widget.description,
      });
    }

    await prefs.setString("favourites", jsonEncode(favList));

    setState(() {
      isFavourite = !isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Content", style: primaryTextStyle),
                      GestureDetector(
                        onTap: () {
                          _toggleFavourite(); // Add parentheses to call the function
                          print("Favourite changed");
                        },
                        child: Icon(
                          isFavourite ? Icons.favorite : Icons.favorite_outline,
                          size: 40,
                          color: isFavourite ? Colors.red : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 21),
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 50),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2),
                      color: const Color(0xFF333350),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(widget.header, style: questionHeader),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.subHeaders.map((subHeader) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(subHeader['title'], style: questionSubHeader),
                            const SizedBox(height: 5),
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
