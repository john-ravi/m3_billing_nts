import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'colorspage.dart';
import 'home.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    ForgotPasswordState forgotPasswordState() => new ForgotPasswordState();
    return forgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.black,
          hintColor: Colors.black),
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              child: new SizedBox(
                child: Center(
                  child:  SingleChildScrollView(
                    child: new Stack(
                      children: <Widget>[
                        Container(
                          height: 400.0,
                          margin: EdgeInsets.only(right: 10.0, left: 10.0),
                          child: new Card(
                            elevation: 6.0,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin:
                                  EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Icon(
                                    FontAwesomeIcons.commentDots,
                                    color: Colors.black,
                                    size: 60.0,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10.0, right: 10.0, left: 10.0),
                                  child: TextFormField(
                                    decoration: new InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(5.0)),
                                      hintText: 'Enter mobile number',
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      labelText: 'Mobile Number',
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10.0, right: 10.0, left: 10.0),
                                  child: TextFormField(
                                    decoration: new InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(5.0)),
                                      hintText: 'Enter otp',
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      labelText: 'OTP',
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                new Container(
                                  margin: EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      top: 15.0,
                                      bottom: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(right: 10.0),
                                        child: Icon(
                                          FontAwesomeIcons.spinner,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'VERIFICATION CODE EXPIRES IN 30 SECONDS',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10.0, right: 10.0, left: 10.0),
                                  child: TextFormField(
                                    decoration: new InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(5.0)),
                                      hintText: 'Enter Password',
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10.0, right: 10.0, left: 10.0),
                                  child: TextFormField(
                                    decoration: new InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(5.0)),
                                      hintText: 'Enter Confirm Password',
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      labelText: 'Confirm Password',
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 7.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: new RaisedButton(
                                          onPressed: () {},
                                          color: primarycolor,
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  30.0)),
                                          child: new Text('RESEND CODE',
                                              style: new TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                              )),
                                        ),
                                      ),
                                      Container(
                                        width: 150.0,
                                        child: new RaisedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (context) =>
                                                    new Home()));
                                          },
                                          color: primarycolor,
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  30.0)),
                                          child: new Text('CONFIRM',
                                              style: new TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
