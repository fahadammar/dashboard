import 'package:firebaseflutterdemo/Widgets/CircularImage.dart';
import 'package:firebaseflutterdemo/theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmployeeTutorView extends StatefulWidget {
  final access;

  EmployeeTutorView({Key key, this.access}) : super(key: key);

  @override
  EmployeeTutorViewState createState() {
    return new EmployeeTutorViewState();
  }
}

class EmployeeTutorViewState extends State<EmployeeTutorView> {
  EmployeeTutorViewState() : super() {
    // this.getData();
    this.monitorAuthenticationState();
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
  List<dynamic> subjectSpecialist = [];
  List<dynamic> address = [];
  List<dynamic> firstName = [];
  List<dynamic> lastName = [];
  String access = "";

  //! GET DATA FUNCTION
  getData() {
    return firestore
        .collection("pendingTutors")
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .listen((querySnapshot) {
      uid = [];
      phone = [];
      subjectSpecialist = [];
      firstName = [];
      lastName = [];
      address = [];
      List<QueryDocumentSnapshot> docSnapshots = querySnapshot.docs;
      docSnapshots.forEach((docSnapshot) {
        Map<String, dynamic> data = docSnapshot.data();
        if (data['uid'] != null) {
          setState(() {
            var tutorID = data['uid'] as String;
            uid.add(tutorID.trim());
            phone.add(data['phone']);
            subjectSpecialist.add(data['subjectName']);
            firstName.add(data['firstName']);
            lastName.add(data['lastName']);
            address.add(data['address']);
          });
        } else
          print("Waiting!!");
      });
    });
  }

  //* Get The Access Status Of The Tutor
  getAccess() {
    return firestore
        .collection("Employees")
        .where('access')
        .snapshots()
        .listen((querySnapshot) {
      access = '';
      List<QueryDocumentSnapshot> docSnapshots = querySnapshot.docs;
      docSnapshots.forEach((docSnapshot) {
        Map<String, dynamic> data = docSnapshot.data();
        if (data['access'] != null) {
          setState(() {
            access = data['access'] as String;
            print("The Access Is: $access");
          });
        } else
          print("Waiting!! - Error In Employees Collection");
      });
    });
  }

  //? Accept tutor
  acceptTutor(userID) async {
    await firestore
        .collection('tutors')
        .doc(userID)
        .update({'status': 'accepted'});
    await this.getData();
    setState(() {
      print("\nThe Tutor Status Setted To: Accepted");
    });
  }

  //! Reject tutor
  rejectTutor(userID) async {
    await firestore
        .collection('tutors')
        .doc(userID)
        .update({'status': 'rejected'});
    await this.getData();
    setState(() {
      print("\nThe Tutor Status Setted To: Rejected");
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("View Request"),
        backgroundColor: Orange,
      ),
      // ListView Builder Is In The Body
      body: uid.length == 0
          ? Center(
              child: FlatButton(
                onPressed: () async {
                  await this.getData();
                  await this.getAccess();
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Show Tutor Requests",
                    style: TextStyle(color: Orange, fontSize: 25.0),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.green),
                ),
              ),
            )
          : ListView.builder(
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
                        //? Left Container
                        Container(
                          width: size.width * 0.8,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // ID
                              Container(
                                // margin: EdgeInsets.only(left: 5.0),
                                // width: 50,
                                width: size.width * 0.2,
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
                                  '${firstName[index]} ${lastName[index]}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              // Phone
                              Container(
                                width: size.width * 0.1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      '${phone[index]}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),

                              // Subject Specialist
                              Container(
                                width: size.width * 0.1,
                                child: Text(
                                  "${subjectSpecialist[index]}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12.0),
                                ),
                              ),

                              // Circular Image
                              ProfilePic(
                                size: size,
                              ),

                              // Address
                              Container(
                                width: size.width * 0.1,
                                child: Text(
                                  "${address[index]}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12.0),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //* Action Buttons
                        Container(
                          // width: size.width * 0.2,
                          child: Row(
                            children: [
                              access == 'accept' && access != 'view'
                                  ?
                                  // Accept Button
                                  FlatButton(
                                      onPressed: () {
                                        this.acceptTutor(uid[index]);

                                        print(uid[index]);
                                      },
                                      child: Text(
                                        "Accept",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 18.0),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.green),
                                      ),
                                    )
                                  : Container(),

                              // Reject
                              SizedBox(
                                width: 20,
                              ),

                              access == "reject" && access != 'view'
                                  ? FlatButton(
                                      onPressed: () {
                                        this.rejectTutor(uid[index]);
                                        print(uid[index]);
                                      },
                                      child: Text(
                                        "Reject",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 18.0),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.red),
                                      ),
                                    )
                                  : Container(),
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
