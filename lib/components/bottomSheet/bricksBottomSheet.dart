import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maarvel_e/components/bottomNavBar.dart';
import 'package:maarvel_e/components/myButtons.dart';

import '../../screens/navigationMenu/cartScreen.dart';
import '../../utils/globals.dart';

class BricksBottomSheet extends StatefulWidget {
  const BricksBottomSheet({super.key});

  @override
  State<BricksBottomSheet> createState() => _SandBottomSheetState();
}

class _SandBottomSheetState extends State<BricksBottomSheet> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  int productQuantity = 1;

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
    fToast.showToast(child: toast, toastDuration: const Duration(seconds: 2), gravity: ToastGravity.TOP);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.58,
      // height: 460,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/images/bricks.png", width: 120,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bricks", style: GoogleFonts.inika(fontSize: 24, fontWeight: FontWeight.w700),),
                  Text("Please let us know about\nany other quality of bricks\nyou want to buy through\ncontact.", style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400),textAlign: TextAlign.justify,),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Container(
            // width: 275,
            height: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              color: const Color(0xff161416),
            ),
          ),
          const SizedBox(height: 20,),

          Align(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                  style: GoogleFonts.inika(fontSize: 16, fontWeight: FontWeight.w400),
                  children: const <TextSpan>[
                    TextSpan(text: "Vehicle Type : ", style: TextStyle(color: Color(0xff161416), fontWeight: FontWeight.w600, fontSize: 16)),
                    TextSpan(text: "Tractor", style: TextStyle(color: Color(0xff161416), fontSize: 16)),
                  ]
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Align(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                  style: GoogleFonts.inika(fontSize: 16, fontWeight: FontWeight.w400),
                  children: const <TextSpan>[
                    TextSpan(text: "Bricks Quality : ", style: TextStyle(color: Color(0xff161416), fontWeight: FontWeight.w600, fontSize: 16)),
                    TextSpan(text: "Number 1", style: TextStyle(color: Color(0xff161416), fontSize: 16)),
                  ]
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Align(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                  style: GoogleFonts.inika(fontSize: 16, fontWeight: FontWeight.w400),
                  children: const <TextSpan>[
                    TextSpan(text: "Bricks Quantity : ", style: TextStyle(color: Color(0xff161416), fontWeight: FontWeight.w600, fontSize: 16)),
                    TextSpan(text: "1500 Piece", style: TextStyle(color: Color(0xff161416), fontSize: 16)),
                  ]
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Align(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                  style: GoogleFonts.inika(fontSize: 16, fontWeight: FontWeight.w400),
                  children: const <TextSpan>[
                    TextSpan(text: "Price : ", style: TextStyle(color: Color(0xff161416), fontWeight: FontWeight.w600, fontSize: 16)),
                    TextSpan(text: "15000/-", style: TextStyle(color: Color(0xff161416), fontSize: 16)),
                  ]
              ),
            ),
          ),
          const SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if(productQuantity <= 1) {
                      productQuantity = 1;
                    } else {
                      productQuantity--;
                    }
                  });
                  print("~~~~~~~~~~~~~~~Product Quantity is: ${productQuantity}");
                },
                child: const Icon(LineIcons.minusCircle, color: Color(0xff161416),),
              ),
              SizedBox(width: 40, child: Center(child: Text(productQuantity.toString(), style: GoogleFonts.inika(fontSize: 20),))),
              GestureDetector(
                onTap: () {
                  setState(() {
                    productQuantity++;
                  });
                  print("~~~~~~~~~~~~~~~Product Quantity is: ${productQuantity}");
                },
                child: const Icon(LineIcons.plusCircle, color: Color(0xff161416),),
              ),

              const SizedBox(width: 40,),
              GestureDetector(
                onTap: () async {
                  Map<String, dynamic> data = {
                    "productQuantity": productQuantity,
                    "productName": "Bricks Q1",
                    "productPrice": 15000 * productQuantity,
                    "productId": "bricks",
                  };

                  print("~~~~~~~~~~~~~~~~~~~ Before adding this product total amount is: ${totalAmount} ~~~~~~~~~~~~~~~~~");

                  // Adding product to cart for order
                  FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).collection("userCart").doc(data['productName']).set(data);

                  // Calculating and updating total amount for cart page
                  print("~~~~~~~~~~~~~~~~~~~ Price of the Product is: ${data['productPrice']} ~~~~~~~~~~~~~~~~~");
                  totalAmount = totalAmount + data['productPrice'];
                  print("~~~~~~~~~~~~~~~~~~~ After adding this product total amount is: ${totalAmount} ~~~~~~~~~~~~~~~~~");

                  FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).update({
                    "totalAmount": totalAmount,
                  });

                  showCustomToast(context, "${data['productName']} added to cart");
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff161416),
                      borderRadius: BorderRadius.circular(6)
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Text("Add Product", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 12, color: const Color(0xffe3e3e3)),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10,),

          MyButtons(
            onTap: () {
              Navigator.pop(context);
              myCurrentIndex = 1;
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyBottomNavBar()));
            },
            text: "Go to Cart",
          ),
        ],
      ),
    );
  }
}
