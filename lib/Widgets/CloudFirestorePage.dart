import 'package:firebaseflutterdemo/theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:html' as html;

class CloudFirestorePage extends StatefulWidget {
  CloudFirestorePage({Key key}) : super(key: key);

  @override
  CloudFirestorePageState createState() {
    return new CloudFirestorePageState();
  }
}

class CloudFirestorePageState extends State<CloudFirestorePage> {
  CloudFirestorePageState() : super() {
    // this.getData();
    this.monitorAuthenticationState();
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  void dispose() {
    super.dispose();
    this.getData();
  }

  // Authentication

  FirebaseAuth auth = FirebaseAuth.instance;
  User user;
  monitorAuthenticationState() {
    auth.authStateChanges().listen((User user) {
      if (user != null) {
        print("CloudFirestore: User logged in");
      } else {
        print("CloudFirestore: User logged out");
      }
      setState(() {
        this.user = user;
      });
    });
  }

  // Data

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<dynamic> uid = [];
  List<dynamic> phone = [];
  List<dynamic> fee = [];
  List<dynamic> firstName = [];

  //! GET DATA FUNCTION
  getData() async {
    return firestore
        .collection("pendingTutors")
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .listen((querySnapshot) {
      List<QueryDocumentSnapshot> docSnapshots = querySnapshot.docs;
      docSnapshots.forEach((docSnapshot) {
        Map<String, dynamic> data = docSnapshot.data();
        if (data['uid'] != null) {
          setState(() {
            var tutorID = data['uid'] as String;
            uid.add(tutorID.trim());
            phone.add(data['phone']);
            fee.add(data['fee']);
            firstName.add(data['firstName']);
          });
        } else
          print("Waiting!!");
      });
    });
  }

  acceptTutor(userID) async {
    await firestore
        .collection('pendingTutors')
        .doc(userID)
        .update({'status': 'accepted'});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("View Request"), backgroundColor: Orange),
      // ListView Builder Is In The Body
      body: ListView.builder(
        itemCount: uid.length,
        itemBuilder: (listContext, index) {
          return Container(
            margin: EdgeInsets.all(15.0),
            // width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Left Container
                  Container(
                    width: size.width * 0.7,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // ID
                        Container(
                          // margin: EdgeInsets.only(left: 5.0),
                          // width: 50,
                          width: size.width * 0.1,
                          child: Text(
                            '${uid[index]}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        // Name
                        Container(
                          width: size.width * 0.1,
                          child: Text(
                            '${firstName[index]}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        // Phone
                        Container(
                          width: size.width * 0.2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                '${phone[index]}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12.0),
                              ),
                            ),
                          ),
                        ),

                        // Subject Specialist
                        // Container(
                        //   width: size.width * 0.2,
                        //   child: Text(
                        //     "${doc.subjectName}",
                        //     style: TextStyle(color: Colors.black, fontSize: 12.0),
                        //   ),
                        // ),
                      ],
                    ),
                  ),

                  // Action Buttons
                  Container(
                    width: size.width * 0.2,
                    child: Row(
                      children: [
                        FlatButton(
                          onPressed: () {
                            acceptTutor(uid[index]);
                            dispose();
                            setState(() {
                              print(uid[index]);
                            });
                          },
                          child: Text(
                            "Accept",
                            style:
                                TextStyle(color: Colors.green, fontSize: 18.0),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.green),
                          ),
                        ),
                        // Reject
                        SizedBox(
                          width: 20,
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text(
                            "Reject",
                            style: TextStyle(color: Colors.red, fontSize: 18.0),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red),
                          ),
                        ),
                        // Wait
                        SizedBox(
                          width: 20,
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text(
                            "Wait",
                            style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.yellow),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
