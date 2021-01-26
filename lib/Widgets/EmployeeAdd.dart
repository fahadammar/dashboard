import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutterdemo/Widgets/textFormField.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class EmployeeAdd extends StatefulWidget {
  @override
  _EmployeeAddState createState() => _EmployeeAddState();
}

class _EmployeeAddState extends State<EmployeeAdd> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String errorMessage = "";
  String email;
  String password;
  String access;
  bool isAccept = false;
  bool isReject = false;
  bool isView = false;
  bool isAll = false;
  bool isChecked = false;
  bool addNewEmployee = false;
  bool ifError = false;
  User user;

  // Register The User Account Using Email & Password
  registerAccountUsingEmail(email, password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      this.employeeAccess(email, this.access);
      setState(() {
        addNewEmployee = true;
      });
    } on FirebaseAuthException catch (err) {
      if (err.code == "weak-password") {
        setState(() {
          errorMessage = "Please enter a stronger password";
        });
      } else if (err.code == "email-already-in-use") {
        setState(() {
          errorMessage =
              "This email has already been registered to an employee account";
          ifError = true;
          addNewEmployee = true;
        });
      }
    } catch (err) {
      // other errors
      print(err);
    }
  }

  //* Employee Access View - Accept - Reject
  employeeAccess(email, access) {
    return firestore
        .collection('Employees')
        .add({'email': email, 'access': access})
        .then((value) =>
            print("$value - Then Executed In EmployeeAccess Function"))
        .catchError((onError) => print("Failed To Add user $onError"));
  }

  // Email Address Validator - to validate the entered email
  String emailAddressValidator(String email) {
    if (!email.contains("@")) {
      return "Please enter a valid email";
    }
    return null;
  }

  // Password Length Validator
  String passwordValidator(String password) {
    if (password.length < 5) {
      return "Password must be at least 5 characters";
    } else if (password.length > 25) {
      return "Password must be at most 25 characters";
    }
    return null;
  }

  // Functions on saved
  emailOnSaved(dynamic value) {
    this.email = value;
  }

  passwordOnSaved(dynamic value) {
    this.password = value;
  }

  // Making An Employee
  onRegisterFormSubmitted() {
    if (formKey.currentState.validate() && ifError == false) {
      formKey.currentState.save();
      // print('${checkEmailExistance(email)}');
      this.registerAccountUsingEmail(email, password);
    }
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Title
            Center(
              child: Text(
                "Add Employee",
                style: TextStyle(
                    color: Orange, fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            // Email Entry Field
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 32.0),
                child: TextInput(
                  textInput: TextInputType.emailAddress,
                  fieldIcon: Icon(Icons.email),
                  passTrue: false,
                  textOfLabel: "E-mail",
                  onSubmit: this.emailOnSaved,
                  validator: this.emailAddressValidator,
                ),
              ),
            ),
            // Password Entry Field
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 32.0),
                child: TextInput(
                  textInput: TextInputType.visiblePassword,
                  passTrue: true,
                  fieldIcon: Icon(Icons.lock),
                  textOfLabel: "Password",
                  onSubmit: this.passwordOnSaved,
                  validator: this.passwordValidator,
                ),
              ),
            ),

            // CheckBoxes
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 32.0),
              child: Column(
                children: [
                  isChecked == false && isAccept == false ||
                          isChecked == true && isAccept == true
                      ?
                      //? Accept Tutor
                      CheckboxListTile(
                          title: Text("Accept Tutors"),
                          value: isAccept,
                          onChanged: (bool value) {
                            setState(() {
                              isAccept = value;
                              isChecked = value;
                              this.access = "accept";
                            });
                          },
                          activeColor: Orange,
                          checkColor: Colors.white,
                        )
                      : Container(),
                  isChecked == false && isReject == false ||
                          isChecked == true && isReject == true
                      ?
                      //! Reject Tutor
                      CheckboxListTile(
                          title: Text("Reject Tutors"),
                          value: isReject,
                          onChanged: (bool value) {
                            setState(() {
                              isReject = value;
                              isChecked = value;
                              this.access = "reject";
                            });
                          },
                          activeColor: Orange,
                          checkColor: Colors.white,
                        )
                      : Container(),
                  isChecked == false && isView == false ||
                          isChecked == true && isView == true
                      ?
                      //* View Tutor
                      CheckboxListTile(
                          title: Text("View Tutors"),
                          value: isView,
                          onChanged: (bool value) {
                            setState(() {
                              isView = value;
                              isChecked = value;
                              this.access = "view";
                            });
                          },
                          activeColor: Orange,
                          checkColor: Colors.white,
                        )
                      : Container(),
                  isChecked == false && isAll == false ||
                          isChecked == true && isAll == true
                      ?
                      //* View Tutor
                      CheckboxListTile(
                          title: Text("Accept & Reject Tutors"),
                          value: isAll,
                          onChanged: (bool value) {
                            setState(() {
                              isAll = value;
                              isChecked = value;
                              this.access = "ar";
                            });
                          },
                          activeColor: Orange,
                          checkColor: Colors.white,
                        )
                      : Container(),
                ],
              ),
            ),

            ifError == true
                ?
                // Error Message
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 32.0),
                    child: Center(
                      child: Text(
                        "$errorMessage",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  )
                : Container(),

            addNewEmployee == true && ifError == false
                ?
                // Employee Added Msg
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 32.0),
                    child: Center(
                      child: Text(
                        "Employee Added",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.green),
                      ),
                    ),
                  )
                : Container(),

            //* Register Button In Row
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  addNewEmployee == false
                      ?
                      //? Register Button
                      Container(
                          width: 120,
                          height: 50,
                          child: FlatButton(
                            color: Orange,
                            onPressed: onRegisterFormSubmitted,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.lightGreen),
                            ),
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : Container(),

                  //* Add New Employee Button
                  addNewEmployee == true
                      ? Container(
                          width: 130,
                          height: 60,
                          child: FlatButton(
                            color: Orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.lightGreen),
                            ),
                            onPressed: () {
                              setState(() {
                                formKey.currentState.reset();
                                isAccept = false;
                                isReject = false;
                                isView = false;
                                isChecked = false;
                                isAll = false;
                                addNewEmployee = false;
                                ifError = false;
                              });
                            },
                            child: Text(
                              'Add New Employee',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
