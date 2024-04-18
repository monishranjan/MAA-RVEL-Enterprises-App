import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  const MyTextField({super.key, required this.hintText, required this.obscureText, required this.controller, required this.textInputAction, required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      controller: controller,
      cursorColor: Color(0xff161416),
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffd9d9d9),
        hintText: hintText,
        hintStyle: GoogleFonts.inika(fontWeight: FontWeight.w400, color: Color(0xff161416).withOpacity(.5)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6)
        ),
        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff161416)),
        ),
      ),
    );
  }
}
