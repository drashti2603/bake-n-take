//@dart=2.9
// ignore_for_file: unused_import

import '/Ui/home.dart';
import '/View_Model/cart_view_model.dart';
import '/base/base_view.dart';
import '/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Cartown extends StatefulWidget {
  /*final assetPath, cookieprice, cookiename;*/

  /*Cartown({this.assetPath, this.cookieprice, this.cookiename});*/

  @override
  _CartownState createState() => _CartownState();
}

class _CartownState extends State<Cartown> {
  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_NNbwJ9tmM0fbxj',
      'amount': 28200,
      'name': 'Shaiq',
      'description': 'Payment',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "ERROR: " + response.code.toString() + " - " + response.message,
      timeInSecForIosWeb: 4,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CartViewModel>(
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
              title: Text('Payments recieved',
                  style: TextStyle(fontSize: 20.0, color: Color(0xFF545D68))),
              actions: <Widget>[
                IconButton(
                  icon:
                      Icon(Icons.notifications_none, color: Color(0xFFF17532)),
                  onPressed: () {},
                ),
              ],
            ),
            body: ListView(children: [
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Row(
                    children: <Widget>[
                      SizedBox(height: 15.0),
                      Hero(
                          tag: 'assets/browniecookies.jpg',
                          child: Image.asset('assets/browniecookies.jpg',
                              height: 90.0, width: 90.0, fit: BoxFit.contain)),
                      SizedBox(width: 20.0),
                      Column(
                        children: <Widget>[
                          Text('Rs. 3.99',
                              style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFF17532))),
                          SizedBox(height: 10.0),
                          Text('brownie cookies',
                              style: TextStyle(
                                  color: Color(0xFF575E67), fontSize: 24.0)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              InkWell(
                  onTap: () {
                    openCheckout();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Container(
                        width: MediaQuery.of(context).size.width - 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Color(0xFFF17532)),
                        child: Center(
                            child: Text('Get Money Into Bank Account',
                                style: TextStyle(
                                    fontFamily: 'nunito',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)))),
                  ))
              /* Center(
                      child: InkWell(
                        child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Color(0xFFF17532)
                            ),
                            child: Center(
                                child: Text('Checkout',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                )
                            )
                        ),
                        onTap: () {
                          openCheckout();
                        },
                      )
                  )*/
            ]),
          );
        });
  }
}
