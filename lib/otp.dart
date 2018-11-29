import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

gotoHome(context);
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
         phoneNumber: "+91" + widget.user.mobile.trim(),
         timeout: const Duration(seconds: 30),
         verificationCompleted: verificationCompleted,
         verificationFailed: verificationFailed,
         codeSent: codeSent,
         codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
   }

   Future<bool> _testSignInWithPhoneNumber(BuildContext context,
       String smsCode) async {
     showloader(context);
     FirebaseUser user;
     try {
       user = await _auth.signInWithPhoneNumber(
         verificationId: verificationId,
         smsCode: smsCode,
       );
     } catch (e) {
       print(e);
       s(context, "Please enter Correct otp sent to ${widget.user.mobile}");
     }

     removeloader();
/*
     final FirebaseUser currentUser = await _auth.currentUser();
     var name = user.uid == currentUser.uid;

     try {
       assert(name);
     } catch (e) {
       print("Error asert $e");
     }
*/

     otpController.text = '';

     print("Checking uids user that sent sms code \t ${user.uid} and current Auth User Id "
         " ");

     if (user != null) {
       return true;
     } else {
       return false;
     }
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
                        child: Builder(builder: (context) => buildCard(context)),
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

   Card buildCard(BuildContext context) {
     return new Card(
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
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
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
                            buildButtonContainer(context)
                          ],
                        ),
                      );
   }

   Container buildButtonContainer(BuildContext context) {
     return Container(
       margin: EdgeInsets.only(top: 20.0),
       child: Row(
         mainAxisAlignment:
         MainAxisAlignment.spaceAround,
         children: <Widget>[
           Container(
             width: 150.0,
             child: new RaisedButton(
               onPressed: () {

                 _testVerifyPhoneNumber();
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
                 onOtpPressed(context);

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
     );
   }

   void onOtpPressed(BuildContext context) async{
     if(otpController.text.length != 6){
       s(context, "Please enter 6 digit OTP");
     } else {
       print("From OnPressed otp is " + otpController.text + " Code");
       bool smsVerified;
       await _testSignInWithPhoneNumber(context, otpController.text.trim()).then((onValue) {

         smsVerified = onValue;

       });

       if (smsVerified) {

         print("Sms is verified");
         s(context, "Registering using ${widget.user.mobile}");


         gotoHome(context);
       } else {
         print("Sms not verified");
         removeloader();
         s(context,
             "Please enter 6 digit OTP sent to ${widget.user.mobile
                 .trim()}");
       }

     }
   }

   void gotoHome(BuildContext context) async{

     showloader(context);
     await createUserInDB(widget.user, context);

     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setBool(LOGGED_IN, true);
     print(prefs.getBool(LOGGED_IN) ?? false);

     prefs.setString(CURRENT_USER, widget.user.mobile.trim());
     prefs.setString(CURRENT_USER_NAME, widget.user.username.trim());
     prefs.setString(CURRENT_USER_EMAIL, widget.user.email.trim());
     prefs.setString(CURRENT_USER_FLAT_NO, widget.user.flatNo.trim());
     prefs.setString(CURRENT_USER_AREA, widget.user.area.trim());
     prefs.setString(CURRENT_USER_STATE, widget.user.state.trim());
     prefs.setString(CURRENT_USER_CITY, widget.user.city.trim());
     prefs.setString(CURRENT_USER_PINCODE, widget.user.pincode.trim());
     print(prefs.getString(CURRENT_USER));

     removeloader();
     Navigator.push(context, new MaterialPageRoute(builder: (context) => Home()));
   }
}
