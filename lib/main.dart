import 'package:firebaseflutterdemo/Screen/Employeedashboard.dart';

import 'package:firebaseflutterdemo/theme.dart';
import 'package:flutter/material.dart';
//? External Module
import 'package:firebaseflutterdemo/Screen/Dashboard.dart';
//! Firebase
import 'package:firebase_core/firebase_core.dart';

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
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 225.0),
          child: Column(
            children: [
              // Login As Admin
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 32.0),
                child: FlatButton(
                    color: Orange,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Dashboard()));
                    },
                    child: Text(
                      "Login As Admin",
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    )),
              ),
              SizedBox(
                height: 30.0,
              ),
              // Login As Employee
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 32.0),
                child: FlatButton(
                    color: Orange,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmployeeDashboard()));
                    },
                    child: Text(
                      "Login As Employee",
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
