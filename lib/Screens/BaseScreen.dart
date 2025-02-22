import 'package:flutter/material.dart';
import 'package:traffic_law_app/Screens/DrivingRuleScreen.dart';
import 'package:traffic_law_app/Screens/FavouriteScreen.dart';
import 'package:traffic_law_app/Screens/RoadSignsScreen.dart';
import 'package:traffic_law_app/Screens/SearchScreen.dart';

import '../Components/BottomNavBar.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key}); // Made deviceName optional

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static _HomeScreenState? of(BuildContext context) {
    return context.findAncestorStateOfType<_HomeScreenState>();
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of screens to display based on the selected index
  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();

    // Add the MainScreen with the deviceName passed correctly
    _screens.add(DrivingRuleScreen());
    _screens.add(SearchScreen()); // Use widget.deviceName
    _screens.add(FavouriteScreen());
    _screens.add(RoadSignsScreen());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex =
          index; // Update the selected index when tapping a bottom nav item
    });
  }

  void setSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index from DayScreen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[
          _selectedIndex], // Display the screen based on the selected index
      bottomNavigationBar: SizedBox(
        child: BottomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
