import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutterdemo/Screen/AddEmployee.dart';
import 'package:firebaseflutterdemo/Screen/EmployeeTutorRequest.dart';
import 'package:firebaseflutterdemo/Screen/RejectedTutors.dart';
import 'package:firebaseflutterdemo/Screen/TutorRequest.dart';
import 'package:firebaseflutterdemo/Screen/AcceptedTutors.dart';
import 'package:firebaseflutterdemo/Widgets/drawerMenu.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

//! External Modules
// import 'package:EmployeeDashboard/Widgets/leftNav.dart';
// import 'package:EmployeeDashboard/theme.dart';
// import 'package:google_fonts/google_fonts.dart';

class EmployeeDashboard extends StatefulWidget {
  static final id = "/employeedashboard";

  static final EmployeeDashboard _EmployeeDashboard =
      EmployeeDashboard.internal();

  factory EmployeeDashboard() {
    return _EmployeeDashboard;
  }
  EmployeeDashboard.internal();

  PageController pageController = PageController();
  @override
  _EmployeeDashboardState createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  _EmployeeDashboardState() : super() {
    this.monitorAuthenticationState();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  String errorMessage = "";
  String email;
  String password;
  User user;

  // To Check Whether The User Is Logged IN - OUT
  monitorAuthenticationState() {
    auth.authStateChanges().listen((User user) {
      if (user != null) {
        print("Authentication: User logged in");
      } else {
        print("Authentication: User logged out");
      }
      setState(() {
        this.user = user;
      });
    });
  }

  // Login Using Email & Password
  loginUsingEmail(email, password) async {
    if (email == 'fahad.ammar@hotmail.com') {
      setState(() {
        errorMessage = "This Is The Admin's Email";
      });
    } else
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } on FirebaseAuthException catch (err) {
        if (err.code == "user-not-found") {
          setState(() {
            errorMessage =
                "There is no account connected to this email address";
          });
        } else if (err.code == "wrong-password") {
          setState(() {
            errorMessage = "Incorrect password";
          });
        }
      } catch (err) {
        // other errors
        print(err);
      }
  }

  // LogOut - auth.signOut()
  logOut() async {
    await auth.signOut();
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

  onLoginFormSubmitted() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      this.loginUsingEmail(email, password);
    }
  }

  // FormKey
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Dashboard',
      home: Scaffold(
        //? AppBar
        appBar: AppBar(
          title: user == null
              ? ListTile(
                  leading: Icon(
                    Icons.login,
                    color: OrangeLight,
                  ),
                  title: Text(
                    "Sign In As Employee",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                )
              : ListTile(
                  leading: Icon(
                    Icons.dashboard,
                    color: OrangeLight,
                  ),
                  title: Text(
                    "Employee Dashboard",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
          backgroundColor: Colors.black,
        ),
        //* Drawer
        drawer: user == null
            ? Drawer(
                child: Center(
                    child: Text(
                  "Please Sign In",
                  style: TextStyle(fontSize: 30, color: Orange),
                )),
              )
            : DrawerMenu(
                isAdmin: false,
                userLogOut: this.logOut,
              ),
        body: Form(
          key: formKey,
          child: user == null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                      // Error Message
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 32.0),
                          child: Center(
                              child: Text("$errorMessage",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)))),
                      //  Login  Buttons In Row
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 32.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: onLoginFormSubmitted,
                                  child: Text('Login'),
                                ),
                              ]))
                    ])
              : PageView(
                  controller: widget.pageController,
                  children: [EmployeeTutorRequest()],
                ),
        ),
      ),
    );
  }
}
