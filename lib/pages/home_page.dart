import 'package:flutter/material.dart';
import 'package:tasky/pages/dashboard_page.dart';
import 'package:tasky/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const List<Widget> _pageOptions = [DashboardPage(), ProfilePage()];

  static const String routeName = "/";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPageIndex = 0;

  void _onMenuIconTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage._pageOptions[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onMenuIconTapped,
        currentIndex: _selectedPageIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded), label: "Profile")
        ],
      ),
    );
  }
}
