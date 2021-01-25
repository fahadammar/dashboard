import 'package:firebaseflutterdemo/Screen/Dashboard.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class DrawerMenu extends StatefulWidget {
  Function userLogOut;
  bool isAdmin = true;

  DrawerMenu({this.userLogOut, this.isAdmin});
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  final pageIndex = Dashboard();
  @override
  Widget build(BuildContext context) {
    return widget.isAdmin == true
        ? Drawer(
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
                          leading: Icon(
                            Icons.file_copy,
                            size: 28,
                            color: OrangeLight,
                          ),
                          title: Text(
                            "Tutors Request",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            pageIndex.pageController.animateToPage(0,
                                duration: Duration(seconds: 1),
                                curve: Curves.bounceIn);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      // Accepted Tutors
                      Card(
                        color: Orange,
                        child: ListTile(
                          // Leading Is The Icon
                          leading: Icon(
                            Icons.done,
                            size: 28,
                            color: OrangeLight,
                          ),
                          // Title Is The Text
                          title: Text(
                            "Accepted Tutors",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            pageIndex.pageController.animateToPage(1,
                                duration: Duration(seconds: 1),
                                curve: Curves.bounceIn);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      // Rejected Tutors
                      Card(
                        color: Orange,
                        child: ListTile(
                          // Leading Is the Icon
                          leading: Icon(
                            Icons.close,
                            size: 28,
                            color: OrangeLight,
                          ),
                          // Title Is The Text
                          title: Text(
                            "Rejected Tutors",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            pageIndex.pageController.animateToPage(2,
                                duration: Duration(seconds: 1),
                                curve: Curves.bounceIn);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      //? Add Employee
                      Card(
                        color: Orange,
                        child: ListTile(
                          leading: Icon(
                            Icons.account_box,
                            size: 28,
                            color: OrangeLight,
                          ),
                          title: Text(
                            "Add Employee",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            pageIndex.pageController.animateToPage(3,
                                duration: Duration(seconds: 1),
                                curve: Curves.bounceIn);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      //! Log Out
                      Card(
                        color: Orange,
                        child: ListTile(
                          // Leading Is The Icon
                          leading: Icon(
                            Icons.logout,
                            size: 28,
                            color: OrangeLight,
                          ),
                          // Title Is The Text
                          title: Text(
                            "Log Out",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            widget.userLogOut();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Drawer(
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
                      /*Card(
                        color: Orange,
                        child: ListTile(
                          leading: Icon(
                            Icons.file_copy,
                            size: 28,
                            color: OrangeLight,
                          ),
                          title: Text(
                            "Tutors Request",
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
                      ),*/

                      //! Log Out
                      Card(
                        color: Orange,
                        child: ListTile(
                          // Leading Is The Icon
                          leading: Icon(
                            Icons.logout,
                            size: 28,
                            color: OrangeLight,
                          ),
                          // Title Is The Text
                          title: Text(
                            "Log Out",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            widget.userLogOut();
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
