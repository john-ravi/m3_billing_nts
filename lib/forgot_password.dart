import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colorspage.dart';
import 'home.dart';

import 'utils.dart';

import 'package:firebase_auth/firebase_auth.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    ForgotPasswordState forgotPasswordState() => new ForgotPasswordState();
    return forgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPassword> {

  var phoneNumber;
  var rawPhoneno;

  Future<String> _message = Future<String>.value('');
  String verificationId;
  String testPhoneNumber;
  BuildContext _scaffoldContext;

bool firePhoneVerified = false;
  bool passwordsMatch;
  final _ScaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController controllerMobileNo = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  TextEditingController controllerRenterPass = new TextEditingController();
  TextEditingController controllerOTP = new TextEditingController();



  // Create the focus node. We will pass it to the TextField below.
  final FocusNode myFocusNode = FocusNode();

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    myFocusNode.dispose();

    super.dispose();
  }

  Future<void> _testVerifyPhoneNumber(BuildContext context) async {
    final PhoneVerificationCompleted verificationCompleted =
        (FirebaseUser user) {
      setState(() {
        firePhoneVerified = true;
        _message =
            Future<String>.value('signInWithPhoneNumber auto succeeded: $user');
        print("signInWithPhoneNumber auto succeeded: $user" + "\nGOING TO JOME PAGE");
        s(context, "Auto verified, press Submit");


      });

     // Navigator.push(context, new MaterialPageRoute(builder: (context) => Home()));

    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        _message = Future<String>.value(
        'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
        print("Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}");
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      // _smsCodeController.text = testSmsCode;
      print("OTP Sent Please Check");
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;

      print("OTP Auto Retrieval failed");
    };

    rawPhoneno = controllerMobileNo.text;
    phoneNumber = "+91" + rawPhoneno;
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 30),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<String> _testSignInWithPhoneNumber(String smsCode, BuildContext context) async {

    FirebaseUser user;

    if (firePhoneVerified) {
      gotoHome();
    } else {

      try {
         user = await _auth.signInWithPhoneNumber(
                verificationId: verificationId,
                smsCode: smsCode,
              );
      } catch (e) {
        print(e);
        print(e);
        s(context, "Please enter Correct otp sent to $phoneNumber");

      }

/*
      currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
*/
      if(user!=null){

        print("Going to Home Screen from _signin");
        gotoHome();
      }
    }
    return '';
  }

  void gotoHome() async{


    changeUserPassword(controllerMobileNo.text, controllerPassword.text);
    showloader(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("billingLoggedIn", true);
    print(prefs.getBool("billingLoggedIn") ?? false);

    prefs.setString("billingCurrentUser", rawPhoneno);
    print(prefs.getString("billingCurrentUser"));

    removeloader();

    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
            new Home()));
  }

  @override
  void initState() {
    print("INITSTATE");
    if (_auth.currentUser() != null) {
      _auth.signOut();
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("Did Change DEpencies");
    myFocusNode.addListener(() {
      print("From Focu Listener");
      if(!myFocusNode.hasFocus){
        print("Foucs LOST");
        if(controllerMobileNo.text.length != 10){
          s(_scaffoldContext, "Please Check Mobile Number");
        } else {
          chackMobileAndSendOTP(_scaffoldContext);
        }
      }
    });    super.didChangeDependencies();
  }

  void chackMobileAndSendOTP(BuildContext context) async{
    await checkIfMobileRegistered(strQueryMobile: 'checkUser&mobile=${controllerMobileNo.text}')
        .then((httpResponse) async{
      if (httpResponse != null) {
        print("printing hhtp body" + httpResponse.body);
        var numberJsonResponse = json.decode(httpResponse.body);
        print("Printing response " + numberJsonResponse['response']);

        if (numberJsonResponse['response'].toString() !=
            'Mobile_Registered') {
          // user not there

          print("User Not Existing, call create()");
          s(context, "This Mobile is not Registered, Please Check the number");

        } else {
          print("User is in Records");
         await _testVerifyPhoneNumber(context);
        }
      } else {
        print("HTTP REsponse was null");
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    print("Build");
    return MaterialApp(
      theme: new ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.black,
          hintColor: Colors.black),
      home: Scaffold(
        key: _ScaffoldKey,
         body: Builder(builder: (context) => buildStack(context)
         ),
      ),
    );
  }

  Stack buildStack(BuildContext context) {
    _scaffoldContext = context;
    return Stack(
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
                 child: SingleChildScrollView(
                   child: new Stack(
                     children: <Widget>[
                       Container(
                         height: 500.00,
                         margin: EdgeInsets.only(right: 10.0, left: 10.0),
                         child: new Card(
                           elevation: 6.0,
                           child: buildListView(context),
                         ),
                       )
                     ],
                   ),
                 ),
               ),
             ),
           ),
         ],
       );
  }

  ListView buildListView(BuildContext context) {
    return ListView(
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
                                 controller: controllerMobileNo,
                                 focusNode: myFocusNode,
                                 autofocus: true,
                                 maxLength: 10,
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
                                 inputFormatters: [
                                   WhitelistingTextInputFormatter.digitsOnly,
                                   LengthLimitingTextInputFormatter(10),
                                 ],
                               ),
                             ),
                             Container(
                               margin: EdgeInsets.only(
                                   top: 10.0, right: 10.0, left: 10.0),
                               child: TextFormField(

                                 controller: controllerOTP,
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
                                 inputFormatters: [
                                   WhitelistingTextInputFormatter.digitsOnly,
                                   LengthLimitingTextInputFormatter(6),
                                 ],
                               ),
                             ),
                             new Container(
                               margin: EdgeInsets.only(
                                   left: 10.0,
                                   right: 10.0,
                                   top: 15.0,
                                   bottom: 15.0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment
                                     .center,mainAxisSize: MainAxisSize.max,
                                 children: <Widget>[
                                   Container(
                                     margin: EdgeInsets.only(
                                         right: 10.0),
                                     child: Icon(
                                       FontAwesomeIcons.spinner,
                                       color: Colors.black,
                                     ),
                                   ),
                                   Text(
                                     'OTP EXPIRES IN 30 SECONDS',
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
                                 controller: controllerPassword,
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
                                 controller: controllerRenterPass,
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
                                       onPressed: () {
                                         _testVerifyPhoneNumber(
                                             context);
                                       },
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
                                         checkBeforeSignIn(context);
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
                         );
  }

  void checkBeforeSignIn(BuildContext context) {
    if (controllerMobileNo.text.length != 10) {
      s(context, "Please Check Mobile Number");
    }
    else if (controllerPassword.text.length < 6) {
      s(context, "Password Should have Minimum 6 Characters/Numbers");
    }
    else if (controllerPassword.text
        .compareTo(
        controllerRenterPass.text) !=
        0) {
      s(context,
          "Passwords Not Match, Please Check");
    } else {
      /** Goto Home page*/
      if(firePhoneVerified) {

        gotoHome();
      } else {

      print(_testSignInWithPhoneNumber(
          controllerOTP.text, context));
      }
    }
  }
  }


