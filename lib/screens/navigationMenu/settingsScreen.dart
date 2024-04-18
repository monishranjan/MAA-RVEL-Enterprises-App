import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maarvel_e/components/settingsBottomSheet/changeEmailBottomSheet.dart';
import 'package:maarvel_e/components/settingsBottomSheet/changePasswordBottomSheet.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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

  // Logout User
  void logout() {
    try{
      FirebaseAuth.instance.signOut().then((value){
        GoogleSignIn().disconnect();
      });

      showCustomToast(context, "Logged out successfully.");
    } on FirebaseException catch(e) {
      showCustomToast(context, "Error occurred.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xffe3e3e3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Settings", style: GoogleFonts.inika(fontWeight: FontWeight.w700),),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Change Password
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xffd9d9d9),
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.black26)
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Change Password", style: GoogleFonts.inika(fontWeight: FontWeight.w500, fontSize: 16),),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet<dynamic>(
                      showDragHandle: true,
                      backgroundColor: const Color(0xffe3e3e3),
                      barrierColor: const Color(0xff161416).withOpacity(.75),
                      isScrollControlled: true,
                      context: context,
                      builder: (ctx) => const ChangePasswordBottomSheet(),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Color(0xff161416)),
                ),
              ],
            ),
          ),

          // Change Email
          // Container(
          //   padding: const EdgeInsets.all(16),
          //   decoration: const BoxDecoration(
          //       color: Color(0xffd9d9d9),
          //       border: Border(
          //           bottom: BorderSide(width: 1, color: Colors.black26)
          //       )
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text("Change E-Mail", style: GoogleFonts.inika(fontWeight: FontWeight.w500, fontSize: 16),),
          //       IconButton(
          //         onPressed: () {
          //           showModalBottomSheet<dynamic>(
          //             showDragHandle: true,
          //             backgroundColor: const Color(0xffe3e3e3),
          //             barrierColor: const Color(0xff161416).withOpacity(.75),
          //             isScrollControlled: true,
          //             context: context,
          //             builder: (ctx) => const ChangeEmailBottomSheet(),
          //           );
          //         },
          //         icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Color(0xff161416),),
          //       ),
          //     ],
          //   ),
          // ),

          // Logout
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Color(0xffd9d9d9),
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black26)
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Logout", style: GoogleFonts.inika(fontWeight: FontWeight.w500, fontSize: 16),),
                IconButton(
                  onPressed: () {
                    logout();
                  },
                  icon: const Icon(Icons.exit_to_app_rounded, size: 24, color: Color(0xff161416),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
