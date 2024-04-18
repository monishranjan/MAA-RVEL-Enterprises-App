import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SandBottomSheet extends StatefulWidget {
  const SandBottomSheet({super.key});

  @override
  State<SandBottomSheet> createState() => _SandBottomSheetState();
}

class _SandBottomSheetState extends State<SandBottomSheet> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  // Method for direct call button
  Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri _phoneUri = Uri(
        scheme: "tel",
        path: contactNumber
    );
    try {
      if (await canLaunchUrl(_phoneUri)) {
        await launchUrl(_phoneUri);
      }
    } catch (error) {
      throw("Cannot dial");
    }
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
              Image.asset("assets/images/sand.png", width: 120,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sand", style: GoogleFonts.inika(fontSize: 24, fontWeight: FontWeight.w700),),
                  Text("Select which brand would\nyou like to purchase.", style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400),),
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

          // Vehicle Type Cards
          Align(alignment: Alignment.topLeft, child: Text("Vehicle Type", style: GoogleFonts.inika(fontWeight: FontWeight.w600, fontSize: 16))),
          const SizedBox(height: 10,),

          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 16,),
                  padding: EdgeInsets.all(10),
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
                    title: Text("Tractor", style: GoogleFonts.inika(color: const Color(0xff161416), fontWeight: FontWeight.w600, fontSize: 16),),
                    // trailing: GestureDetector(
                    //   onTap: () {},
                    //   child: const Icon(Icons.circle_outlined, color: Color(0xff161416),),
                    // ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16,),
                  padding: EdgeInsets.all(10),
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
                    title: Text("Tipper", style: GoogleFonts.inika(color: const Color(0xff161416), fontWeight: FontWeight.w600, fontSize: 16),),
                    // trailing: GestureDetector(
                    //   onTap: () {},
                    //   child: const Icon(Icons.circle_outlined, color: Color(0xff161416),),
                    // ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16,),
                  padding: EdgeInsets.all(10),
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
                    title: Text("Hywa", style: GoogleFonts.inika(color: const Color(0xff161416), fontWeight: FontWeight.w600, fontSize: 16),),
                    subtitle: Text("10, 12, 14, 16, 18, 20, 22, 24 Tyres", style: GoogleFonts.inika(color: const Color(0xff161416), fontWeight: FontWeight.w200, fontSize: 14),),
                    // trailing: GestureDetector(
                    //   onTap: () {},
                    //   child: const Icon(Icons.circle_outlined, color: Color(0xff161416),),
                    // ),
                  ),
                ),
              ],
            ),
          ),

          // const SizedBox(height: 10,),

          Text("For rates contact us. As, rates are always flexible", style: GoogleFonts.inika(color: const Color(0xff161416), fontSize: 16),),
          const SizedBox(height: 20,),

          GestureDetector(
            onTap: () {
              launchPhoneDialer('${7876589508}');
            },
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xff161416),
                  borderRadius: BorderRadius.circular(6)
              ),
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  "Contact",
                  style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 14, color: const Color(0xffe3e3e3)),
                ),
              ),
            ),
          ),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
}
