import 'package:worker_location_system/views/location_page.dart';
import 'package:flutter/material.dart';

import '../views/profile_page.dart';

class MyBottomNav extends StatefulWidget {
  const MyBottomNav({super.key});

  @override
  State<MyBottomNav> createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(
              color: Colors.white,
              Icons.home,
              size: 30,
            ),
            icon: Icon(
              Icons.home_outlined,
              size: 30,
              color: Colors.white60,
            ),
            label: 'Ana Ekran',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                size: 30,
                color: Colors.white60,
              ),
              activeIcon: Icon(
                color: Colors.white,
                Icons.person,
                size: 30,
              ),
              label: 'Profil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
