import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maarvel_e/components/myButtons.dart';

class AddressBottomSheet extends StatefulWidget {
  const AddressBottomSheet({super.key});

  @override
  State<AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  final TextEditingController addressNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  bool showAddAddress = false;
  
  Widget showNewAddress() {
    if(showAddAddress) {
      return SizedBox(
        child: Column(
          children: [
            // Address Name
            TextField(
              textInputAction: TextInputAction.next,
              controller: addressNameController,
              cursorColor: const Color(0xff161416),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffd9d9d9),
                labelText: "Address Name",
                labelStyle: GoogleFonts.inika(fontWeight: FontWeight.w400, color: const Color(0xff161416).withOpacity(.5)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6)
                ),
                enabledBorder: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff161416)),
                ),
              ),
            ),
            const SizedBox(height: 10,),


            // Address
            TextField(
              textInputAction: TextInputAction.next,
              controller: addressController,
              cursorColor: const Color(0xff161416),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffd9d9d9),
                labelText: "Address",
                labelStyle: GoogleFonts.inika(fontWeight: FontWeight.w400, color: const Color(0xff161416).withOpacity(.5)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6)
                ),
                enabledBorder: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff161416)),
                ),
              ),
            ),
            const SizedBox(height: 10,),

            // Pincode
            TextField(
              textInputAction: TextInputAction.next,
              controller: pincodeController,
              cursorColor: const Color(0xff161416),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffd9d9d9),
                labelText: "Pincode",
                labelStyle: GoogleFonts.inika(fontWeight: FontWeight.w400, color: const Color(0xff161416).withOpacity(.5)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6)
                ),
                enabledBorder: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff161416)),
                ),
              ),
            ),
            const SizedBox(height: 10,),


            // City
            TextField(
              textInputAction: TextInputAction.next,
              controller: cityController,
              cursorColor: const Color(0xff161416),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffd9d9d9),
                labelText: "City",
                labelStyle: GoogleFonts.inika(fontWeight: FontWeight.w400, color: const Color(0xff161416).withOpacity(.5)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6)
                ),
                enabledBorder: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff161416)),
                ),
              ),
            ),
            const SizedBox(height: 10,),

            // State
            TextField(
              textInputAction: TextInputAction.done,
              controller: stateController,
              cursorColor: const Color(0xff161416),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffd9d9d9),
                labelText: "State",
                labelStyle: GoogleFonts.inika(fontWeight: FontWeight.w400, color: const Color(0xff161416).withOpacity(.5)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6)
                ),
                enabledBorder: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff161416)),
                ),
              ),
            ),

            const SizedBox(height: 20,),

            // Save Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButtons(
                  text: "Save",
                  onTap: () async {
                    Map<String, dynamic> addressData = {
                      'addressName': addressNameController.text,
                      'address': addressController.text,
                      'pincode': pincodeController.text,
                      'city': cityController.text,
                      'state': stateController.text,
                    };

                    await FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).collection("addresses").doc(addressNameController.text).set(addressData);

                    setState(() {
                      showAddAddress = !showAddAddress;
                    });
                  },
                ),
                MyButtons(
                  text: "Close",
                  onTap: () {
                    setState(() {
                      showAddAddress = !showAddAddress;
                    });
                  },
                ),
              ],
            ),
          ],
        )
      );
    } else {
      return const SizedBox(height: 0,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Address", style: GoogleFonts.inika(fontSize: 20, fontWeight: FontWeight.w700),),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showAddAddress = !showAddAddress;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff161416),
                      borderRadius: BorderRadius.circular(6)
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Row(
                      children: [
                        Text("New", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 12, color: const Color(0xffe3e3e3))),
                        const SizedBox(width: 2,),
                        const Icon(Icons.add_rounded, color: Color(0xffe3e3e3), size: 14,)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Container(
            height: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              color: const Color(0xff161416),
            ),
          ),
          const SizedBox(height: 20,),

          showNewAddress(),

          const SizedBox(height: 20,),

          // Address List
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).collection("addresses").snapshots(),
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
                return Text("No address found", style: GoogleFonts.inika(color: const Color(0xff161416)),);
              }

              // Get all the address
              final addressList = snapshot.data!.docs;

              return Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: addressList.length,
                  itemBuilder: (context, index) {
                    // Get individual address
                    final addresses = addressList[index];


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
                          title: Text("${addresses['addressName']}", style: GoogleFonts.inika(fontWeight: FontWeight.w600, color: const Color(0xff161416)),),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${addresses['address']}, ${addresses['pincode']}", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 14, color: const Color(0xff161416)),),
                              Text("City: ${addresses['city']}", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 14, color: const Color(0xff161416)),),
                              Text("State: ${addresses['state']}", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 14, color: const Color(0xff161416)),),
                            ],
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).collection("addresses").doc(addresses['addressName']).delete();
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
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
