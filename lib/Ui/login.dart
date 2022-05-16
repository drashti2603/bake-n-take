//@dart=2.9
import 'package:test1/Ui/home_pageown.dart';
import 'package:test1/Ui/signupown.dart';

import '/Ui/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/Ui/home_page.dart';
import '/Ui/signup.dart';
import '/View_Model/profile_view_model.dart';
import '/base/base_view.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  bool isOwn;
  Login({this.isOwn});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var emailc = TextEditingController();
  var passc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
        onModelReady: (model) {},
        builder: (context, model, build) {
          return SafeArea(
            child: Scaffold(
              body: Container(
                margin: EdgeInsets.only(top: 70),
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  padding: EdgeInsets.only(left: 20.0, right: 20),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Text(
                        "Log in",
                        style: TextStyle(
                            color: Color(0xFFC88D67),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    TextFormField(
                      controller: emailc,
                      validator: (val) {
                        if (val.isEmpty || val.length < 4)
                          return 'Please return a valid value';
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      cursorColor: Color(0xFFC88D67),
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      validator: (val) {
                        if (val.isEmpty || val.length < 4)
                          return 'Please return a valid value';
                      },
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      controller: passc,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      cursorColor: Color(0xFFC88D67),
                    ),
                    SizedBox(height: 35.0),
                    Center(
                        child: Text(
                      "Don't have an account?",
                      style: TextStyle(color: Color(0xFFC88D67)),
                    )),
                    SizedBox(height: 5.0),
                    Center(
                      child: InkWell(
                        child: Text(
                          "create a new account",
                          style: TextStyle(
                              color: Color(0xFFC88D67),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          widget.isOwn
                              ? Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignUpOwn(
                                        isOwn: widget.isOwn,
                                      )))
                              : Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignUp(
                                        isOwn: widget.isOwn,
                                      )));
                        },
                      ),
                    ),
                    SizedBox(height: 55.0),
                    Center(
                        child: GestureDetector(
                      child: Container(
                          width: MediaQuery.of(context).size.width - 50.0,
                          height: 50.0,
                          margin: EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Color(0xFFF17532)),
                          child: Center(
                              child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
                      onTap: () {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: emailc.text.trim(),
                                password: passc.text.trim())
                            .then((result) {
                          if (widget.isOwn) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePageown()),
                              //MaterialPageRoute(builder: (context) => Homepage()),
                            );
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                              //MaterialPageRoute(builder: (context) => Homepage()),
                            );
                          }
                        }).catchError((err) {
                          if (err.message != null) {
                            print(err.message);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(err.message),
                                  );
                                });
                          }
                        });
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => HomePage()),
                        //     );
                      },
                    )),
                    SizedBox(height: 35.0),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
