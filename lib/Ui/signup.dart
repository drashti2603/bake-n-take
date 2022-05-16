//@dart=2.9
// ignore_for_file: prefer_const_constructors

import '/Ui/home.dart';
import '/Ui/login.dart';
import '/View_Model/profile_view_model.dart';
import '/base/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  bool isOwn;
  SignUp({this.isOwn});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final namec = TextEditingController();
  final addressc = TextEditingController();
  final phonec = TextEditingController();
  final mapc = TextEditingController();
  final emailc = TextEditingController();
  final passc = TextEditingController();
  final postc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
        onModelReady: (model) {},
        builder: (context, model, build) {
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color(0xFFF17532),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_back,
                                        color: Colors.white),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 28.0),
                              child: Text(
                                "Sign up For Consumer",
                                style: TextStyle(
                                    color: Color(0xFFC88D67),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 25.0),
                            TextFormField(
                              controller: namec,
                              style: TextStyle(color: Colors.black),
                              validator: (val) {
                                if (val.isEmpty || val.length < 4)
                                  return 'Please return a valid value';
                              },
                              decoration: InputDecoration(
                                labelText: "Name",
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              cursorColor: Color(0xFFC88D67),
                            ),
                            SizedBox(height: 15.0),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              validator: (val) {
                                if (val.isEmpty || val.length < 4)
                                  return 'Please return a valid value';
                              },
                              controller: emailc,
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              cursorColor: Color(0xFFC88D67),
                            ),
                            SizedBox(height: 15.0),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              validator: (val) {
                                if (val.isEmpty || val.length < 4)
                                  return 'Please return a valid value';
                              },
                              controller: passc,
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              cursorColor: Color(0xFFC88D67),
                            ),
                            SizedBox(height: 15.0),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              validator: (val) {
                                if (val.isEmpty || val.length < 4)
                                  return 'Please return a valid value';
                              },
                              controller: passc,
                              decoration: InputDecoration(
                                labelText: "Confirm password",
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              cursorColor: Color(0xFFC88D67),
                            ),
                            SizedBox(height: 15.0),
                            TextFormField(
                              controller: addressc,
                              style: TextStyle(color: Colors.black),
                              validator: (val) {
                                if (val.isEmpty || val.length < 4)
                                  return 'Please return a valid value';
                              },
                              decoration: InputDecoration(
                                labelText: "Address",
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              cursorColor: Color(0xFFC88D67),
                            ),
                            SizedBox(height: 15.0),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              validator: (val) {
                                if (val.isEmpty || val.length < 4)
                                  return 'Please return a valid value';
                              },
                              controller: mapc,
                              decoration: InputDecoration(
                                labelText: "Gmap Link",
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              cursorColor: Color(0xFFC88D67),
                            ),
                            SizedBox(height: 15.0),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              validator: (val) {
                                if (val.isEmpty || val.length < 4)
                                  return 'Please return a valid value';
                              },
                              controller: phonec,
                              decoration: InputDecoration(
                                labelText: "Phone Number",
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              cursorColor: Color(0xFFC88D67),
                            ),
                            SizedBox(height: 15.0),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              validator: (val) {
                                if (val.isEmpty || val.length < 4)
                                  return 'Please return a valid value';
                              },
                              controller: postc,
                              decoration: InputDecoration(
                                labelText: "Postal Code",
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              cursorColor: Color(0xFFC88D67),
                            ),
                            SizedBox(height: 25.0),
                            Center(
                                child: Text(
                              "Do you have an account?",
                              style: TextStyle(color: Color(0xFFC88D67)),
                            )),
                            SizedBox(height: 5.0),
                            Center(
                              child: InkWell(
                                child: Text(
                                  "login",
                                  style: TextStyle(
                                      color: Color(0xFFC88D67),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Login()));
                                },
                              ),
                            ),
                            SizedBox(height: 55.0),
                            Center(
                                child: GestureDetector(
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 50.0,
                                  height: 50.0,
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      color: Color(0xFFF17532)),
                                  child: Center(
                                      child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ))),
                              onTap: () async {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => Login()));

                                if (_formKey.currentState.validate()) {
                                  var i = 1;
                                  _formKey.currentState.save();
                                  print('done doctor uploading');
                                  // ignore: unused_local_variable
                                  UserCredential authResult;
                                  try {
                                    authResult = await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: emailc.text.trim(),
                                            password: passc.text.trim());
                                  } catch (err) {
                                    if (err.message != null) {
                                      print(err.message);
                                      i = 0;
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Error"),
                                              content: Text(err.message),
                                            );
                                          });
                                    }
                                  }
                                  if (i != 0) {
                                    final User user =
                                        FirebaseAuth.instance.currentUser;
                                    final uid = user.uid.toString();
                                    FirebaseFirestore.instance
                                        .collection('consumers')
                                        .doc(uid)
                                        .set({
                                      'name': namec.text.trim(),
                                      'address': addressc.text.trim(),
                                      'number': phonec.text.trim(),
                                      'email': emailc.text.trim(),
                                      'maps': mapc.text.trim(),
                                      'password': passc.text.trim(),
                                      'postal': postc.text.trim(),
                                      'uid': uid
                                    });
                                    print('bldfsdf');
                                    namec.clear();
                                    addressc.clear();
                                    phonec.clear();
                                    emailc.clear();
                                    mapc.clear();
                                    passc.clear();
                                    postc.clear();
                                    FocusScope.of(context).unfocus();
                                  }
                                }
                                ;
                              },
                            )),
                            SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      ),
                    )),
              ),
            ),
          );
        });
  }
}
