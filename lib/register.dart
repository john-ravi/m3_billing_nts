import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'colorspage.dart';
import 'main.dart';
import 'otp.dart';
import 'user.dart';
import 'utils.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    RegisterState myAppState() => new RegisterState();
    return myAppState();
  }
}

class RegisterState extends State<Register> {
  TextEditingController businessname = new TextEditingController();
  TextEditingController mobile = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController aadharcard = new TextEditingController();

  TextEditingController username = new TextEditingController();
  User user;

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(
            fontFamily: 'Georgia',
            primaryColor: Colors.black,
            accentColor: Colors.black,
            hintColor: Colors.black),
        home: new Scaffold(body: new Builder(
          builder: (BuildContext context) {
            return new Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  child: new Image.asset(
                    'assets/images/bg.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                ListView(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      alignment: Alignment(0.0, -1.0),
                      child: new Image.asset(
                        'assets/images/logo.png',
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: buildCenter(context),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                      child: Text.rich(
                        TextSpan(
                          children: const <TextSpan>[
                            TextSpan(
                                text:
                                    'By clicking REGISTER you are applicable to ',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            TextSpan(
                                text: 'TERMS OF US',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        )));
  }

  Center buildCenter(BuildContext context) {
    return Center(
                      child: SizedBox(
                          height: 500.0,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                //      height: 480.0,
                                child: Card(
                                  elevation: 6.0,
                                  child: ListView(
                                    children: <Widget>[
                                      new Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(top: 10.0),
                                        child: new Text(
                                          'BUSINESS DETAILS',
                                          style: TextStyle(
                                              fontSize: 25.0,
                                              color: secondarycolor),
                                        ),
                                      ),
                                      new Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(top: 5.0),
                                        child: new Text(
                                          'Appears On All Invoices',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0,
                                              color: Colors.black),
                                        ),
                                      ),
                                      new ListTile(
                                        leading: const Icon(
                                          Icons.person,
                                          color: secondarycolor,
                                        ),
                                        title: new TextFormField(
                                          decoration: new InputDecoration(
                                            hintText:
                                                'Please Enter Business Name',
                                            hintStyle: TextStyle(),
                                            labelText:
                                                'Enter Your Business Name',
                                            labelStyle: TextStyle(),
                                          ),
                                          keyboardType: TextInputType.text,
                                          controller: businessname,
                                        ),
                                      ),
                                      new ListTile(
                                        leading: const Icon(
                                          Icons.person,
                                          color: secondarycolor,
                                        ),
                                        title: new TextFormField(
                                          decoration: new InputDecoration(
                                            hintText:
                                                'Please Enter Your Name',
                                            hintStyle: TextStyle(),
                                            labelText: 'Enter Your Name',
                                            labelStyle: TextStyle(),
                                          ),
                                          keyboardType: TextInputType.text,
                                          controller: username,
                                        ),
                                      ),
                                      new ListTile(
                                        leading: const Icon(
                                          Icons.phone,
                                          color: secondarycolor,
                                        ),
                                        title: new TextFormField(
                                          decoration: new InputDecoration(
                                            hintText:
                                                'Please Enter Mobile Number',
                                            hintStyle: TextStyle(),
                                            labelText:
                                                '10 Digits Mobile No Requried',
                                            labelStyle: TextStyle(),
                                          ),
                                          keyboardType: TextInputType.number,
                                          controller: mobile,
                                          maxLength: 10,
                                          inputFormatters: [
                                            WhitelistingTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                10),
                                          ],
                                        ),
                                      ),
                                      new ListTile(
                                        leading: const Icon(
                                          Icons.email,
                                          color: secondarycolor,
                                        ),
                                        title: new TextFormField(
                                          decoration: new InputDecoration(
                                            hintText: 'Please Enter Email',
                                            hintStyle: TextStyle(),
                                            labelText:
                                                'Enter Your Email Address',
                                            labelStyle: TextStyle(),
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: email,
                                        ),
                                      ),
                                      new ListTile(
                                        leading: const Icon(
                                          Icons.lock,
                                          color: secondarycolor,
                                        ),
                                        title: new TextFormField(
                                          decoration: new InputDecoration(
                                            hintText:
                                                'Create Password (Min 6 & Max 8)',
                                            hintStyle: TextStyle(),
                                            labelText: 'Enter Your Password',
                                            labelStyle: TextStyle(),
                                          ),
                                          keyboardType: TextInputType.text,
                                          obscureText: true,
                                          controller: password,
                                        ),
                                      ),
                                      new ListTile(
                                        leading: const Icon(
                                          Icons.credit_card,
                                          color: secondarycolor,
                                        ),
                                        title: Container(
                                          child: new TextFormField(
                                            decoration: new InputDecoration(
                                              hintText:
                                                  'Please Enter Aadhar Card Number',
                                              hintStyle: TextStyle(),
                                              labelText:
                                                  'Enter Your Aadhar Card Number',
                                              labelStyle: TextStyle(),
                                            ),
                                            keyboardType:
                                                TextInputType.number,
                                            controller: aadharcard,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        child: ConstrainedBox(
                                          constraints: new BoxConstraints(
                                              minWidth: 250.0),
                                          child: new RaisedButton(
                                            onPressed: () {
                                              onPressed(context);
                                            },
                                            color: primarycolor,
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        30.0)),
                                            child: new Text('REGISTER',
                                                style: new TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                'ALREADY A USER ? ',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    new MaterialPageRoute(
                                                        builder: (context) =>
                                                            new MyApp()));
                                              },
                                              child: Container(
                                                child: Text(
                                                  'LOGIN',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: secondarycolor),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    );
  }

  void onPressed(BuildContext context) {
    print("OnREgisterCLicked");
    if (businessname.text.isEmpty) {
      s(context, 'Enter The Business Name');
    } else if (username.text.isEmpty) {
      s(context, 'Enter Your Name');
    } else if (mobile.text.isEmpty) {
      s(context, 'Enter The Mobile Number');
    } else if (mobile.text.length != 10) {
      s(context, 'Please enter 10 digit Mobile Number');
    } else if (email.text.isEmpty) {
      s(context, 'Enter The Email Id');
    } else if (!isEmail(email.text)) {
      s(context, 'Please Check The Email Id');
    } else if (password.text.isEmpty) {
      s(context, 'Enter The Password');
    } else if (password.text.length < 6) {
      s(context, 'Minimum Length Of The Password Is 6');
    } else if (aadharcard.text.length != 12) {
      s(context, 'Enter The 12 Digit Aadhar Card Number');
    } else {
      showloader(context);

      checkIfMobileRegistered(strQueryMobile: 'checkUser&mobile=${mobile.text}')
          .then((httpResponse) {
        if (httpResponse != null) {
          print("printing hhtp body" + httpResponse.body);
          var numberJsonResponse = json.decode(httpResponse.body);
          print("Printing response " + numberJsonResponse['response']);

          if (numberJsonResponse['response'].toString() !=
              'Mobile_Registered') {
            // user not there

            print("User Not Existing, call create()");
            user = new User(businessname.text, username.text, mobile.text,
                email.text, password.text, aadharcard.text);

            createUserInDB(user, context);
            removeloader();

            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => MobileOTP(user)));
          } else {
            removeloader();

            s(context, "Mobile Number already registered, Please Login");
          }
        } else {
          print("HTTP REsponse was null");
          removeloader();
        }
      });
    }
  }

/*
  void submitPressed() {
    print("OnREgisterCLicked");
    if (businessname.text.isEmpty) {
      s(context, 'Enter The Business Name');
    }  else if (mobile.text.isEmpty) {
      s(context, 'Enter The Mobile Number');
    } else if (mobile.text.length > 10 || mobile.text.length < 10) {
      s(context, 'Please Check The Mobile Number');
    } else if (email.text.isEmpty) {
      s(context, 'Enter The Email Id');
    } else if (!isEmail(email.text)) {
      s(context, 'Please Check The Email Id');
    } else if (password.text.isEmpty) {
      s(context, 'Enter The Password');
    } else if (password.text.length < 6) {
      s(context, 'Minimum Length Of The Password Is 6');
    }  else {
      showloader(context);

      checkIfMobileRegistered(strQueryMobile: 'checkUser&mobile=${mobile.text}')
          .then((httpResponse) {
        if (httpResponse != null) {
          print("printing hhtp body" + httpResponse.body);
          var numberJsonResponse = json.decode(httpResponse.body);
          print("Printing response " + numberJsonResponse['response']);

          if (numberJsonResponse['response'].toString() !=
              'Mobile_Registered') {
            // user not there

            print("User Not Existing, call create()");
            user = new User(businessname.text, username.text, mobile.text,
                email.text, password.text, aadharcard.text);

            createUserInDB(user, context);
            removeloader();

            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Home()));
          } else {
            removeloader();

            s(context, "Mobile Number already registered, Please Login");
          }
        } else {
          print("HTTP REsponse was null");
          removeloader();
        }
      });
    }
  }
*/
}
