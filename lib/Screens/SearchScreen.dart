import 'package:flutter/material.dart';
import 'package:traffic_law_app/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose(); // Properly disposing the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Content", style: primaryTextStyle),
                SizedBox(height: 15),
                Text(
                  "Enter a name to search for articles and road signs",
                  style: searchScreen,
                ),
                SizedBox(height: 55),
                TextField(
                  controller: searchController,
                  style: TextStyle(
                      fontSize: 16,
                      height: 3.5,
                      color: Color(0xFFB32D35),
                      fontWeight: FontWeight.w500),
                  textDirection:
                      TextDirection.rtl, // Sets text input direction to RTL
                  decoration: InputDecoration(
                    fillColor: Color(0XFF333350),
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search',
                    hintTextDirection:
                        TextDirection.rtl, // Sets hint text direction to RTL
                    hintStyle: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontFamily: 'PlusJakartaSans',
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Icon(
                      Icons.search, // Search icon
                      color: Colors.white, // Adjust color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
