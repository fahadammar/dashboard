// import 'package:dashboard/Widgets/requestWidget.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  // static final first_id = '/';
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 350,
      child: Text(
        "Hi Iam The Copy Page",
        style: TextStyle(color: Colors.red, fontSize: 50.0),
      ),
    );
  }
}
