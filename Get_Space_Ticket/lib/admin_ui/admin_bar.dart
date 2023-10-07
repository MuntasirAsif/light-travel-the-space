// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get_space_ticket/Users_ui/search_screen.dart';
import 'package:get_space_ticket/admin_ui/admin_home_screen.dart';

import 'admin_profile_screen.dart';


class CompanyBar extends StatefulWidget {
  const CompanyBar({Key? key}) : super(key: key);

  @override
  State<CompanyBar> createState() => _CompanyBarState();
}

class _CompanyBarState extends State<CompanyBar> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptins = <Widget>[
    const CompanyHome(),
    const SearchScreen(),
    const AdminProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black54,
      body: Center(
        child: _widgetOptins[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
