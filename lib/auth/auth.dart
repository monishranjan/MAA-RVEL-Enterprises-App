import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maarvel_e/auth/login_or_registeration.dart';
import 'package:maarvel_e/components/bottomNavBar.dart';
import 'package:maarvel_e/screens/navigationMenu/dashboard.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in
          if(snapshot.hasData) {
            return MyBottomNavBar();
          } else {   // User is NOT logged in
            return const LoginOrRegisteration();
          }
        },
      ),
    );
  }
}
