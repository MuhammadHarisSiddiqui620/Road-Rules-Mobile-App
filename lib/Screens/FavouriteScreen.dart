import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'RulesHeader.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late Future<List<Map<String, dynamic>>> futureHeaders;

  @override
  void initState() {
    super.initState();
    futureHeaders = loadHeadersFromSharedPreferences();
  }

  Future<List<Map<String, dynamic>>> loadHeadersFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favData = prefs.getString("favourites");

    if (favData == null || favData.isEmpty) {
      return []; // Return an empty list if no data is found
    }

    List<dynamic> jsonList = jsonDecode(favData);
    return jsonList.map((item) {
      return {
        'header': item['header'],
        'subheaders': List<Map<String, dynamic>>.from(item['subheaders'] ?? []),
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
                Text("Saved Content", style: primaryTextStyle),
                const SizedBox(height: 21),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: futureHeaders,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data!.isEmpty) {
                      return const Center(child: Text("No favourites saved."));
                    }

                    return Column(
                      children: snapshot.data!
                          .map((data) => Column(
                                children: [
                                  RulesHeader(
                                    header: data['header'],
                                    subHeaders: data['subheaders'],
                                  ),
                                  const SizedBox(height: 7),
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
