import 'package:flutter/material.dart';
//? External Module
import 'package:firebaseflutterdemo/Screen/dashboard.dart';
//! Firebase
import 'package:firebase_core/firebase_core.dart';
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
    return Dashboard();
  }
}
