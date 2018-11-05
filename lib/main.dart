import 'dart:convert';

import 'package:flutter/material.dart';
import 'colorspage.dart';
import 'home.dart';
import 'register.dart';
import 'utils.dart';
import 'forgot_password.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    MyAppState myAppState() => new MyAppState();
    return myAppState();
  }
}

class MyAppState extends State<MyApp> {
  bool manualOverRide = true;

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }

  TextEditingController mobile = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: new ThemeData(
            fontFamily: 'Georgia',
            primaryColor: Colors.black,
            accentColor: Colors.black,
            hintColor: Colors.black),
        home: new Scaffold(body: new Builder(
          builder: (BuildContext context) {
            return SafeArea(
              child: new Stack(
                children: <Widget>[
                  new Image.asset(
                    'assets/images/bg.png',
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
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
                        child: Center(
                          child: SizedBox(
                              height: 400.0,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 380.0,
                                    child: Card(
                                      elevation: 6.0,
                                      child: buildColumn(context),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    child: ConstrainedBox(
                                      constraints:
                                          new BoxConstraints(minWidth: 250.0),
                                      child: new RaisedButton(
                                        onPressed: (){onLoginPressed(context);},
                                        color: primarycolor,
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    30.0)),
                                        child: new Text('LOGIN',
                                            style: new TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                        child: Text.rich(
                          TextSpan(
                            children: const <TextSpan>[
                              TextSpan(
                                  text:
                                      'By clicking LOGIN you are applicable to ',
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
              ),
            );
          },
        )));
  }

  Column buildColumn(BuildContext context) {
    return Column(
                                      children: <Widget>[
                                        new Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(top: 10.0),
                                          child: new Text(
                                            'LOGIN',
                                            style: TextStyle(
                                                fontSize: 25.0,
                                                color: secondarycolor),
                                          ),
                                        ),
                                        new ListTile(
                                          leading: const Icon(
                                            Icons.phone_android,
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
                                            controller: mobile,
                                            keyboardType:
                                                TextInputType.number,
                                          ),
                                        ),
                                        new ListTile(
                                          leading: const Icon(
                                            Icons.lock,
                                            color: secondarycolor,
                                          ),
                                          title: new TextFormField(
                                            decoration: new InputDecoration(
                                              hintText: 'Enter Your Password',
                                              hintStyle: TextStyle(),
                                              labelText:
                                                  'Enter Your Password',
                                              labelStyle: TextStyle(),
                                            ),
                                            controller: password,
                                            keyboardType: TextInputType.text,
                                            obscureText: true,
                                          ),
                                        ),
                                        Container(
                                          width: 140.0,
                                          margin: EdgeInsets.only(
                                              top: 20.0, bottom: 15.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          new ForgotPassword()));
                                            },
                                            child: Center(
                                              child: Text(
                                                "Forgot Password?",
                                                style: TextStyle(
                                                    color: secondarycolor,
                                                    fontSize: 16.0),
                                              ),
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
                                                  'New To M3 ? ',
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
                                                              new Register()));
                                                },
                                                child: Container(
                                                  child: Text(
                                                    'Sign Up',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            secondarycolor),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    );
  }

  void onLoginPressed(BuildContext context) async {
    if (!manualOverRide) {
      if (mobile.text.isEmpty) {
        s(context, 'Enter The Mobile Number');
      } else if (mobile.text.length > 10 || mobile.text.length < 10) {
        s(context, 'Please Check The Mobile Number');
      } else if (password.text.isEmpty) {
        s(context, 'Enter The Password');
      } else if (password.text.length < 6) {
        s(context, 'Minimum Length Of The Password Is 6');
      } else {
        showloader(context);

        await checkIfUserRegistered(
                strQueryRegistered:
                    'checkUserRegistered&mobile=${mobile.text}&password=${password.text}',
                strMobile: mobile.text,
                password: password.text)
            .then((httpResponse) {
          print(httpResponse.body);
          var numberResponse = json.decode(httpResponse.body);
          print("Login Status " + numberResponse['response']);

          removeloader();

          switch (numberResponse['response']) {
            case 'User_Mobile_Absent':
              {
                s(context,
                    "Mobile Number Not Registered, Please Check the number");
                break;
              }
            case 'passwordSuccess':
              {
                s(context, "Logging in");

                gotoHome(context);
                break;
              }
            case 'passwordFailed':
              {
                s(context, "Incorrect Password");
                break;
              }

            default:
              {
                s(context, "Retry, Login Failed");
              }
          }
        });
      }
    } else {
      gotoHome(context);
    }
  }


  void gotoHome(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new Home()));
  }
}

