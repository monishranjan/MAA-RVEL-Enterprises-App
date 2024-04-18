import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maarvel_e/auth/google_auth_service_registeration.dart';

import '../../components/myButtons.dart';
import '../../components/textField.dart';

class RegisterationScreen extends StatefulWidget {
  final void Function()? onTap;
  RegisterationScreen({super.key, required this.onTap});

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  // Text Controllers for registerations
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController addressNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  // Register method
  void registerUser() async {
    // Making sure that passwords are matching
    if (passwordController.text == confirmPasswordController.text) {
      // Creating users
      try {
        // Create the user
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text,
        );

        // Create a database for user
        createUserDocument(userCredential);

        // Create a collection for storing the user addresses
        createUserAddresses(userCredential);

        // Message to show user is registered
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xff3d9d22),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/images/done.svg",
                  height: 40,
                  width: 40,
                  color: const Color(0xffe3e3e3),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hi there!", style: GoogleFonts.inika(fontWeight: FontWeight.w700, fontSize: 18, color: const Color(0xffe3e3e3)),),
                      Text("Your account is successfully registered.", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 14, color: const Color(0xff141614)),),
                    ],
                  ),
                ),
              ],
            ),
          ),
            duration: const Duration(seconds: 2),
            margin: const EdgeInsets.only(bottom: 300),
            behavior: SnackBarBehavior.floating,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        );
      } on FirebaseAuthException catch (e) {
        // Display error message to user
        print("~~~~~~~~~~~~~~~~~Error id is : ${e.code}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Container(
            padding: const EdgeInsets.all(20),
            // height: 90,
            decoration: const BoxDecoration(
              color: Color(0xff9d2228),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/cross.svg",
                  height: 40,
                  width: 40,
                  color: const Color(0xffe3e3e3),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Oh Snap!", style: GoogleFonts.inika(fontWeight: FontWeight.w700, fontSize: 18, color: const Color(0xffe3e3e3)),),
                      Text("Error registering the user. Try Again !!!", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 14, color: const Color(0xff141614)),),
                    ],
                  ),
                ),
              ],
            ),
          ),
            margin: const EdgeInsets.only(bottom: 300),
            behavior: SnackBarBehavior.floating,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        );
      }
    } else {
      // Show the error message to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color(0xff9d2228),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/images/cross.svg",
                height: 40,
                width: 40,
                color: const Color(0xffe3e3e3),
              ),
              const SizedBox(width: 20,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Oh Snap!", style: GoogleFonts.inika(fontWeight: FontWeight.w700, fontSize: 18, color: const Color(0xffe3e3e3)),),
                    Text("Error has occurred when registering. Try Again !!!", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 14, color: const Color(0xff141614)),),
                  ],
                ),
              ),
            ],
          ),
        ),
          margin: const EdgeInsets.only(bottom: 300),
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      );
    }
  }

  // Creating user database method
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if(userCredential != null && userCredential.user != null) {
      Map<String, dynamic> data = {
        'fullName': fullNameController.text,
        'phoneNumber': phoneController.text,
        'email': emailController.text,
        'totalAmount': 0,
        'orders': 0,
      };

      await FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.email).set(data);
      print("~~~~~~~~~~~~~~~~~UID is : ${userCredential.user!.uid}~~~~~~~~~~~~~~~~~~~~~~");
    } else {
      print("========================\n\nError creating database\n\n==============================");
    }
  }

  // Creating user addresses database method
  Future<void> createUserAddresses(UserCredential? userCredential) async {
    if(userCredential != null && userCredential.user != null) {
      Map<String, dynamic> addressData = {
        'addressName': addressNameController.text,
        'address': addressController.text,
        'pincode': pincodeController.text,
        'city': cityController.text,
        'state': stateController.text,
      };

      await FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.email).collection("addresses").doc(addressNameController.text).set(addressData);
      print("~~~~~~~~~~~~~~~~~The addresses collection is created~~~~~~~~~~~~~~~~~~~~~~");
    } else {
      print("========================\n\nError creating database\n\n==============================");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffe3e3e3),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100,),
            SizedBox(
              height: 200,
              child: Image.asset("assets/images/registerationIllustration.png"),
            ),
            const SizedBox(height: 50,),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        style: GoogleFonts.inika(fontSize: 36, fontWeight: FontWeight.w400, color: const Color(0xff161416)),
                        children: const <TextSpan> [
                          TextSpan(text: "Welcome "),
                          TextSpan(text: "Back", style: TextStyle(color: Color(0xffCC2C34))),
                        ]
                    ),
                  ),
                  const SizedBox(height: 20,),

                  // Email Textfield
                  Text("Full Name", style: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416)),),
                  MyTextField(hintText: "Enter your full name", obscureText: false, controller: fullNameController, textInputAction: TextInputAction.next, keyboardType: TextInputType.text,),
                  const SizedBox(height: 10,),

                  // Email Textfield
                  Text("E-Mail", style: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416)),),
                  MyTextField(hintText: "Enter your e-mail", obscureText: false, controller: emailController, textInputAction: TextInputAction.next, keyboardType: TextInputType.emailAddress,),
                  const SizedBox(height: 10,),

                  // Phone Number Textfield
                  Text("Phone Number", style: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416)),),
                  MyTextField(hintText: "Enter your phone number", obscureText: false, controller: phoneController, textInputAction: TextInputAction.next, keyboardType: TextInputType.phone,),
                  const SizedBox(height: 10,),

                  // Password Textfield
                  Text("Password", style: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416)),),
                  MyTextField(hintText: "Enter your password", obscureText: false, controller: passwordController, textInputAction: TextInputAction.next, keyboardType: TextInputType.visiblePassword,),
                  const SizedBox(height: 10,),

                  // Confirm Password Textfield
                  Text("Confirm Password", style: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416)),),
                  MyTextField(hintText: "Confirm your password", obscureText: true, controller: confirmPasswordController, textInputAction: TextInputAction.next, keyboardType: TextInputType.visiblePassword,),
                  const SizedBox(height: 20,),

                  // Address Name Textfield
                  Text("Address Name", style: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416)),),
                  MyTextField(hintText: "Address Name", obscureText: false, controller: addressNameController, textInputAction: TextInputAction.next, keyboardType: TextInputType.text,),
                  const SizedBox(height: 20,),

                  // Address Textfield
                  Text("Address", style: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416)),),
                  MyTextField(hintText: "Address", obscureText: false, controller: addressController, textInputAction: TextInputAction.next, keyboardType: TextInputType.text,),
                  const SizedBox(height: 20,),

                  // Pincode Textfield
                  Text("Pincode", style: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416)),),
                  MyTextField(hintText: "Pincode", obscureText: false, controller: pincodeController, textInputAction: TextInputAction.next, keyboardType: TextInputType.number,),
                  const SizedBox(height: 20,),

                  // City Textfield
                  Text("City", style: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416)),),
                  MyTextField(hintText: "City", obscureText: false, controller: cityController, textInputAction: TextInputAction.next, keyboardType: TextInputType.text,),
                  const SizedBox(height: 20,),

                  // State Textfield
                  Text("State", style: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416)),),
                  MyTextField(hintText: "State", obscureText: false, controller: stateController, textInputAction: TextInputAction.done, keyboardType: TextInputType.text,),
                  const SizedBox(height: 20,),

                  // Login Text Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: widget.onTap,
                      child: RichText(
                        text: TextSpan(
                            style: GoogleFonts.inika(fontSize: 16, fontWeight: FontWeight.w400),
                            children: const <TextSpan>[
                              TextSpan(text: "Already have an account?", style: TextStyle(color: Color(0xff161416))),
                              TextSpan(text: "Login Here", style: TextStyle(color: Color(0xffCC2C34))),
                            ]
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),

                  // Register Button
                  MyButtons(
                    text: "Register",
                    onTap: registerUser,
                  ),

                  const SizedBox(height: 20,),

                  // Divider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Flexible(child: Divider(color: Color(0xff161416), thickness: 0.5, indent: 60, endIndent: 5,)),
                      Text("  OR  ", style: GoogleFonts.inika(fontSize: 16, fontWeight: FontWeight.w400),),
                      const Flexible(child: Divider(color: Color(0xff161416), thickness: 0.5, indent: 5, endIndent: 60,)),
                    ],
                  ),

                  const SizedBox(height: 20,),

                  // Google Sign in Button
                  GestureDetector(
                    onTap: () {
                      GoogleSignUp().signUpwithGoogle();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/images/googleIcon.png", height: 50,),
                        const SizedBox(width: 20,),
                        Container(
                          height: 60,
                          width: 280,
                          decoration: BoxDecoration(
                              color: const Color(0xff161416),
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: Center(child: Text("Continue with Google", style: GoogleFonts.inika(fontSize: 16, color: const Color(0xffe3e3e3)),)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
