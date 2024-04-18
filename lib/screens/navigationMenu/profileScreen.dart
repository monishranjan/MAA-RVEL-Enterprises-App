import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maarvel_e/components/bottomSheet/addressBottomSheet.dart';
import 'package:maarvel_e/components/myButtons.dart';
import 'package:maarvel_e/screens/ordersScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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


  // Logout User
  void logout() {
    try{
      FirebaseAuth.instance.signOut().then((value){
        GoogleSignIn().disconnect();
      });

      showCustomToast(context, "Logged out successfully.");
    } on FirebaseException catch(e) {
      showCustomToast(context, "Error occurred.");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: const Color(0xffe3e3e3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("My Profile", style: GoogleFonts.inika(fontWeight: FontWeight.w700),),
        elevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            final userProfile = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Icon(Icons.person, size: 140,),
                const SizedBox(height: 20,),
                Center(child: Text("${userProfile['fullName'] == null ? userProfile['username'] : userProfile['fullName']}", style: GoogleFonts.inika(color: const Color(0xff161416), fontSize: 20, fontWeight: FontWeight.w700),)),
                const SizedBox(height: 20,),

                Text("My Details", style: GoogleFonts.inika(color: Colors.grey[500], fontWeight: FontWeight.w300),),
                const SizedBox(height: 10,),

                // EMail
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffd9d9d9),
                      boxShadow: const [BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(2, 4)
                      )]
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("E-Mail", style: GoogleFonts.inika(fontSize: 12, color: Colors.grey[500]),),
                      Text("${currentUser!.email}", style: GoogleFonts.inika(fontSize: 16, color: const Color(0xff161416)),),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),

                // Phone Number
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffd9d9d9),
                      boxShadow: const [BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(2, 4)
                      )]
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Mobile Number", style: GoogleFonts.inika(fontSize: 12, color: Colors.grey[500]),),
                      Text(userProfile['phoneNumber'] == null ? "Not available" : userProfile['phoneNUmber'], style: GoogleFonts.inika(fontSize: 16, color: const Color(0xff161416)),),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),

                MyButtons(
                  text: "Logout",
                  onTap: logout,
                ),

                // Divider
                const SizedBox(height: 20,),
                Container(
                  height: 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: const Color(0xff161416),
                  ),
                ),

                // Orders
                const SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffd9d9d9),
                      boxShadow: const [BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(2, 4)
                      )]
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Orders", style: GoogleFonts.inika(fontSize: 16, color: const Color(0xff161416)),),
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersScreen()));
                        },
                        icon: const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xff161416), size: 20,),
                      ),
                    ],
                  ),
                ),
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
