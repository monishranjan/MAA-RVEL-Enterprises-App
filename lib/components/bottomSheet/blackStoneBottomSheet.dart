import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maarvel_e/components/bottomNavBar.dart';

import '../../utils/globals.dart';
import '../myButtons.dart';

class BlackStoneBottomSheet extends StatefulWidget {
  const BlackStoneBottomSheet({super.key});

  @override
  State<BlackStoneBottomSheet> createState() => _BlackStoneBottomSheetState();
}

class _BlackStoneBottomSheetState extends State<BlackStoneBottomSheet> {
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
    fToast.showToast(child: toast, toastDuration: const Duration(seconds: 2), gravity: ToastGravity.CENTER);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.75,
      // height: 460,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/images/blackStone.png", width: 100,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Black Stone Gitti", style: GoogleFonts.inika(fontSize: 24, fontWeight: FontWeight.w700),),
                  Text("All sizes of stone are\navailable. Price and quantity\nis in Sq feet.", style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400),textAlign: TextAlign.justify,),
                  Text("Minimum Order Quantity\n--> 500 / Sq feet.", style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400),textAlign: TextAlign.justify,),
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

          // Cements of different brand
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("products").where("productId", isEqualTo: "blackStoneGitti").snapshots(),
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
              final blackStoneGitti = snapshot.data!.docs;

              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: blackStoneGitti.length,
                  itemBuilder: (context, index) {
                    // Get individual product
                    final bsGitti = blackStoneGitti[index];
                    String productName = bsGitti['productName'];
                    var tProductName = productName.replaceAll(RegExp('[^A-Za-z: \s]'), '');

                    int productQuantity = 0;

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
                          // title: Text("${bsGitti['productName']}", style: GoogleFonts.inika(fontWeight: FontWeight.w600),),
                          title: Text("${tProductName} (${bsGitti['size']}mm*)", style: GoogleFonts.inika(fontWeight: FontWeight.w600),),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10,),
                              Text("Price: ${bsGitti['productPrice']}/- (Sq feet)", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 16),),
                              Text("Quantity (Sq feet)", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 12),),
                              const SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      productQuantity = 500;
                                      showCustomToast(context, "Quantity is set to ${productQuantity} Sq feet");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xff161416),
                                          borderRadius: BorderRadius.circular(6)
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: Center(
                                        child: Text("500", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 14, color: const Color(0xffe3e3e3)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      productQuantity = 1000;
                                      showCustomToast(context, "Quantity is set to ${productQuantity} Sq feet");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xff161416),
                                          borderRadius: BorderRadius.circular(6)
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: Center(
                                        child: Text("1000", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 14, color: const Color(0xffe3e3e3)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      productQuantity = 1500;
                                      showCustomToast(context, "Quantity is set to ${productQuantity} Sq feet");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xff161416),
                                          borderRadius: BorderRadius.circular(6)
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: Center(
                                        child: Text("1500", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 14, color: const Color(0xffe3e3e3)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          trailing: GestureDetector(
                            onTap: () async {
                              if(productQuantity == 0) {
                                showCustomToast(context, "Please select quantity first.");
                              } else {
                                Map<String, dynamic> data = {
                                  "productName": '${bsGitti['productName']}mm',
                                  "productPrice": bsGitti['productPrice'],
                                  "productId": bsGitti['productId'],
                                  "productQuantity": productQuantity,
                                  "size": bsGitti['size'],
                                };
                                FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).collection("userCart").doc(bsGitti['productName']).set(data);

                                // Calculating and updating total amount for cart page
                                print("~~~~~~~~~~~~~~~~~~~ Price of the Product is: ${data['productPrice']} ~~~~~~~~~~~~~~~~~");
                                totalAmount = totalAmount + data['productPrice'] * data['productQuantity'];
                                print("~~~~~~~~~~~~~~~~~~~ Total Amount of Products: ${totalAmount} ~~~~~~~~~~~~~~~~~");
                                FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).update({
                                  "totalAmount": totalAmount,
                                });

                                showCustomToast(context, "${productName} added to cart.");
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: const Color(0xff161416),
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              child: const Icon(LineIcons.addToShoppingCart, color: Color(0xffe3e3e3),),
                            ),
                          )
                      ),
                    );
                  },
                ),
              );
            },
          ),

          const SizedBox(height: 20,),

          MyButtons(
            onTap: () {
              Navigator.pop(context);
              myCurrentIndex = 1;
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyBottomNavBar()));
              print('~~~~~~~~~~~~~~ The total amount which is going to the cart screen is : ${totalAmount} ~~~~~~~~~~~~~~~');
            },
            text: "Go to Cart",
          ),
          const SizedBox(height: 30,)
        ],
      ),
    );
  }
}
