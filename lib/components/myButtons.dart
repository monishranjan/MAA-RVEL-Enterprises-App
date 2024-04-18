import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButtons extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const MyButtons({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff161416),
          borderRadius: BorderRadius.circular(6)
        ),
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 16, color: Color(0xffe3e3e3)),
          ),
        ),
      ),
    );
  }
}
