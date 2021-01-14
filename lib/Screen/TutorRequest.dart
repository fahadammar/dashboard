import 'package:firebaseflutterdemo/Widgets/CloudFirestorePage.dart';
import 'package:flutter/material.dart';

class TutorRequest extends StatefulWidget {
  @override
  _TutorRequestState createState() => _TutorRequestState();
}

class _TutorRequestState extends State<TutorRequest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      color: Colors.white54,
      child: CloudFirestorePage(),
    );
  }
}
