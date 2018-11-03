import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  Future<String> _message = Future<String>.value('');
  String verificationId;
  String testPhoneNumber;
  BuildContext _scaffoldContext;

  bool passwordsMatch;
  final _ScaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController mobileNo = new TextEditingController();
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
        _message =
            Future<String>.value('signInWithPhoneNumber auto succeeded: $user');
        print("signInWithPhoneNumber auto succeeded: $user" + "\nGOING TO JOME PAGE");
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

    var phoneNumber = "+91" + mobileNo.text;
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 7),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<String> _testSignInWithPhoneNumber(String smsCode) async {
    final FirebaseUser user = await _auth.signInWithPhoneNumber(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    if(user.uid == currentUser.uid){
      print("Going to Home Screen from _signin");
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
              new Home()));
    }



    return 'signInWithPhoneNumber succeeded: $user';
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
        if(mobileNo.text.length != 10){
          s(_scaffoldContext, "Please Check Mobile Number");
        } else {
          _testVerifyPhoneNumber(context);
        }
      }
    });    super.didChangeDependencies();
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
                         height: 400.0,
                         margin: EdgeInsets.only(right: 10.0, left: 10.0),
                         child: new Card(
                           elevation: 6.0,
                           child: ListView(
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
                                   controller: mobileNo,
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
                                       .center,
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
       );
  }

  void checkBeforeSignIn(BuildContext context) {
    if(mobileNo.text.length != 10){
      s(context, "Please Check Mobile Number");
    }
    else if(controllerPassword.text.length < 6) {
      s(context, "Password Should have Minimum 6 Characters/Numbers");
    }
    else if (controllerPassword.text
        .compareTo(
        controllerRenterPass.text) !=
        0) {
      s(context,
          "Passwords Not Match, Please Check");
    } else {
      setState(() {
        passwordsMatch = true;
      });

      if (controllerOTP.text != null) {
        print(controllerOTP.text);
        s(context,
            "Please Check The OTP");
      } else {
        print(_testSignInWithPhoneNumber(
            controllerOTP.text));
      }



    }
  }

}
