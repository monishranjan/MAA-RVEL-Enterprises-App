import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:maarvel_e/components/myButtons.dart';
import 'package:maarvel_e/screens/placedOrder.dart';
import 'package:maarvel_e/utils/globals.dart';
import 'package:random_string/random_string.dart';

import '../components/textField.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  var orderNumber = 'MAA${randomAlphaNumeric(5)}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: const Color(0xffe3e3e3),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Checkout", style: GoogleFonts.inika(fontWeight: FontWeight.w700),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: const Color(0xffd9d9d9),
                    boxShadow: const [BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),],
                    borderRadius: BorderRadius.circular(6)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order Details", style: GoogleFonts.inika(fontSize: 14),),
                        const SizedBox(height: 10,),
                        // Order Item Count
                        RichText(
                          text: TextSpan(
                              style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xff161416)),
                              children: <TextSpan> [
                                const TextSpan(text: "Item Count : ", style: TextStyle(fontWeight: FontWeight.w700)),
                                TextSpan(text: "${itemCount}", style: const TextStyle(color: Color(0xff161416), fontSize: 18)),
                              ]
                          ),
                        ),

                        // Order Number
                        RichText(
                          text: TextSpan(
                              style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xff161416)),
                              children: <TextSpan> [
                                const TextSpan(text: "Order Number : ", style: TextStyle(fontWeight: FontWeight.w700)),
                                TextSpan(text: orderNumber, style: const TextStyle(fontSize: 14)),
                              ]
                          ),
                        ),
                      ],
                    ),

                    // Divider
                    Container(
                      width: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: const Color(0xff161416),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total Amount:", style: GoogleFonts.inika(fontSize: 14),),
                        const SizedBox(height: 10,),
                        Text("${totalAmount}.00", style: GoogleFonts.inika(fontSize: 20, fontWeight: FontWeight.w700),),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              Container(
                height: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 20,),

              // Phone Number
              Text("Phone Number", style: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416)),),
              MyTextField(hintText: "Phone Number", obscureText: false, controller: phoneController, textInputAction: TextInputAction.next, keyboardType: TextInputType.phone,),
              const SizedBox(height: 20,),

              // Address Header
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text("Select Address", style: GoogleFonts.inika(fontSize: 16,), textAlign: TextAlign.center,),
              //     GestureDetector(
              //       onTap: () {
              //         showModalBottomSheet<dynamic>(
              //           showDragHandle: true,
              //           backgroundColor: const Color(0xffe3e3e3),
              //           barrierColor: const Color(0xff161416).withOpacity(.75),
              //           isScrollControlled: true,
              //           context: context,
              //           builder: (ctx) => Padding(
              //             padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              //             child: const AddressBottomSheet(),
              //           ),
              //         );
              //       },
              //       child: Container(
              //         decoration: BoxDecoration(
              //             color: const Color(0xff161416),
              //             borderRadius: BorderRadius.circular(6)
              //         ),
              //         padding: const EdgeInsets.all(10),
              //         child: Center(
              //           child: Row(
              //             children: [
              //               Text("New", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 12, color: const Color(0xffe3e3e3))),
              //               const SizedBox(width: 2,),
              //               const Icon(Icons.add_rounded, color: Color(0xffe3e3e3), size: 14,)
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 20,),
              // // Divider
              // Container(
              //   height: 2,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(200),
              //     color: const Color(0xff161416),
              //   ),
              // ),
              // const SizedBox(height: 20,),

              // Container(
              //   // height: 300,
              //   child: StreamBuilder(
              //     stream: FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).collection("addresses").snapshots(),
              //     builder: (context, snapshot) {
              //       // Any Errors
              //       if(snapshot.hasError){
              //         print("---------------Something went wrong----------------");
              //       }
              //
              //       // Show loading circle
              //       if(snapshot.connectionState == ConnectionState.waiting) {
              //         return const Center(
              //           child: CircularProgressIndicator(),
              //         );
              //       }
              //
              //       if(snapshot.data == null){
              //         return Text("No address found", style: GoogleFonts.inika(color: const Color(0xff161416)),);
              //       }
              //
              //       // Get all the address
              //       final addressList = snapshot.data!.docs;
              //
              //       return ListView.builder(
              //         physics: const NeverScrollableScrollPhysics(),
              //         shrinkWrap: true,
              //         itemCount: addressList.length,
              //         itemBuilder: (context, index) {
              //           // Get individual address
              //           final addresses = addressList[index];
              //           String radioSelectedAddress = "";
              //
              //           bool selectedAddressIcon = addresses['addressSelected'];
              //
              //           return Container(
              //             margin: const EdgeInsets.only(bottom: 10,),
              //             decoration: BoxDecoration(
              //                 color: const Color(0xffd9d9d9),
              //                 boxShadow: const [BoxShadow(
              //                   color: Colors.grey,
              //                   blurRadius: 5,
              //                   offset: Offset(0, 2),
              //                 ),],
              //                 borderRadius: BorderRadius.circular(6)
              //             ),
              //             child: ListTile(
              //                 title: Text("${addresses['addressName']}", style: GoogleFonts.inika(fontWeight: FontWeight.w600, color: const Color(0xff161416)),),
              //                 subtitle: Text("${addresses['address']}, ${addresses['pincode']}", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 14, color: const Color(0xff161416)),),
              //                 trailing: GestureDetector(
              //                   onTap: () {
              //                     setState(() {
              //                       selectedAddressIcon = !selectedAddressIcon;
              //                     });
              //
              //                     FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).collection("addresses").doc(addresses['addressName']).update(
              //                         {
              //                           'addressSelected': selectedAddressIcon,
              //                         });
              //                   },
              //                   child: Container(
              //                     padding: const EdgeInsets.all(10),
              //                     decoration: BoxDecoration(
              //                         color: const Color(0xff161416),
              //                         borderRadius: BorderRadius.circular(6)
              //                     ),
              //                     child: Icon((selectedAddressIcon == false) ? LineIcons.square : LineIcons.checkSquare, color: Color(0xffe3e3e3),),
              //                   ),
              //                 )
              //             ),
              //           );
              //         },
              //       );
              //     },
              //   ),
              // ),

              // Address
              Text("Address", style: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416)),),
              MyTextField(hintText: "Address", obscureText: false, controller: addressController, textInputAction: TextInputAction.next, keyboardType: TextInputType.text,),
              const SizedBox(height: 10,),

              // Address Area
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pincode", style: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416)),),
                        TextField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          controller: pincodeController,
                          cursorColor: const Color(0xff161416),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffd9d9d9),
                            hintText: "Pincode",
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
                      ],
                    ),
                  ),
                  Container(
                    width: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("City", style: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416)),),
                        TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          controller: cityController,
                          cursorColor: const Color(0xff161416),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffd9d9d9),
                            hintText: "City",
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
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),

              // State
              Text("State", style: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416)),),
              MyTextField(hintText: "State", obscureText: false, controller: stateController, textInputAction: TextInputAction.done, keyboardType: TextInputType.text,),
              const SizedBox(height: 30,),

              MyButtons(
                onTap: () async {
                  final dateFormatter = DateFormat('yyyy-MM-dd');
                  final timeFormatter = DateFormat('HH:mm:ss');

                  final DateTime now = DateTime.now();
                  final formattedDate = dateFormatter.format(now);
                  final formattedTime = timeFormatter.format(now);

                  try {
                    Map<String, dynamic> orderDetails = {
                      'orderNumber': orderNumber,
                      'itemCount': itemCount,
                      'orderAmount': totalAmount,
                      'email': currentUser!.email,
                      'phone': phoneController.text,
                      'address': addressController.text,
                      'pincode': pincodeController.text,
                      'city': cityController.text,
                      'state': stateController.text,
                      'date': formattedDate,
                      'time': formattedTime,
                      'status': "Pending",
                      'payment_status': 'Pending',
                    };

                    // User Orders
                    FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).collection("ordersPlaced").doc(orderNumber).set(orderDetails);

                    // Orders Placed with us
                    FirebaseFirestore.instance.collection("ordersPlaced").doc(orderNumber).set(orderDetails);

                    // Getting order details from userCart
                    FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).collection("userCart").get().then((QuerySnapshot snapshot) {
                      snapshot.docs.forEach((DocumentSnapshot doc) {
                        var item = doc.data() as Map<String, dynamic>;
                        try {
                          FirebaseFirestore.instance.collection("ordersPlaced").doc(orderNumber).collection("items").doc(doc.id).set(item);
                          FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).collection("ordersPlaced").doc(orderNumber).collection("items").doc(doc.id).set(item);
                        } on FirebaseException catch (e) {
                          print("=============================================\n\n");
                          print(e.code);
                          print("\n\n=============================================");
                        }
                      });
                    });

                    Navigator.push(context, MaterialPageRoute(builder: (context) => PlacedOrder()));
                  } on FirebaseException catch(e) {
                    print("~~~~~~~~~~~ Error creating the orders database ~~~~~~~~~~~");
                    print("~~~~~~~~~~~ ${e.code} ~~~~~~~~~~~");
                  }
                },
                text: "Place Order",
              ),
              const SizedBox(height: 40,),

              // Appreciation Text here for Users
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LineIcon.heart(size: 16,),
                  const SizedBox(width: 5,),
                  Text("We appreciate you for placing order.", style: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416)),),
                  const SizedBox(width: 5,),
                  const LineIcon.heart(size: 16,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
