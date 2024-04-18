import 'package:flutter/material.dart';
import 'package:maarvel_e/screens/loginAndRegisteration/loginScreen.dart';
import 'package:maarvel_e/screens/loginAndRegisteration/registerationScreen.dart';

class LoginOrRegisteration extends StatefulWidget {
  const LoginOrRegisteration({super.key});

  @override
  State<LoginOrRegisteration> createState() => _LoginOrRegisterationState();
}

class _LoginOrRegisterationState extends State<LoginOrRegisteration> {
  // Initially show login page
  bool showLoginPage = true;

  // Toggle between login and registration page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage) {
      return LoginScreen(onTap: togglePages);
    } else {
      return RegisterationScreen(onTap: togglePages);
    }
  }
}
