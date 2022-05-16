import 'package:test1/Ui/analysis.dart';
import 'package:test1/Ui/cartown.dart';

import '/Ui/cart.dart';
import '/Ui/home.dart';
import '/Ui/profile.dart';
import '/Ui/search.dart';
import 'package:flutter/material.dart';

class HomePageown extends StatefulWidget {
  @override
  _HomePageownState createState() => _HomePageownState();
}

class _HomePageownState extends State<HomePageown> {
  int _currentIndex = 0;
  final tabs = [
    Home(
      isown: true,
    ),
    Profile(isown: true),
    Analysis(),
    Cartown(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFFEF7532),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Analysis"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), label: "Payments"),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
