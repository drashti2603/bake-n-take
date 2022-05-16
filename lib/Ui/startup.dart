// ignore_for_file: prefer_const_constructors

import 'package:test1/Ui/login.dart';

import '/Ui/home.dart';
import '/Ui/home_page.dart';
import '/Ui/signup.dart';
import '/View_Model/profile_view_model.dart';
import '/base/base_view.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class RoleSelection extends StatefulWidget {
  @override
  _RoleSelectionState createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
        onModelReady: (model) {},
        builder: (context, model, build) {
          return SafeArea(
            child: Scaffold(
              body: Container(
                margin: EdgeInsets.only(top: 100),
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  padding: EdgeInsets.only(left: 20.0, right: 20),
                  children: <Widget>[
                    Center(
                      child: InkWell(
                        child: Text(
                          "Select your Role",
                          style: TextStyle(
                              color: Color(0xFFC88D67),
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => SignUp()));
                        },
                      ),
                    ),
                    Center(
                        child: GestureDetector(
                      child: Container(
                          width: MediaQuery.of(context).size.width - 50.0,
                          height: 50.0,
                          margin: EdgeInsets.only(top: 100),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Color(0xFFF17532)),
                          child: Center(
                              child: Text(
                            'Shop Owner',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Login(
                                  isOwn: true,
                                )));
                      },
                    )),
                    Center(
                        child: GestureDetector(
                      child: Container(
                          width: MediaQuery.of(context).size.width - 50.0,
                          height: 50.0,
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Color(0xFFF17532)),
                          child: Center(
                              child: Text(
                            'Consumer',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Login(
                                  isOwn: false,
                                )));
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
