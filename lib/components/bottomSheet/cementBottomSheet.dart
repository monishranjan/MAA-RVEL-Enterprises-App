import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maarvel_e/components/bottomNavBar.dart';
import 'package:maarvel_e/components/myButtons.dart';
import 'package:maarvel_e/screens/navigationMenu/cartScreen.dart';
import 'package:maarvel_e/utils/globals.dart';

class CementBottomSheet extends StatefulWidget {
  const CementBottomSheet({super.key});

  @override
  State<CementBottomSheet> createState() => _CementBottomSheetState();
}

class _CementBottomSheetState extends State<CementBottomSheet> {
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

  // Custom product quantity toast
  showQuantityToast(BuildContext context, String msg) {
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/images/cement.png"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Cement", style: GoogleFonts.inika(fontSize: 24, fontWeight: FontWeight.w700),),
                  Text("Select which brand would\nyou like to purchase.", style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400),),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Container(
            width: 275,
            height: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              color: const Color(0xff161416),
            ),
          ),
          const SizedBox(height: 20,),

          // Cements of different brand
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("products").where("productId", isEqualTo: "cement").snapshots(),
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
                return Text("Products not found", style: GoogleFonts.inika(color: const Color(0xff161416)),);
              }

              // Get products only with cement id
              final cementProduct = snapshot.data!.docs;

              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cementProduct.length,
                  itemBuilder: (context, index) {
                    // Get individual product
                    final cement = cementProduct[index];

                    // Getting and Setting product quantity for cart screen
                    int productQuantity = 1;

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
                      child: ListTile(
                        title: Text("${cement['productName']} (${cement['grade']}*)", style: GoogleFonts.inika(fontWeight: FontWeight.w600),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Price: ${cement['productPrice']}/-", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 16),),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if(productQuantity <= 1) {
                                          productQuantity = 1;
                                        } else {
                                          productQuantity--;
                                        }
                                        print("~~~~~~~~~~~~~~~ ${productQuantity}");

                                        showQuantityToast(context, "Product quantity decreased: ${productQuantity}");
                                      },
                                      icon: const Icon(LineIcons.minusCircle, color: Color(0xff161416), size: 30,),
                                    ),

                                    IconButton(
                                      onPressed: () {
                                        productQuantity++;
                                        print("~~~~~~~~~~~~~~~ ${productQuantity}");

                                        showQuantityToast(context, "Product quantity increased: ${productQuantity}");
                                      },
                                      icon: const Icon(LineIcons.plusCircle, color: Color(0xff161416), size: 30,),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Map<String, dynamic> data = {
                                      "productName": cement['productName'],
                                      "productPrice": cement['productPrice'],
                                      "grade": cement['grade'],
                                      "productId": cement['productId'],
                                      "productQuantity": productQuantity,
                                    };
                                    FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).collection("userCart").doc(cement['productName']).set(data);

                                    // Calculating and updating total amount for cart page
                                    print("~~~~~~~~~~~~~~~~~~~ Price of the Product is: ${data['productPrice']} ~~~~~~~~~~~~~~~~~");
                                    totalAmount = totalAmount + data['productPrice'] * productQuantity;
                                    print("~~~~~~~~~~~~~~~~~~~ Total Amount of Products: ${totalAmount} ~~~~~~~~~~~~~~~~~");
                                    FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).update({
                                      "totalAmount": totalAmount,
                                    });

                                    showCustomToast(context, "${cement['productName']} added to cart");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xff161416),
                                        borderRadius: BorderRadius.circular(6)
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Center(
                                      child: Text(
                                        "Add Product",
                                        style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 12, color: const Color(0xffe3e3e3)),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        // trailing: GestureDetector(
                        //   onTap: () async {
                        //     // Product quantity
                        //     int productQuantity = 1;
                        //
                        //     Map<String, dynamic> data = {
                        //       "productName": cement['productName'],
                        //       "productPrice": cement['productPrice'],
                        //       "grade": cement['grade'],
                        //       "productId": cement['productId'],
                        //       "productQuantity": productQuantity,
                        //     };
                        //     FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).collection("userCart").doc(cement['productName']).set(data);
                        //
                        //     // Calculating and updating total amount for cart page
                        //     print("~~~~~~~~~~~~~~~~~~~ Price of the Product is: ${data['productPrice']} ~~~~~~~~~~~~~~~~~");
                        //     totalAmount = totalAmount + data['productPrice'];
                        //     print("~~~~~~~~~~~~~~~~~~~ Total Amount of Products: ${totalAmount} ~~~~~~~~~~~~~~~~~");
                        //     FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).update({
                        //       "totalAmount": totalAmount,
                        //     });
                        //   },
                        //   child: Container(
                        //     padding: const EdgeInsets.all(10),
                        //     decoration: BoxDecoration(
                        //       color: const Color(0xff161416),
                        //       borderRadius: BorderRadius.circular(6)
                        //     ),
                        //     child: const Icon(LineIcons.addToShoppingCart, color: Color(0xffe3e3e3),),
                        //   ),
                        // ),
                      ),
                    );
                  },
                ),
              );
            },
          ),

          // Proceed to Checkout Page
          const SizedBox(height: 50,),
          MyButtons(
            text: "Go to Cart",
            onTap: () {
              Navigator.pop(context);
              myCurrentIndex = 1;
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyBottomNavBar()));
              print('~~~~~~~~~~~~~~ The total amount which is going to the cart screen is : ${totalAmount} ~~~~~~~~~~~~~~~');
            },
          ),
        ],
      ),
    );
  }
}