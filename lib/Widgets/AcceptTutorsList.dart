import 'package:firebaseflutterdemo/Widgets/CircularImage.dart';
import 'package:firebaseflutterdemo/theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//****************************************************/
//*  In this widget the accepted tutors are shown    //
//*  they can be rejected from here                  //
//!--------------------------------------------------//

class AcceptedTutorsList extends StatefulWidget {
  @override
  _AcceptedTutorsListState createState() => _AcceptedTutorsListState();
}

class _AcceptedTutorsListState extends State<AcceptedTutorsList> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<dynamic> uid = [];
  List<dynamic> phone = [];
  List<dynamic> subjectSpecialist = [];
  List<dynamic> address = [];
  List<dynamic> firstName = [];
  List<dynamic> lastName = [];

  //* GET DATA FUNCTION - Get Tutors Accpeted
  getData() {
    return firestore
        .collection("tutors")
        .where('status', isEqualTo: 'accepted')
        .snapshots()
        .listen((querySnapshot) {
      uid = [];
      phone = [];
      subjectSpecialist = [];
      address = [];
      firstName = [];
      lastName = [];
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

  //! Reject Tutors -  Change Status To Rejected
  rejectTutor(userID) async {
    await firestore
        .collection('tutors')
        .doc(userID)
        .update({'status': 'rejected'});
    await this.getData();
    setState(() {
      print("state Setted In Accpet Tutor");
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Accepted Tutors"), backgroundColor: Orange),
      body: uid.length == 0
          ? Center(
              child: FlatButton(
                onPressed: () async {
                  await this.getData();
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Show Accepted Tutors",
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

                        // Action Buttons
                        Container(
                          width: size.width * 0.2,
                          child: Row(
                            children: [
                              // Reject Tutor Button
                              SizedBox(
                                width: 120,
                              ),
                              FlatButton(
                                onPressed: () {
                                  this.rejectTutor(uid[index]);
                                  // dispose();

                                  print(uid[index]);
                                },
                                child: Text(
                                  "Reject",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 18.0),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red),
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
