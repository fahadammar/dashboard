import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool isChecked = false;
  bool addNewEmployee = false;
  bool ifError = false;
  User user;

  // Register The User Account Using Email & Password
  registerAccountUsingEmail(email, password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (err) {
      if (err.code == "weak-password") {
        setState(() {
          errorMessage = "Please enter a stronger password";
        });
      } else if (err.code == "email-already-in-use") {
        setState(() {
          errorMessage =
              "This email has already been registered to another account";
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

  // Making An Employee
  onRegisterFormSubmitted() {
    if (formKey.currentState.validate() && ifError == false) {
      formKey.currentState.save();
      this.registerAccountUsingEmail(email, password);
      this.employeeAccess(email, this.access);
      setState(() {
        addNewEmployee = true;
      });
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
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 32.0),
                  child: TextFormField(
                      decoration: const InputDecoration(
                          icon: Icon(Icons.email), labelText: "Email"),
                      validator: this.emailAddressValidator,
                      onSaved: (value) {
                        email = value;
                      })),
              // Password Entry Field
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 32.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.lock), labelText: "Password"),
                    validator: this.passwordValidator,
                    onSaved: (value) {
                      password = value;
                    },
                  )),

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
                          child: Text("$errorMessage",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red))))
                  : Container(),

              addNewEmployee == true && ifError == false
                  ?
                  // Employee Added Msg
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 32.0),
                      child: Center(
                          child: Text("Employee Added",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green))))
                  : Container(),

              // Register Button In Row
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    addNewEmployee == false
                        ?
                        //? Register Button
                        FlatButton(
                            color: Orange,
                            onPressed: onRegisterFormSubmitted,
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Container(),
                    //* Add New Employee Button
                    addNewEmployee == true
                        ? FlatButton(
                            color: Orange,
                            onPressed: () {
                              setState(() {
                                formKey.currentState.reset();
                                isAccept = false;
                                isReject = false;
                                isView = false;
                                isChecked = false;
                                addNewEmployee = false;
                                ifError = false;
                              });
                            },
                            child: Text(
                              'Add New Employee',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
