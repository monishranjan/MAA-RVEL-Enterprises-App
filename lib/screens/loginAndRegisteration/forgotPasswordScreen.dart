import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maarvel_e/components/myButtons.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  bool resentVisible = false;
  bool sendEmail = true;

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
  }

  void passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
    } on FirebaseAuthException catch (e) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffe3e3e3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  child: Image.asset("assets/images/forgot_pass.png"),
                ),
                const SizedBox(height: 20,),
                Text("Forgot Password", style: GoogleFonts.inika(fontSize: 30, color: const Color(0xff161416), fontWeight: FontWeight.w700),),
                const SizedBox(height: 10,),
                Text("Enter your email and we will send you a password reset link on your mail.", style: GoogleFonts.inika(fontSize: 16, color: const Color(0xff161416), fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
                const SizedBox(height: 20,),
                TextField(
                  textInputAction: TextInputAction.done,
                  // enabled: false,
                  controller: _emailController,
                  cursorColor: const Color(0xff161416),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffd9d9d9),
                    hintText: "Enter your email",
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
                if(sendEmail)
                  MyButtons(
                  onTap: () {
                    sendEmail = !sendEmail;
                    Timer(const Duration(seconds: 15), () {
                      setState(() {
                        resentVisible = !resentVisible;
                      });
                    });
                    passwordReset();
                    showCustomToast(context, "Password reset link sent. Check\n your mail");
                  },
                  text: "Send Email",
                ),

                if(!sendEmail)
                  Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: const Color(0xff161416)
                    )
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      "Send Email",
                      style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 16, color: const Color(0xff161416)),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                if(resentVisible)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        sendEmail = !sendEmail;
                      });
                      passwordReset();
                    },
                    child: RichText(
                      text: TextSpan(
                          style: GoogleFonts.inika(fontSize: 16, fontWeight: FontWeight.w400, color: const Color(0xff161416)),
                          children: const <TextSpan> [
                            TextSpan(text: "Didn't recieve email? "),
                            TextSpan(text: "Resent", style: TextStyle(color: Color(0xffCC2C34))),
                          ]
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget resentEmail() {
    return RichText(
      text: TextSpan(
          style: GoogleFonts.inika(fontSize: 16, fontWeight: FontWeight.w400, color: const Color(0xff161416)),
          children: const <TextSpan> [
            TextSpan(text: "Didn't recieve email? "),
            TextSpan(text: "Resent", style: TextStyle(color: Color(0xffCC2C34))),
          ]
      ),
    );
  }
}

class TimerController extends GetxController {
  Timer? _timer;
  int remainingSeconds = 1;
  final time = '00.00'.obs;

  @override
  void onReady() {
    _countdownTimer(900);
    super.onReady();
  }

  @override
  void onClose() {
    if(_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  _countdownTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if(remainingSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainingSeconds~/60;
        int seconds = (remainingSeconds%60);
        time.value = minutes.toString().padLeft(2, "0") + ":" + seconds.toString().padLeft(2, "0");
        remainingSeconds--;
      }
    });
  }
}
