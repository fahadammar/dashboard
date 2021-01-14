// import 'package:dashboard/Screen/dashboard.dart';
// import 'package:dashboard/Screen/tutorRequest.dart';
// import 'package:dashboard/Widgets/requestWidget.dart';
// import 'package:dashboard/theme.dart';
import 'package:firebaseflutterdemo/Screen/dashboard.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  final pageIndex = Dashboard();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16.0,
      //! ListView
      child: ListView(
        children: [
          //? DrawerHeader Container
          Container(
            child: DrawerHeader(child: Text('')),
          ),
          //* The Menu Containers
          Container(
            child: Column(
              children: [
                // View Request
                Card(
                  color: Orange,
                  child: ListTile(
                    // Leading Is The Icon
                    leading: Icon(
                      Icons.file_copy,
                      size: 28,
                      color: OrangeLight,
                    ),
                    // Title Is The Text
                    title: Text(
                      "View Request",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      pageIndex.pageController.animateToPage(1,
                          duration: Duration(seconds: 1),
                          curve: Curves.bounceIn);
                      Navigator.pop(context);
                    },
                  ),
                ),
                // View All Tutors
                Card(
                  color: Orange,
                  child: ListTile(
                    // Leading Is The Icon
                    leading: Icon(
                      Icons.person,
                      size: 28,
                      color: OrangeLight,
                    ),
                    // Title Is The Text
                    title: Text(
                      "View All Tutors",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                // Send Message
                Card(
                  color: Orange,
                  child: ListTile(
                    // Leading Is the Icon
                    leading: Icon(
                      Icons.message,
                      size: 28,
                      color: OrangeLight,
                    ),
                    // Title Is The Text
                    title: Text(
                      "Send Message",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                // Graph & Stats
                Card(
                  color: Orange,
                  child: ListTile(
                    // Leading Is The Icon
                    leading: Icon(
                      Icons.calculate,
                      size: 28,
                      color: OrangeLight,
                    ),
                    // Title Is The Text
                    title: Text(
                      "Graph and Statistics",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                // Accounts
                Card(
                  color: Orange,
                  child: ListTile(
                    leading: Icon(
                      Icons.account_box,
                      size: 28,
                      color: OrangeLight,
                    ),
                    title: Text(
                      "Accounts",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
