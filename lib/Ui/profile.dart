//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/Ui/home.dart';
import '/Ui/login.dart';
import '/View_Model/profile_view_model.dart';
import '/base/base_view.dart';
import '/bottom_bar.dart';
import '/main.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  bool isown;
  Profile({this.isown});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  showLogoutDialogBox(
    BuildContext context,
    String title,
    String content,
  ) {
    // flutter defined function
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(fontSize: 18, color: Color(0xFFC88D67)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            FlatButton(
                child: Text(
                  "Ok",
                  style: TextStyle(fontSize: 18, color: Color(0xFFC88D67)),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Login()));
                }),
          ],
        );
      },
    );
  }

  bool isedit = false;
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
        onModelReady: (model) {},
        builder: (context, model, build) {
          return Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "My Profile",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 45.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                  image: AssetImage('assets/man.jpg'),
                                  fit: BoxFit.cover)),
                        )
                      ],
                    ),
                  ),
                  preferredSize: Size.fromHeight(30.0)),
              backgroundColor: Colors.white,
              elevation: 0.0,
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => MyApp()));
                },
              ),
              title: Text('My account',
                  style: TextStyle(fontSize: 20.0, color: Color(0xFF545D68))),
              actions: <Widget>[
                IconButton(
                  icon:
                      Icon(Icons.power_settings_new, color: Color(0xFFC88D67)),
                  onPressed: () {
                    showLogoutDialogBox(
                        context, 'Logout', 'Are you sure want to logout?');
                  },
                ),
                /*Row(
            mainAxisAlignment:MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("My Profile"),
              Container(
                height: 45.0,
                width: 40.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                        image: AssetImage('assets/man.jpg'),
                        fit: BoxFit.cover
                    )
                ),
              )
            ],
          ),*/
              ],
            ),
            body: FutureBuilder<DocumentSnapshot>(
                future: widget.isown
                    ? FirebaseFirestore.instance
                        .collection('owners')
                        .doc(
                            '${FirebaseAuth.instance.currentUser.uid.toString()}')
                        .get()
                    : FirebaseFirestore.instance
                        .collection('consumers')
                        .doc(
                            '${FirebaseAuth.instance.currentUser.uid.toString()}')
                        .get(),
                builder: (context, snapshot) {
                  var infodocs = snapshot.data.data();
                  return Container(
                    color: Color(0xFFFBFAF8),
                    child: ListView(
                      padding: EdgeInsets.only(left: 20.0, right: 20),
                      children: <Widget>[
                        SizedBox(height: 15.0),
                        TextFormField(
                          enabled: isedit,
                          initialValue: infodocs['name'],
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: "Name",
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          enabled: isedit,
                          initialValue: infodocs['email'],
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: "Email",

                            // hintText:
                            //     '${FirebaseAuth.instance.currentUser.uid.toString()}',
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          enabled: isedit,
                          initialValue: infodocs['password'],
                          style: TextStyle(color: Colors.black),
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: "Password",
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        ),
                        // SizedBox(height: 15.0),
                        // TextFormField(
                        //   style: TextStyle(color: Colors.black),
                        //   keyboardType: TextInputType.number,
                        //   decoration: InputDecoration(
                        //     labelText: "Confirm Password",
                        //     labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                        //   ),
                        // ),

                        SizedBox(height: 15.0),
                        TextFormField(
                          enabled: isedit,
                          initialValue: infodocs['address'],
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: "Address",
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          enabled: isedit,
                          initialValue: infodocs['maps'],
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: "Gmap Link",
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          enabled: isedit,
                          initialValue: infodocs['number'],
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: "Phone",
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          enabled: isedit,
                          initialValue: infodocs['postal'],
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: "Postal code",
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Center(
                            child: GestureDetector(
                          child: Container(
                              width: MediaQuery.of(context).size.width - 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: Color(0xFFF17532)),
                              child: Center(
                                  child: Text(
                                isedit ? 'Done' : 'Edit Profile',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ))),
                          onTap: () {
                            setState(() {
                              isedit = !isedit;
                            });
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => Home()));
                          },
                        )),
                        SizedBox(height: 35.0),
                      ],
                    ),
                  );
                }),
          );
        });
  }
}
