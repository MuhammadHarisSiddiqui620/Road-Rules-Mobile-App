import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false, // <-- HERE
      showUnselectedLabels: false, // <-- AND HERE
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled, size: 30),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, size: 30),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite, size: 30),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.report, size: 30),
          label: '',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.grey,
      unselectedItemColor: Colors.black, // Color for inactive items
      onTap: onTap,
    );
  }
}
