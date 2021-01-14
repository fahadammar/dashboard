// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dashboard/Screen/TutorRequest.dart';
// import 'package:dashboard/Screen/secondPage.dart';
// import 'package:dashboard/Widgets/drawerMenu.dart';
// import 'package:dashboard/common/Collapsing_Navigation_Drawer.dart';
// import 'package:dashboard/theme.dart';
import 'package:firebaseflutterdemo/Screen/TutorRequest.dart';
import 'package:firebaseflutterdemo/Screen/secondPage.dart';
import 'package:firebaseflutterdemo/Widgets/drawerMenu.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

//! External Modules
// import 'package:dashboard/Widgets/leftNav.dart';
// import 'package:dashboard/theme.dart';
// import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  static final Dashboard _dashboard = Dashboard.internal();

  factory Dashboard() {
    return _dashboard;
  }
  Dashboard.internal();

  PageController pageController = PageController();
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Demo',
      home: Scaffold(
        appBar: AppBar(
          title: ListTile(
            leading: Icon(
              Icons.dashboard,
              color: OrangeLight,
            ),
            title: Text(
              "Dashboard",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
          backgroundColor: Colors.black,
        ),
        drawer: DrawerMenu(),
        body: PageView(
          controller: widget.pageController,
          children: [
            TutorRequest(),
            SecondPage(),
          ],
        ),
      ),
    );
  }
}
/*
Stack(
          children: <Widget>[
            // Container
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Orange,
                      OrangeLight,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            // Drawer
            CollapsingNavigationDrawer(),
          ],
        ),
*/
