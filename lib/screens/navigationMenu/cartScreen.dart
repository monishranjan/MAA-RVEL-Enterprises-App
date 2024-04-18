import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maarvel_e/components/myButtons.dart';
import 'package:maarvel_e/screens/checkoutScreen.dart';

import '../../utils/globals.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

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

  void getTotalAmount() {
    if(totalAmount == null){
      setState(() {
        totalAmount = 0;
      });
    } else {

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotalAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xffe3e3e3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("My Cart", style: GoogleFonts.inika(fontWeight: FontWeight.w700),),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 40,),
            
            // Cart list of user
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).collection("userCart").snapshots(),
              builder: (context, snapshot) {
                // Any Errors
                if(snapshot.hasError){
                  print("---------------Something went wrong----------------");
                }

                // Show loading circle
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if(snapshot.data == null){
                  print("Products not found");
                  return Text("Products not found", style: GoogleFonts.inika(color: const Color(0xff161416)),);
                }

                // Get products only with cement id
                final cartList = snapshot.data!.docs;

                return Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      // Get individual product
                      final cart = cartList[index];

                      // Product Quantity
                      int productQuantity = cart['productQuantity'];

                      itemCount = cartList.length;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10,),
                        decoration: BoxDecoration(
                            color: const Color(0xffd9d9d9),
                            boxShadow: const [BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),],
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: Slidable(
                          // endActionPane: ActionPane(
                          //   motion: const BehindMotion(),
                          //   children: [
                          //     GestureDetector(
                          //       onTap: () {
                          //         productQuantity--;
                          //         print("~~~~~~~~~~~~~~~Product Quantity is: ${productQuantity}");
                          //
                          //         if(productQuantity == 0 || productQuantity < 0) {
                          //           totalAmount = totalAmount - cart['productPrice'];
                          //           FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).collection("userCart").doc(cart['productName']).delete();
                          //         } else {
                          //           setState(() {
                          //             totalAmount = totalAmount - cart['productPrice'] * productQuantity;
                          //           });
                          //
                          //           // Updating the total amount on the user document
                          //           FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).update({
                          //             "totalAmount": totalAmount,
                          //           });
                          //
                          //           // Updating the product quantity on user cart collection products document
                          //           FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).collection("userCart").doc(cart['productName']).update({
                          //             "productQuantity": productQuantity,
                          //           });
                          //         }
                          //       },
                          //       child: Container(
                          //         padding: const EdgeInsets.all(10),
                          //         decoration: BoxDecoration(
                          //             color: const Color(0xff161416),
                          //             borderRadius: BorderRadius.circular(6)
                          //         ),
                          //         child: const Icon(LineIcons.minusCircle, color: Color(0xffe3e3e3),),
                          //       ),
                          //     ),
                          //     SizedBox(width: 40, child: Center(child: Text(productQuantity.toString(), style: GoogleFonts.inika(fontSize: 20),))),
                          //     GestureDetector(
                          //       onTap: () {
                          //         productQuantity++;
                          //         print("~~~~~~~~~~~~~~~Product QUantity is: ${productQuantity}");
                          //
                          //         setState(() {
                          //           totalAmount = totalAmount - cart['productPrice'];
                          //           totalAmount = totalAmount + cart['productPrice'] * productQuantity;
                          //         });
                          //
                          //         // Updating the total amount on the user document
                          //         FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).update({
                          //           "totalAmount": totalAmount,
                          //         });
                          //
                          //         // Updating the product quantity on user cart collection products document
                          //         FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).collection("userCart").doc(cart['productName']).update({
                          //           "productQuantity": productQuantity,
                          //         });
                          //       },
                          //       child: Container(
                          //         padding: const EdgeInsets.all(10),
                          //         decoration: BoxDecoration(
                          //             color: const Color(0xff161416),
                          //             borderRadius: BorderRadius.circular(6)
                          //         ),
                          //         child: const Icon(LineIcons.plusCircle, color: Color(0xffe3e3e3),),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          child: ListTile(
                              title: Text("${cart['productName']}", style: GoogleFonts.inika(fontWeight: FontWeight.w600, fontSize: 18),),
                              subtitle: Column(
                                children: [
                                  SizedBox(height: 16,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            style: GoogleFonts.inika(fontSize: 16, fontWeight: FontWeight.w400, color: const Color(0xff161416)),
                                            children: <TextSpan> [
                                              const TextSpan(text: "Price: ", style: TextStyle(fontWeight: FontWeight.w500)),
                                              TextSpan(text: "${cart['productPrice']}", style: const TextStyle(color: Color(0xff161416),)),
                                            ]
                                        ),
                                      ),
                                      // SizedBox(width: 40,),
                                      Container(
                                        height: 20,
                                        width: 1,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(200),
                                          color: const Color(0xff161416),
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            style: GoogleFonts.inika(fontSize: 16, fontWeight: FontWeight.w400, color: const Color(0xff161416)),
                                            children: <TextSpan> [
                                              const TextSpan(text: "Quantity: ", style: TextStyle(fontWeight: FontWeight.w500)),
                                              TextSpan(text: "${cart['productQuantity']}", style: const TextStyle(color: Color(0xff161416))),
                                            ]
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  Map<String, dynamic> data = {
                                    "productName": cart['productName'],
                                    "productPrice": cart['productPrice'] * cart['productQuantity'],
                                    "productId": cart['productId'],
                                    "productQuantity": cart['productQuantity'],
                                  };

                                  setState(() {
                                    totalAmount = totalAmount - data['productPrice'];
                                  });

                                  print("~~~~~~~~~~~~~~~~~~~ Total Amount of Products: ${totalAmount} ~~~~~~~~~~~~~~~~~");
                                  FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).update({
                                    "totalAmount": totalAmount,
                                  });

                                  showCustomToast(context, "${cart['productName']} removed.");

                                  FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).collection("userCart").doc(cart['productName']).delete();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: const Color(0xff161416),
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: const Icon(LineIcons.trash, color: Color(0xffe3e3e3),),
                                ),
                              )
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),

            const SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Total Amount: ", style: GoogleFonts.inika(fontSize: 20, fontWeight: FontWeight.w700),),
                Text("${totalAmount}/-", style: GoogleFonts.inika(fontSize: 20),),
              ],
            ),

            const SizedBox(height: 20,),

            totalAmount == 0 ? GestureDetector(
              onTap: () {
                showCustomToast(context, "Please add products to cart first.");
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(6)
                ),
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text("Checkout", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 16, color: Color(0xffe3e3e3)),
                  ),
                ),
              ),
            ) : MyButtons(
              onTap: () {
                // Move to the order checkout screen.
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckoutScreen()));
              },
              text: "Checkout",
            ),

            const SizedBox(height: 100,),
          ],
        ),
      ),
    );
  }
}
