import 'package:firebaseflutterdemo/Screen/Employeedashboard.dart';

import 'package:firebaseflutterdemo/theme.dart';
import 'package:flutter/material.dart';
//? External Module
import 'package:firebaseflutterdemo/Screen/Dashboard.dart';
//! Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Screen/Dashboard.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Create the initialization Future outside of `build`:

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginAs.id,
      routes: {
        LoginAs.id: (context) => LoginAs(),
        Dashboard.id: (context) => Dashboard(),
        EmployeeDashboard.id: (context) => EmployeeDashboard()
      },
    );
  }
}

class LoginAs extends StatelessWidget {
  static final id = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tutoring"),
        backgroundColor: Orange,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image Of The Container
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/welcome_tutor.jpg',
                      width: 550,
                      height: 500,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                //! Container - child: Login / Sign Up
                Container(
                  // margin: EdgeInsets.only(top: 50.0),
                  padding: EdgeInsets.all(20.0),
                  width: 500,
                  height: 500,
                  decoration: BoxDecoration(
                    // bg color
                    color: Colors.white,
                    border: Border(
                      left: BorderSide(color: Colors.black38),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  // child of the container
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Login Image
                      ClipRRect(
                        child: Image.asset(
                          'assets/login.jpg',
                          width: 150,
                          height: 150,
                        ),
                      ),

                      SizedBox(
                        height: 5.0,
                      ),
                      //* Login As Admin
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 32.0),
                        child: Container(
                          // padding: EdgeInsets.all(8.0),
                          //* DECORAION of the container
                          decoration: BoxDecoration(
                            color: Orange,
                            border: Border.all(
                              color: OrangeLight,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: FlatButton(
                              // color: Orange,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Dashboard()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                  right: 2.0,
                                  left: 2.0,
                                ),
                                child: Center(
                                  child: Text(
                                    "Login As Admin",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                      // SizedBox
                      SizedBox(
                        height: 30.0,
                      ),
                      //? Login As Employee
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 32.0),
                        child: Container(
                          // padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Orange,
                            border: Border.all(
                              color: OrangeLight,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: FlatButton(
                            // color: Orange,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EmployeeDashboard()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                bottom: 8.0,
                              ),
                              child: Center(
                                child: Text(
                                  "Login As Employee",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //----//
        ],
      ),
    );
  }
}
