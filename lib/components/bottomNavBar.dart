import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maarvel_e/screens/navigationMenu/dashboard.dart';
import 'package:maarvel_e/screens/navigationMenu/cartScreen.dart';
import 'package:maarvel_e/screens/navigationMenu/profileScreen.dart';
import 'package:maarvel_e/screens/navigationMenu/settingsScreen.dart';

import '../utils/globals.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {

  static const List<Widget> myPages = <Widget>[
    Dashboard(),
    CartScreen(),
    SettingsScreen(),
    ProfileScreen(),
  ];

  void _tabChanged(int index) {
    myCurrentIndex = 0;
    setState(() {
      myCurrentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xffe3e3e3),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            color: const Color(0xff161416),
            borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: GNav(
            gap: 5,
            color: Colors.grey[600],
            activeColor: const Color(0xff161416),
            rippleColor: const Color(0xffCC2C34),
            hoverColor: const Color(0xffCC2C34),
            iconSize: 20,
            textStyle: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416), fontWeight: FontWeight.w500),
            tabBackgroundColor: const Color(0xffe3e3e3),
            tabBorderRadius: 20,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.5),
            duration: const Duration(milliseconds: 800),
            tabs: const [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
              ),
              GButton(
                icon: LineIcons.shoppingCart,
                text: 'Cart',
              ),
              GButton(
                icon: LineIcons.cog,
                text: 'Setting',
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profile',
              ),
            ],
            selectedIndex: myCurrentIndex,
            onTabChange: _tabChanged,
          ),
        ),
      ),
      body: myPages.elementAt(myCurrentIndex),
    );
  }
}
