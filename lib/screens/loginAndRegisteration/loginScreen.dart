import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maarvel_e/auth/google_auth_service_login.dart';
import 'package:maarvel_e/components/myButtons.dart';
import 'package:maarvel_e/components/textField.dart';
import 'package:maarvel_e/screens/loginAndRegisteration/forgotPasswordScreen.dart';

class LoginScreen extends StatelessWidget {
  final void Function()? onTap;
  LoginScreen({super.key, required this.onTap});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Sign In user method
  void signInUser() async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      print("~~~~~~~~~~~~~~~~~This Error has occurred~~~~~~~~~~~~~~~~~ : ${e.code}");
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
                  Text("E-Mail", style: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416)),),
                  MyTextField(hintText: "Enter your e-mail", obscureText: false, controller: emailController, textInputAction: TextInputAction.next, keyboardType: TextInputType.emailAddress,),
                  const SizedBox(height: 10,),

                  // Password Textfield
                  Text("Password", style: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416)),),
                  MyTextField(hintText: "Enter your password", obscureText: true, controller: passwordController, textInputAction: TextInputAction.done, keyboardType: TextInputType.visiblePassword,),
                  const SizedBox(height: 20,),

                  // Forgot Password Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
                      },
                      child: Text('Forgot Password?', style: GoogleFonts.inika(fontSize: 16, fontWeight: FontWeight.w400, color: const Color(0xff161416)),),
                    ),
                  ),

                  const SizedBox(height: 10,),

                  // Register Text Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: onTap,
                      child: RichText(
                        text: TextSpan(
                            style: GoogleFonts.inika(fontSize: 16, fontWeight: FontWeight.w400),
                            children: const <TextSpan>[
                              TextSpan(text: "Don't have an account?", style: TextStyle(color: Color(0xff161416))),
                              TextSpan(text: "Register", style: TextStyle(color: Color(0xffCC2C34))),
                            ]
                        ),
                      ),
                    ),
                  ),


                  const SizedBox(height: 20,),

                  // Login Button
                  MyButtons(
                    text: "Login",
                    onTap: signInUser,
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
                      GoogleAuthServiceLogin().signInwithGoogle();
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
