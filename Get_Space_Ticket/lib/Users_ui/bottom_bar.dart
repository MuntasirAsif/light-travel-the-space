
import 'package:flutter/material.dart';
import 'package:get_space_ticket/Users_ui/profile_screen.dart';
import 'package:get_space_ticket/Users_ui/search_screen.dart';
import 'booking_screen.dart';
import 'home_screen.dart';

class bottomBar extends StatefulWidget {
  const bottomBar({Key? key}) : super(key: key);

  @override
  State<bottomBar> createState() => _bottomBarState();
}

class _bottomBarState extends State<bottomBar> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptins = <Widget>[
    const HomeScreen(),
    const SearchScreen(),
    const BookingScreen(),
    const ProfileScreen(),
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
          BottomNavigationBarItem(icon: Icon(Icons.rocket), label: 'Tickets'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
