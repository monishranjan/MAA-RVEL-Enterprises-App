import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maarvel_e/components/BottomSheet/blackStoneBottomSheet.dart';
import 'package:maarvel_e/components/BottomSheet/bricksBottomSheet.dart';
import 'package:maarvel_e/components/BottomSheet/cementBottomSheet.dart';
import 'package:maarvel_e/components/BottomSheet/sandBottomSheet.dart';
import 'package:maarvel_e/components/BottomSheet/tmtBarsBottomSheet.dart';
import 'package:maarvel_e/screens/navigationMenu/dashboard.dart';
import 'package:maarvel_e/screens/navigationMenu/cartScreen.dart';
import 'package:maarvel_e/screens/navigationMenu/profileScreen.dart';
import 'package:maarvel_e/screens/navigationMenu/settingsScreen.dart';

import '../screens/aboutOurTeam.dart';
import '../utils/globals.dart';

class Temp extends StatefulWidget {
  const Temp({super.key});

  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  // Get data from users database
  _getUserData() async {
    FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).snapshots().listen((docSnapshot) {
      Map<String, dynamic> data = docSnapshot.data()!;
      setState(() {
        totalAmount = data['totalAmount'];
      });
      print("~~~~~~~~~~~~ Total Amount is : ${totalAmount}~~~~~~~~~~~~~~");
    });
  }

  // Sign Out method
  void signOutUser() {
    FirebaseAuth.instance.signOut();
  }

  // Hide System Buttons & Change Status Bar Color Method
  void _hideSystemButton() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  }

  // Change page through thr bottom navigation bar
  int _myCurrentIndex = 0;

  static const List<Widget> myPages = <Widget>[
    Dashboard(),
    CartScreen(),
    SettingsScreen(),
    ProfileScreen(),
  ];

  void _tabChanged(int index) {
    setState(() {
      _myCurrentIndex = index;
    });
    myPages.elementAt(_myCurrentIndex);
  }

  @override
  void initState() {
    _hideSystemButton();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Temp Dashboard", style: GoogleFonts.inika(fontWeight: FontWeight.w700),),
        elevation: 0,
        centerTitle: true,
      ),
      extendBody: true,
      backgroundColor: const Color(0xffe3e3e3),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            color: const Color(0xff161416),
            borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: GNav(
            gap: 5,
            color: Colors.grey[600],
            activeColor: const Color(0xff161416),
            rippleColor: const Color(0xffCC2C34),
            hoverColor: const Color(0xffCC2C34),
            iconSize: 20,
            textStyle: GoogleFonts.inika(fontSize: 14, color: const Color(0xff161416), fontWeight: FontWeight.w500),
            tabBackgroundColor: const Color(0xffe3e3e3),
            tabBorderRadius: 20,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.5),
            duration: const Duration(milliseconds: 800),
            tabs: [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard()));
                },
              ),
              GButton(
                icon: LineIcons.shoppingCart,
                text: 'Cart',
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
                },
              ),
              GButton(
                icon: LineIcons.cog,
                text: 'Setting',
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                },
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profile',
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                },
              ),
            ],
            selectedIndex: myCurrentIndex,
            onTabChange: _tabChanged,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40,),
              Text("What would you like to order ?", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 16, color: const Color(0xff161416)),),
              const SizedBox(height: 20,),

              // Card Designs
              // Row 1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Cement Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: 170,
                    height: 230,
                    decoration: const BoxDecoration(
                        color: Color(0xffd9d9d9),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                        boxShadow: [BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(2, 4)
                        )]
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                          child: Image.asset("assets/images/cement.png"),
                        ),
                        const SizedBox(height: 10,),
                        Text("Cement", style: GoogleFonts.inika(fontSize: 18, fontWeight: FontWeight.w600, color: const Color(0xff161416)),),
                        const SizedBox(height: 10,),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet<dynamic>(
                              showDragHandle: true,
                              backgroundColor: const Color(0xffe3e3e3),
                              barrierColor: const Color(0xff161416).withOpacity(.75),
                              isScrollControlled: true,
                              context: context,
                              builder: (ctx) => const CementBottomSheet(),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xff161416),
                                borderRadius: BorderRadius.circular(6)
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: Text("Add to Cart", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 12, color: const Color(0xffe3e3e3),), textAlign: TextAlign.center),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // Sand Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: 170,
                    height: 230,
                    decoration: const BoxDecoration(
                        color: Color(0xffd9d9d9),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                        boxShadow: [BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(2, 4)
                        )]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 59,
                          child: Image.asset("assets/images/sand.png"),
                        ),
                        const SizedBox(height: 10,),
                        Text("Sand", style: GoogleFonts.inika(fontSize: 18, fontWeight: FontWeight.w600, color: const Color(0xff161416)),),
                        const SizedBox(height: 10,),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet<dynamic>(
                              showDragHandle: true,
                              backgroundColor: const Color(0xffe3e3e3),
                              barrierColor: const Color(0xff161416).withOpacity(.75),
                              isScrollControlled: true,
                              context: context,
                              builder: (ctx) => const SandBottomSheet(),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xff161416),
                                borderRadius: BorderRadius.circular(6)
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: Text("Add to Cart", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 12, color: const Color(0xffe3e3e3),), textAlign: TextAlign.center),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20,),

              // Row 2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bricks Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: 170,
                    height: 230,
                    decoration: const BoxDecoration(
                        color: Color(0xffd9d9d9),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                        boxShadow: [BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(2, 4)
                        )]
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                          child: Image.asset("assets/images/bricks.png"),
                        ),
                        const SizedBox(height: 10,),
                        Text("Bricks", style: GoogleFonts.inika(fontSize: 18, fontWeight: FontWeight.w600, color: const Color(0xff161416)),),
                        const SizedBox(height: 10,),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet<dynamic>(
                              showDragHandle: true,
                              backgroundColor: const Color(0xffe3e3e3),
                              barrierColor: const Color(0xff161416).withOpacity(.75),
                              isScrollControlled: true,
                              context: context,
                              builder: (ctx) => const BricksBottomSheet(),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xff161416),
                                borderRadius: BorderRadius.circular(6)
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: Text("Add to Cart", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 12, color: const Color(0xffe3e3e3),), textAlign: TextAlign.center),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // TMT Bars Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: 170,
                    height: 230,
                    decoration: const BoxDecoration(
                        color: Color(0xffd9d9d9),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                        boxShadow: [BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(2, 4)
                        )]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 59,
                          child: Image.asset("assets/images/tmtBars.png"),
                        ),
                        const SizedBox(height: 10,),
                        Text("TMT Bars", style: GoogleFonts.inika(fontSize: 18, fontWeight: FontWeight.w600, color: const Color(0xff161416)),),
                        const SizedBox(height: 10,),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet<dynamic>(
                              showDragHandle: true,
                              backgroundColor: const Color(0xffe3e3e3),
                              barrierColor: const Color(0xff161416).withOpacity(.75),
                              isScrollControlled: true,
                              context: context,
                              builder: (ctx) => const TMTBarsBottomSheet(),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xff161416),
                                borderRadius: BorderRadius.circular(6)
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: Text("Add to Cart", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 12, color: const Color(0xffe3e3e3),), textAlign: TextAlign.center),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20,),

              // Row 3
              // TMT Bars Card
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: 170,
                    height: 230,
                    decoration: const BoxDecoration(
                        color: Color(0xffd9d9d9),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                        boxShadow: [BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(2, 4)
                        )]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 59,
                          child: Image.asset("assets/images/blackStone.png"),
                        ),
                        const SizedBox(height: 10,),
                        Text("Black Stone (Gitti)", style: GoogleFonts.inika(fontSize: 18, fontWeight: FontWeight.w600, color: const Color(0xff161416)), textAlign: TextAlign.center,),
                        const SizedBox(height: 10,),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet<dynamic>(
                              showDragHandle: true,
                              backgroundColor: const Color(0xffe3e3e3),
                              barrierColor: const Color(0xff161416).withOpacity(.75),
                              isScrollControlled: true,
                              context: context,
                              builder: (ctx) => const BlackStoneBottomSheet(),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xff161416),
                                borderRadius: BorderRadius.circular(6)
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: Text("Add to Cart", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 12, color: const Color(0xffe3e3e3),), textAlign: TextAlign.center),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 40,),
              // Divider
              Container(
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: const Color(0xff161416),
                ),
              ),
              const SizedBox(height: 40,),

              // Team Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // About Us
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xffd9d9d9),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                        boxShadow: [BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(2, 4)
                        )]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Image.asset("assets/images/about_us.png"),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutOurTeam()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xff161416),
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Center(
                                child: Text("About\nOur Team", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 14, color: const Color(0xffe3e3e3),), textAlign: TextAlign.center),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  // Contact Us
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xffd9d9d9),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                        boxShadow: [BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(2, 4)
                        )]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      child: Column(
                        children: [
                          SizedBox(width: 118,child: Image.asset("assets/images/contact_us.png"),),
                          Row(
                            children: [
                              Text("Need more\nInformation", style: GoogleFonts.inika(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xff161416),), textAlign: TextAlign.right,),
                              const SizedBox(width: 8,),
                              Container(
                                height: 40,
                                width: 2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  color: const Color(0xff161416),
                                ),
                              ),
                              const SizedBox(width: 8,),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Temp()));
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
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Text("Contact for bulk orders*", style: GoogleFonts.inika(fontSize: 12, fontWeight: FontWeight.w400),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100,)
            ],
          ),
        ),
      ),
    );
  }
}
