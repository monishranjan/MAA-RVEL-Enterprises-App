import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:maarvel_e/auth/auth.dart';
import 'package:maarvel_e/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Flutter Native Splash Screen Setup
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();

  // Firebase Initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Changing status bar color
  const SystemUiOverlayStyle(statusBarColor: Colors.red,);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthenticationPage(),
    );
  }
}