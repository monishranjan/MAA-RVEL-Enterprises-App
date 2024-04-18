import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maarvel_e/components/myButtons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/globals.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffe3e3e3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("$orderNumber", style: GoogleFonts.inika(fontWeight: FontWeight.w700),),
        elevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("ordersPlaced").doc(orderNumber).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            final orderDetails = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              padding: const EdgeInsets.all(16),
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
                                  TextSpan(text: "${orderDetails['itemCount']}", style: const TextStyle(color: Color(0xff161416), fontSize: 18)),
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

                          // Order Status
                          RichText(
                            text: TextSpan(
                                style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xff161416)),
                                children: <TextSpan> [
                                  const TextSpan(text: "Status : ", style: TextStyle(fontWeight: FontWeight.w700)),
                                  orderDetails['status'] == "Delivered" || orderDetails['status'] == "Out for Delivery" ? TextSpan(text: "${orderDetails['status']}", style: const TextStyle(color: Color(0xff3d9d22), fontSize: 16)) : orderDetails['status'] == "Pending" ? TextSpan(text: "${orderDetails['status']}", style: const TextStyle(color: Color(0xffff8800), fontSize: 16)) : TextSpan(text: "${orderDetails['status']}", style: const TextStyle(color: Color(0xffcc2c34), fontWeight: FontWeight.w700)),
                                ]
                            ),
                          ),

                          // Payment Status
                          RichText(
                            text: TextSpan(
                                style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xff161416)),
                                children: <TextSpan> [
                                  const TextSpan(text: "Payment Status : ", style: TextStyle(fontWeight: FontWeight.w700)),
                                  orderDetails['payment_status'] == "Done" ? TextSpan(text: "${orderDetails['payment_status']}", style: const TextStyle(color: Color(0xff3d9d22), fontSize: 16)) : orderDetails['payment_status'] == "Pending" ? TextSpan(text: "${orderDetails['payment_status']}", style: const TextStyle(color: Color(0xffff8800), fontSize: 16)) : TextSpan(text: "${orderDetails['payment_status']}", style: const TextStyle(color: Color(0xffcc2c34), fontWeight: FontWeight.w700)),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total Amount:", style: GoogleFonts.inika(fontSize: 14),),
                          Text("${orderAmount}.00", style: GoogleFonts.inika(fontSize: 20, fontWeight: FontWeight.w700),),
                          const SizedBox(height: 10,),
                          orderDetails['status'] == 'Order Cancelled' ? Container(
                            decoration: BoxDecoration(
                                // color: Color(0xff161416),
                                borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: const Color(0xff161416)
                              )
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: Text("Cancelled", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.grey[500]),
                              ),
                            ),
                          ) : orderDetails['payment_status'] == 'Done' ? Container(
                            decoration: BoxDecoration(
                              // color: Color(0xff161416),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: const Color(0xff161416)
                                )
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: Text("Paid", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.grey[500]),
                              ),
                            ),
                          ) : GestureDetector(
                            onTap: () async {
                              final Uri url = Uri.parse('upi://pay?pa=monishranjan9@okicici&pn=Maarvel Enterprises&am=${orderAmount}&tn=Payment for order number: ${orderNumber}&cu=INR');
                              var result = await launchUrl(url);
                              debugPrint(result.toString());
                              if(result == true) {
                                print("Done");
                              } else {
                                print("Fail");
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xff161416),
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Center(
                                child: Text("Pay Early", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 12, color: const Color(0xffe3e3e3)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Center(child: Text("Note: Payment status can take few hours to update here.", style: GoogleFonts.inika(fontSize: 12),)),

                const SizedBox(height: 20,),
                Container(
                  height: 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: const Color(0xff161416),
                  ),
                ),
                const SizedBox(height: 40,),

                // Products List
                Container(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("ordersPlaced").doc(orderNumber).collection("items").snapshots(),
                    builder: (context, snapshot) {
                      final itemsList = snapshot.data!.docs;

                      if(snapshot.hasData){
                        return Container(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: itemsList.length,
                            itemBuilder: (context, index) {
                              final item = itemsList[index];

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
                                  title: Text("Product Details",style: GoogleFonts.inika(fontSize: 14, color: Colors.grey[500]),),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10,),
                                      // Product Name
                                      RichText(
                                        text: TextSpan(
                                            style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xff161416)),
                                            children: <TextSpan> [
                                              const TextSpan(text: "Product Name : ", style: TextStyle(fontWeight: FontWeight.w700)),
                                              TextSpan(text: "${item['productName']}", style: const TextStyle(color: Color(0xff161416), fontSize: 16)),
                                            ]
                                        ),
                                      ),

                                      // Product Price
                                      RichText(
                                        text: TextSpan(
                                            style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xff161416)),
                                            children: <TextSpan> [
                                              const TextSpan(text: "Product Price : ", style: TextStyle(fontWeight: FontWeight.w700)),
                                              TextSpan(text: "${item['productPrice']}", style: const TextStyle(color: Color(0xff161416), fontSize: 16)),
                                            ]
                                        ),
                                      ),

                                      // Product Quantity
                                      RichText(
                                        text: TextSpan(
                                            style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xff161416)),
                                            children: <TextSpan> [
                                              const TextSpan(text: "Product Quantity : ", style: TextStyle(fontWeight: FontWeight.w700)),
                                              TextSpan(text: "${item['productQuantity']}", style: const TextStyle(color: Color(0xff161416), fontSize: 16)),
                                            ]
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else if (snapshot.hasError){
                        return Center(
                          child: Text("Error + ${snapshot.error}"),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator(),);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20,),

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("More Details", style: GoogleFonts.inika(fontSize: 14),),
                      const SizedBox(height: 10,),

                      // Full Address
                      RichText(
                        text: TextSpan(
                            style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xff161416)),
                            children: <TextSpan> [
                              const TextSpan(text: "Address : ", style: TextStyle(fontWeight: FontWeight.w700)),
                              TextSpan(text: "${orderDetails['address']}, ${orderDetails['city']}, ${orderDetails['state']}, ${orderDetails['pincode']}", style: const TextStyle(color: Color(0xff161416))),
                            ]
                        ),
                      ),

                      // Phone
                      RichText(
                        text: TextSpan(
                            style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xff161416)),
                            children: <TextSpan> [
                              const TextSpan(text: "Phone : ", style: TextStyle(fontWeight: FontWeight.w700)),
                              TextSpan(text: "+91-${orderDetails['phone']}", style: const TextStyle(color: Color(0xff161416))),
                            ]
                        ),
                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 20,),

                MyButtons(
                  onTap: () {
                    // Updating status to management side
                    FirebaseFirestore.instance.collection("ordersPlaced").doc(orderNumber).update({
                      "status": "Order Cancelled",
                    });

                    // Updating status for customers
                    FirebaseFirestore.instance.collection("Users").doc(orderDetails['email']).collection("ordersPlaced").doc(orderNumber).update({
                      "status": "Order Cancelled",
                    });
                  },
                  text: "Cancel Order",
                ),
                const SizedBox(height: 40,),
              ],
            );
          } else if (snapshot.hasError){
            return Center(
              child: Text("Error + ${snapshot.error}"),
            );
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}

// class paymentUpdatePopUp extends StatelessWidget {
//   const paymentUpdatePopUp({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () => showPopover(
//           context: context,
//           transitionDuration: const Duration(milliseconds: 150),
//           bodyBuilder: (context) => const PaymentUpdateStatus(),
//           direction: PopoverDirection.top,
//           width: 200,
//           height: 150,
//           backgroundColor: Colors.grey.shade300
//       ),
//       icon: const Icon(Icons.keyboard_arrow_up_rounded, color: Color(0xff161416), size: 30,),
//     );
//   }
// }

// class popUpButton extends StatelessWidget {
//   const popUpButton({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () => showPopover(
//           context: context,
//           transitionDuration: const Duration(milliseconds: 150),
//           bodyBuilder: (context) => const UpdateStatus(),
//           direction: PopoverDirection.top,
//           width: 200,
//           height: 200,
//           backgroundColor: Colors.grey.shade300
//       ),
//       icon: const Icon(Icons.keyboard_arrow_up_rounded, color: Color(0xff161416), size: 30,),
//     );
//   }
// }