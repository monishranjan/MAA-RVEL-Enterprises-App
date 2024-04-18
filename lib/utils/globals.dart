library globals;

import 'package:maarvel_e/screens/navigationMenu/dashboard.dart';
import 'package:maarvel_e/screens/navigationMenu/cartScreen.dart';
import 'package:maarvel_e/screens/navigationMenu/profileScreen.dart';
import 'package:maarvel_e/screens/navigationMenu/settingsScreen.dart';

// Variable, List, and methods for bottom navigation bar
int myCurrentIndex = 0;

List pages = const [
  Dashboard(),
  CartScreen(),
  SettingsScreen(),
  ProfileScreen(),
];

// Cart Page
var totalAmount;
var orders;
var itemCount;

// Admin Phone Number
var adminPhoneNumber = 6207647132;

// Orders Detail
var orderNumber;
var orderAmount;