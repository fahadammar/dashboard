import 'package:firebaseflutterdemo/Widgets/CircularImage.dart';
import 'package:firebaseflutterdemo/theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//****************************************************/
//*  In this widget the rejected tutors are shown    //
//*  they can be accepted from here                  //
//!--------------------------------------------------//

class RejectedTutorsList extends StatefulWidget {
  @override
  _RejectedTutorsListState createState() => _RejectedTutorsListState();
}

class _RejectedTutorsListState extends State<RejectedTutorsList> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<dynamic> uid = [];
  List<dynamic> phone = [];
  List<dynamic> subjectSpecialist = [];
  List<dynamic> firstName = [];

  //* GET DATA FUNCTION - Get Tutors Rejected
  getData() {
    return firestore
        .collection("pendingTutors")
        .where('status', isEqualTo: 'rejected')
        .snapshots()
        .listen((querySnapshot) {
      uid = [];
      phone = [];
      subjectSpecialist = [];
      firstName = [];
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
          });
        } else
          print("Waiting!!");
      });
    });
  }

  //? Accept Tutors - Change Status To Accepted
  acceptedTutor(userID) async {
    await firestore
        .collection('pendingTutors')
        .doc(userID)
        .update({'status': 'accepted'});
    await this.getData();
    setState(() {
      print("state Setted In Accpet Tutor");
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Rejected Tutors"), backgroundColor: Orange),
      body: uid.length == 0
          ? Center(
              child: FlatButton(
                onPressed: () async {
                  await this.getData();
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Show Rejected Tutors",
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
                                  '${firstName[index]}',
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
                                  "Multan Public School Road, Northern Bypass, Model Town, Devslope, Flutter Developer, RFA For Short",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12.0),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Action Button Accept Tutor
                        Container(
                          width: size.width * 0.2,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 150,
                              ),
                              FlatButton(
                                onPressed: () {
                                  this.acceptedTutor(uid[index]);
                                  // dispose();

                                  print(uid[index]);
                                },
                                child: Text(
                                  "Accept",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 18.0),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.green),
                                ),
                              ),
                              // Reject
                              /*SizedBox(
                                width: 20,
                              ),
                              FlatButton(
                                onPressed: () {},
                                child: Text(
                                  "Reject",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 18.0),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red),
                                ),
                              ),*/
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
