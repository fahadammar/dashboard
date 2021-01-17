import 'package:firebaseflutterdemo/Widgets/CloudFirestorePage.dart';
import 'package:firebaseflutterdemo/Widgets/EmployeeTutorView.dart';
import 'package:flutter/material.dart';

class EmployeeTutorRequest extends StatefulWidget {
  @override
  _EmployeeTutorRequestState createState() => _EmployeeTutorRequestState();
}

class _EmployeeTutorRequestState extends State<EmployeeTutorRequest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      color: Colors.white54,
      child: EmployeeTutorView(),
    );
  }
}
