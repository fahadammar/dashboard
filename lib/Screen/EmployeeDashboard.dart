import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebaseflutterdemo/Screen/EmployeeTutorRequest.dart';

import 'package:firebaseflutterdemo/Widgets/drawerMenu.dart';
import 'package:firebaseflutterdemo/Widgets/textFormField.dart';
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
        errorMessage = "Use Employee Registered Email";
      });
    } else {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        setState(() {
          errorMessage = '';
        });
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
  }

  // Functions on saved
  emailOnSaved(dynamic value) {
    this.email = value;
  }

  passwordOnSaved(dynamic value) {
    this.password = value;
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
              ? Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Email Entry Field
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 32.0),
                          child: TextInput(
                            textInput: TextInputType.emailAddress,
                            fieldIcon: Icon(Icons.email),
                            passTrue: false,
                            textOfLabel: "E-mail",
                            onSubmit: this.emailOnSaved,
                            validator: this.emailAddressValidator,
                          ),
                        ),
                        // Password Entry Field
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 32.0),
                          child: TextInput(
                            textInput: TextInputType.visiblePassword,
                            passTrue: true,
                            fieldIcon: Icon(Icons.lock),
                            textOfLabel: "Password",
                            onSubmit: this.passwordOnSaved,
                            validator: this.passwordValidator,
                          ),
                        ),
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
                                color: Colors.red,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        //  Login  Buttons In Row
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 32.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 120,
                                height: 50,
                                child: FlatButton(
                                  onPressed: onLoginFormSubmitted,
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Orange),
                                  ),
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                )
              : PageView(
                  controller: widget.pageController,
                  children: [EmployeeTutorRequest()],
                ),
        ),
      ),
    );
  }
}
