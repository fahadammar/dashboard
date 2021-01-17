// import 'package:dashboard/Widgets/requestWidget.dart';
// import 'package:firebaseflutterdemo/Widgets/AcceptTutorsList.dart';
import 'package:firebaseflutterdemo/Widgets/RejectedTutorsList.dart';
import 'package:flutter/material.dart';

class RejectedTutor extends StatefulWidget {
  // static final first_id = '/';
  @override
  _RejectedTutorState createState() => _RejectedTutorState();
}

class _RejectedTutorState extends State<RejectedTutor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 350,
      child: RejectedTutorsList(),
    );
  }
}
