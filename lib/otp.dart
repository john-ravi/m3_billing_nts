import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'colorspage.dart';
import 'home.dart';


import './utils.dart';
import './user.dart';

import 'package:firebase_auth/firebase_auth.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;


class MobileOTP extends StatefulWidget {

  final User user;
  MobileOTP(this.user);

  @override
  State<StatefulWidget> createState() {
    MobileOTPState mobileotpState() => new MobileOTPState();
    return mobileotpState();
  }
}

class MobileOTPState extends State<MobileOTP> {
   TextEditingController otpController = new TextEditingController();


   Future<String> _message = Future<String>.value('');
   String verificationId;
   String testPhoneNumber;



   Future<void> _testVerifyPhoneNumber() async {
     final PhoneVerificationCompleted verificationCompleted =
         (FirebaseUser user) {
       setState(() {
         _message =
             Future<String>.value('signInWithPhoneNumber auto succeeded: $user');
         print("signInWithPhoneNumber auto succeeded: $user" + "\nGOING TO JOME PAGE");
       });

       Navigator.push(context, new MaterialPageRoute(builder: (context) => Home()));

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
           print("Code Sent Please check Mobile");
     };

     final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
         (String verificationId) {
       this.verificationId = verificationId;
       // _smsCodeController.text = testSmsCode;
           print("code Auto retrieval failed");
     };

     await _auth.verifyPhoneNumber(
         phoneNumber: "+919948039139",
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

     otpController.text = '';
     return 'signInWithPhoneNumber succeeded: $user';
   }


   void initState() {
     super.initState();

     if(_auth.currentUser() != null){
       _auth.signOut();
     }
     testPhoneNumber = "+91" + widget.user.mobile;
     print(testPhoneNumber);

     _testVerifyPhoneNumber();


   //  WidgetsBinding.instance.addPostFrameCallback((_) => yourFunction(context));
   }


   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        fontFamily: 'Georgia',
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
                  child: new Stack(
                    children: <Widget>[
                      Container(
                        height: 400.0,
                        margin: EdgeInsets.only(right: 10.0, left: 10.0),
                        child: new Card(
                          elevation: 6.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                  controller: otpController,
                                  maxLength: 6,
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
                                child: Text(
                                  'Enter The OTP Below In Case If Failed To Detect The SMS Automatically',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(

                                      fontSize: 12.0,
                                      ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      width: 150.0,
                                      child: new RaisedButton(
                                        onPressed: () {

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
                                          print("From OnPressed otp is "+ otpController.text + " Code");
                                          setState(() {
                                            _message = _testSignInWithPhoneNumber(otpController.text);
                                          });
                                          if(_auth != null){
                                            if(_auth.currentUser() != null){
                                              Navigator.push(context, new MaterialPageRoute(builder: (context) => Home()));
                                            }
                                          }
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
          ],
        ),
      ),
    );
  }
}
