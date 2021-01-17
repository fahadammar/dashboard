// import 'package:dashboard/Widgets/requestWidget.dart';
import 'package:firebaseflutterdemo/Widgets/AcceptTutorsList.dart';
import 'package:flutter/material.dart';

class AcceptedTutor extends StatefulWidget {
  // static final first_id = '/';
  @override
  _AcceptedTutorState createState() => _AcceptedTutorState();
}

class _AcceptedTutorState extends State<AcceptedTutor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 350,
      child: AcceptedTutorsList(),
    );
  }
}
