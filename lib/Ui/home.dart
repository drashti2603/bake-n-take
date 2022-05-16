//@dart=2.9
import 'package:test1/Ui/cookie_cakeown.dart';
import 'package:test1/Ui/cookie_icecreamown.dart';
import 'package:test1/Ui/cookie_pageown.dart';

import '/View_Model/home_view_model.dart';
import '/base/base_view.dart';
import '/bottom_bar.dart';
import '/Ui/cookie_cake.dart';
import '/Ui/cookie_icecream.dart';
import '/Ui/cookie_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  bool isown;
  Home({this.isown});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        onModelReady: (model) {},
        builder: (context, model, build) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text('Home',
                  style: TextStyle(fontSize: 20.0, color: Color(0xFF545D68))),
              actions: <Widget>[
                IconButton(
                  icon:
                      Icon(Icons.notifications_none, color: Color(0xFFC88D67)),
                  onPressed: () {},
                ),
              ],
            ),
            body: Stack(
//              padding: EdgeInsets.only(left: 20.0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Container(
                      height: MediaQuery.of(context).size.height - 50.0,
                      width: double.infinity,
                      child: TabBarView(controller: _tabController, children: [
                        widget.isown ? CookiePageown() : CookiePage(),
                        widget.isown ? CookieCakeown() : CookieCake(),
                        widget.isown ? CookieIceCreamOwn() : CookieIceCream(),
                      ])),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 42.0, left: 10),
                  child: TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.transparent,
                      labelColor: Color(0xFFC88D67),
                      isScrollable: true,
                      labelPadding: EdgeInsets.only(right: 45.0),
                      unselectedLabelColor: Color(0xFFCDCDCD),
                      tabs: [
                        Tab(
                          child: Text('Cookies',
                              style: TextStyle(
                                fontSize: 21.0,
                              )),
                        ),
                        Tab(
                          child: Text('Cookie cake',
                              style: TextStyle(
                                fontSize: 21.0,
                              )),
                        ),
                        Tab(
                          child: Text('Ice cream',
                              style: TextStyle(
                                fontSize: 21.0,
                              )),
                        )
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 10),
                  child: Text('Categories',
                      style: TextStyle(
                          fontSize: 42.0, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 15.0),
              ],
            ),
          );
        });
  }
}
