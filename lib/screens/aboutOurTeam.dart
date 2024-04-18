import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maarvel_e/components/bottomNavBar.dart';

import '../components/myButtons.dart';
import '../utils/globals.dart';

class AboutOurTeam extends StatefulWidget {
  const AboutOurTeam({super.key});

  @override
  State<AboutOurTeam> createState() => _AboutOurTeamState();
}

class _AboutOurTeamState extends State<AboutOurTeam> {
  // Hide System Buttons & Change Status Bar Color Method
  void _hideSystemButton() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  }

  // Change page through thr bottom navigation bar

  @override
  void initState() {
    _hideSystemButton();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xffe3e3e3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("About Our Team", style: GoogleFonts.inika(fontWeight: FontWeight.w700),),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Image.asset("assets/images/about_us_500.png", width: 280,),

              // Teams
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("ourTeam").snapshots(),
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

                  // Get products only with team id
                  final ourTeam = snapshot.data!.docs;

                  return Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: ourTeam.length,
                      itemBuilder: (context, index) {
                        // Get individual product
                        final team = ourTeam[index];

                        return Container(
                          // margin: const EdgeInsets.only(bottom: 16,),
                          decoration: BoxDecoration(
                              color: const Color(0xffd9d9d9),
                              boxShadow: const [BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),],
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                // Logo
                                // Image.asset("assets/images/developer_icon.png", width: 80,),
                                SizedBox(width: 80, child: Image.network("${team['logo']}")),

                                // Name
                                const SizedBox(height: 10,),
                                Text("${team['name']}", style: GoogleFonts.inika(color: const Color(0xff161416), fontSize: 18, fontWeight: FontWeight.w700),),

                                // Designation
                                RichText(
                                  text: TextSpan(
                                      style: GoogleFonts.inika(fontSize: 16, fontWeight: FontWeight.w400),
                                      children: <TextSpan>[
                                        // TextSpan(text: "Designation:", style: GoogleFonts.inika(color: const Color(0xff161416), fontSize: 14, fontWeight: FontWeight.w600),),
                                        TextSpan(text: "${team['designation']}", style: GoogleFonts.inika(color: const Color(0xff161416), fontSize: 14, fontWeight: FontWeight.w400),),
                                      ]
                                  ),
                                ),

                                // Email
                                const SizedBox(height: 10,),
                                RichText(
                                  text: TextSpan(
                                      style: GoogleFonts.inika(fontSize: 16, fontWeight: FontWeight.w400),
                                      children: <TextSpan>[
                                        TextSpan(text: "Email: ", style: GoogleFonts.inika(color: const Color(0xff161416), fontSize: 14, fontWeight: FontWeight.w600),),
                                        TextSpan(text: "${team['email']}", style: GoogleFonts.inika(color: const Color(0xff161416), fontSize: 14, fontWeight: FontWeight.w400),),
                                      ]
                                  ),
                                ),
                              ],
                            ),
                          )
                        );
                      }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1/1.25
                    ),
                    ),
                  );
                },
              ),

              MyButtons(
                text: 'Return to Home',
                onTap: () {
                  myCurrentIndex = 0;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyBottomNavBar()));
                },
              ),
              const SizedBox(height: 150,),
            ],
          ),
        ),
      ),
    );
  }
}
