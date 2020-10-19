import 'package:app/views/my_polls.dart';
import 'package:app/views/public_polls.dart';
import 'package:app/views/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _views = <Widget>[
    PublicPolls(),
    MyPolls(),
    Users(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _views[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up),
            label: "Public polls",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "My polls",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Users",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
