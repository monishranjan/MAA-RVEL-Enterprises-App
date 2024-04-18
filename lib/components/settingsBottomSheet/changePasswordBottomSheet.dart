import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maarvel_e/components/myButtons.dart';

class ChangePasswordBottomSheet extends StatefulWidget {
  const ChangePasswordBottomSheet({super.key});

  @override
  State<ChangePasswordBottomSheet> createState() => _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState extends State<ChangePasswordBottomSheet> {
  TextEditingController emailController = TextEditingController();

  final User? currentUser = FirebaseAuth.instance.currentUser!;

  bool resetLink = false;

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
      stream: FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          final userProfile = snapshot.data!.data() as Map<String, dynamic>;

          Future passwordReset() async {
            try {
              await FirebaseAuth.instance.sendPasswordResetEmail(email: userProfile['email']);

              setState(() {
                resetLink = !resetLink;
              });

              showCustomToast(context, "Password reset link sent.");
            } on FirebaseAuthException catch(e) {
              print("~~~~~~~~~~~~~~~~~~~~~ Auth Exception is : ${e.code}");
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(e.message.toString()),
                  );
                },
              );
            }
          }

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.40,
            child: ListView(
              children: [
                const SizedBox(height: 10,),
                Text("Change Password", style: GoogleFonts.inika(fontWeight: FontWeight.w700, fontSize: 30),),
                const SizedBox(height: 10,),
                Text("We will send you a password resent link to your registered email.", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 14),),
                const SizedBox(height: 20,),
                TextField(
                  textInputAction: TextInputAction.done,
                  enabled: false,
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
                resetLink == true ? GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff161416).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(6)
                    ),
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        "Link Sent",
                        style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 16, color: Color(0xffe3e3e3)),
                      ),
                    ),
                  ),
                ) : MyButtons(
                  onTap: () {
                    passwordReset();
                  },
                  text: "Send Link",
                ),
              ],
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
