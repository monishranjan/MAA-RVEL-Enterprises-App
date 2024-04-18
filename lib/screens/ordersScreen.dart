import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maarvel_e/utils/globals.dart';

import 'orderDetailScreen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: const Color(0xffe3e3e3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Orders", style: GoogleFonts.inika(fontWeight: FontWeight.w700),),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 40,),

            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).collection("ordersPlaced").snapshots(),
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
                  return Text("No Orders are placed", style: GoogleFonts.inika(color: const Color(0xff161416)),);
                }

                // Get orders list
                final ordersList = snapshot.data!.docs;

                FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).update({
                  "orders": ordersList.length,
                });

                return Container(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ordersList.length,
                    itemBuilder: (context, index) {
                      // Get single order details
                      final orderItem = ordersList[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                            color: const Color(0xffd9d9d9),
                            boxShadow: const [BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            )],
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: ListTile(
                          title: Text("Order Details",style: GoogleFonts.inika(fontSize: 14, color: Colors.grey[500]),),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10,),
                              // Item Count
                              RichText(
                                text: TextSpan(
                                    style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xff161416)),
                                    children: <TextSpan> [
                                      const TextSpan(text: "Item Count : ", style: TextStyle(fontWeight: FontWeight.w700)),
                                      TextSpan(text: "${orderItem['itemCount']}", style: const TextStyle(color: Color(0xff161416), fontSize: 18)),
                                    ]
                                ),
                              ),

                              // Order Amount
                              RichText(
                                text: TextSpan(
                                    style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xff161416)),
                                    children: <TextSpan> [
                                      const TextSpan(text: "Order Amount : ", style: TextStyle(fontWeight: FontWeight.w700)),
                                      TextSpan(text: "${orderItem['orderAmount']}", style: const TextStyle(color: Color(0xff161416), fontSize: 16)),
                                    ]
                                ),
                              ),

                              // Order Number
                              RichText(
                                text: TextSpan(
                                    style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xff161416)),
                                    children: <TextSpan> [
                                      const TextSpan(text: "Order Number : ", style: TextStyle(fontWeight: FontWeight.w700)),
                                      TextSpan(text: "${orderItem['orderNumber']}", style: const TextStyle(color: Color(0xff161416), fontSize: 16)),
                                    ]
                                ),
                              ),
                              const SizedBox(height: 10,),

                              // Order Amount
                              RichText(
                                text: TextSpan(
                                    style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xff161416)),
                                    children: <TextSpan> [
                                      const TextSpan(text: "Date : ", style: TextStyle(fontWeight: FontWeight.w700)),
                                      TextSpan(text: "${orderItem['date']}", style: const TextStyle(color: Color(0xff161416), fontSize: 16)),
                                    ]
                                ),
                              ),

                              // Order Status
                              RichText(
                                text: TextSpan(
                                    style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xff161416)),
                                    children: <TextSpan> [
                                      const TextSpan(text: "Status : ", style: TextStyle(fontWeight: FontWeight.w700)),
                                      orderItem['status'] == "Delivered" || orderItem['status'] == "Out for Delivery" ? TextSpan(text: "${orderItem['status']}", style: const TextStyle(color: Color(0xff3d9d22), fontSize: 16)) : orderItem['status'] == "Pending" ? TextSpan(text: "${orderItem['status']}", style: const TextStyle(color: Color(0xffff8800), fontSize: 16)) : TextSpan(text: "${orderItem['status']}", style: const TextStyle(color: Color(0xffcc2c34), fontSize: 16)),
                                    ]
                                ),
                              ),
                            ],
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              orderNumber = orderItem['orderNumber'];
                              orderAmount = orderItem['orderAmount'];

                              Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderDetailScreen()));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: const Color(0xff161416),
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              child: const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xffe3e3e3),),
                            ),
                          )
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}