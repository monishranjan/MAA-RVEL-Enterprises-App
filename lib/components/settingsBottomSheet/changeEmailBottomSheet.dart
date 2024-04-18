import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../myButtons.dart';

class ChangeEmailBottomSheet extends StatefulWidget {
  const ChangeEmailBottomSheet({super.key});

  @override
  State<ChangeEmailBottomSheet> createState() => _ChangeEmailBottomSheetState();
}

class _ChangeEmailBottomSheetState extends State<ChangeEmailBottomSheet> {
  TextEditingController emailController = TextEditingController();

  final User? currentUser = FirebaseAuth.instance.currentUser!;

  bool changeEmailLink = false;

  // Custom Toast Message
  showCustomToast(BuildContext context, String msg) {
    FToast fToast = FToast();
    fToast.init(context);
    Widget toast = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xff161416)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40, child: Image.asset("assets/logo/mLogo.png")),
          const SizedBox(width: 10,),
          Text(msg, style: GoogleFonts.inika(color: const Color(0xffe3e3e3)),),
        ],
      ),
    );
    fToast.showToast(child: toast, toastDuration: const Duration(seconds: 2), gravity: ToastGravity.CENTER);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Users").doc("monishranjan9@gmail.com").snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          final userProfile = snapshot.data!.data() as Map<String, dynamic>;

          Future changeEmail() async {
            try {
              await FirebaseAuth.instance.currentUser!.verifyBeforeUpdateEmail(emailController.text);

              setState(() {
                changeEmailLink = !changeEmailLink;
              });

              showCustomToast(context, "Email change requested. Link sent to\nnew email.");
            } on FirebaseAuthException catch(e) {
              print("~~~~~~~~~~~~~~~~~~~~~ Auth Exception is : ${e.code}");
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(e.message.toString(), style: GoogleFonts.inika(color: const Color(0xffe3e3e3)),),
                    backgroundColor: const Color(0xff161416),
                  );
                },
              );
            }
          }

          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.40,
              child: ListView(
                children: [
                  const SizedBox(height: 10,),
                  Text("Change Email", style: GoogleFonts.inika(fontWeight: FontWeight.w700, fontSize: 30),),
                  const SizedBox(height: 10,),
                  Text("Enter your new email and we will send you a email change link.", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 14),),
                  const SizedBox(height: 20,),
                  TextField(
                    textInputAction: TextInputAction.done,
                    controller: emailController,
                    cursorColor: const Color(0xff161416),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffd9d9d9),
                      hintText: "${userProfile['email']}",
                      hintStyle: GoogleFonts.inika(fontWeight: FontWeight.w400, color: const Color(0xff161416).withOpacity(.5)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      ),
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff161416)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  changeEmailLink == true ? GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff161416),
                          borderRadius: BorderRadius.circular(6)
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          "Email Change Requested",
                          style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 16, color: const Color(0xffe3e3e3)),
                        ),
                      ),
                    ),
                  ) : MyButtons(
                    onTap: () {
                      changeEmail();
                    },
                    text: "Change Email",
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error + ${snapshot.error}"),
          );
        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}
