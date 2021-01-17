import 'package:firebaseflutterdemo/Widgets/EmployeeAdd.dart';
import 'package:flutter/material.dart';

class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      color: Colors.white54,
      child: EmployeeAdd(),
    );
  }
}
