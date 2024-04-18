import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maarvel_e/components/bottomNavBar.dart';
import 'package:maarvel_e/components/myButtons.dart';
import 'package:maarvel_e/screens/navigationMenu/cartScreen.dart';
import 'package:maarvel_e/screens/navigationMenu/dashboard.dart';

class PlacedOrder extends StatefulWidget {
  const PlacedOrder({super.key});

  @override
  State<PlacedOrder> createState() => _PlacedOrderState();
}

class _PlacedOrderState extends State<PlacedOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xffe3e3e3),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset("assets/images/orderPlaced.png", width: 200,),
            ),
            const SizedBox(height: 20,),
            Text("Thank You!!", style: GoogleFonts.inika(fontWeight: FontWeight.w600, color: const Color(0xff161416), fontSize: 28),),
            const SizedBox(height: 10,),
            Text("Your order has been placed with us. You will recieve a order confirmation call from our side soon.", style: GoogleFonts.inika(fontWeight: FontWeight.w400, color: const Color(0xff161416), fontSize: 16), textAlign: TextAlign.center,),
            const SizedBox(height: 20,),
            MyButtons(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyBottomNavBar()));
              },
              text: "Back to Cart",
            ),
            const SizedBox(height: 10,),
            Text("Note* : Payment will be completed when order reaches the destination.", style: GoogleFonts.inika(), textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
