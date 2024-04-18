import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignUp {
  signUpwithGoogle () async {
    // Begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // Obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // Create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Finally, Sign In
    return dbGoogleUser(credential);
  }

  // Database creation
  dbGoogleUser(AuthCredential credential) async {
    try{
      final User? user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      var email = user!.providerData[0].email;

      FirebaseFirestore.instance.collection("Users").doc(email).set({
        "email": email,
        "username": email!.split("@").first,
        'totalAmount': 0,
        'orders': 0,
      });

    } on FirebaseAuthException catch(e) {

    }
  }
}