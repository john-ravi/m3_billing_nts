import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:m3_billing_nts/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'user.dart';

import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;


String commonUrl = "http://149.248.0.189:8080/billing/";
String testingUrl = "http://18.191.190.195/billing/?page=";
String zeroUrl = "http://johnravi.000webhostapp.com/?page=";

String authority = "18.191.190.195";
String unencodedPath = "/billing";

String activeUrl = testingUrl;

OverlayEntry loaderentry;

showloader(BuildContext context) {
  OverlayState loaderstate = Overlay.of(context);
  loaderentry = OverlayEntry(
      builder: (context) => Center(
            child: Container(
              padding: EdgeInsets.all(8.0),
              width: 50.0,
              height: 50.0,
              color: Colors.black45,
              child: CircularProgressIndicator(),
            ),
          ));
  loaderstate.insert(loaderentry);
}

removeloader() {
  loaderentry.remove();
}

Future<bool> isLoggedIn() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getBool('LoggedIn');
}

Future<String> getuserMobile() async {


  return _auth.currentUser().then((fireUser) => fireUser.phoneNumber);
}

Future<String> getuserName() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  return pref.getString('uname');
}

Future<String> getUserEmail() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  return pref.getString('uemail');
}

Future<String> createprefsuser(
    String mobile, String uname, String uemail) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString('uid', mobile);
  await pref.setString('uname', uname);
  await pref.setString('uemail', uemail);
  await pref.setBool('LoggedIn', true);
  print("Pref Created for $mobile");
  return mobile;
}


Future<bool> clearlogin() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.clear();
}

d(var debugvalue) {
  print("$debugvalue");
}

Future<http.Response> getjsondata({String jsonvalue}) async {
  var mainurl = activeUrl + jsonvalue;
  d(mainurl);
  http.Response loginresponse = await http.get(mainurl);
  return loginresponse;
}

Future<http.Response> checkIfMobileRegistered({String strQueryMobile}) async {
  var userUrl = activeUrl + strQueryMobile;
  print("printing before http get $userUrl");
  d(userUrl.trim());
  http.Response userExistsResponse;
  try {
    userExistsResponse = await http.get(userUrl);
  } on Exception catch (e) {
    print("Exception occcured \n $e");
    return null;
  }
  return userExistsResponse;
}

Future<http.Response> checkIfUserRegistered(
    {String strQueryRegistered, String strMobile, String password}) async {
  var userUrl = activeUrl + strQueryRegistered;
  d(userUrl);
  return tryCatchNetwork(userUrl);
}

Future<http.Response> tryCatchNetwork(String userUrl) async {
  http.Response httpResponse;
  try {
    httpResponse = await http.get(userUrl);
  } catch (e) {
    print("Check Network Connection $userUrl");
    return null;
  }

  return httpResponse;
}

void createUserInDB(User user, BuildContext context) async {
  print("Create User");

  /** Creating User in database*/
  await putUserOnDb(user).then((httpResponse) {
    var bodyJson = json.decode(httpResponse.body);
      print(bodyJson.toString());

    switch (json.decode(bodyJson.response)) {
      case "UserCreated":
        {
          print("Success -- User Created on Database");

          break;
        }
      case "FailedUserCreation":
        {
          print("Failed Creation of User on Database, trying again");
          createUserInDB(user, context);
          break;
        }
    }

    createprefsuser(user.mobile, user.username, user.email);
  });
}

Future<http.Response> putUserOnDb(User user) async {
  var uri = Uri.http(authority, unencodedPath, {
    "page": "createRegisteredUser",
    "user_name": user.username.toString(),
    "email_id": user.email.toString(),
    "mobile_number": user.mobile,
    "user_password": user.password,
    "aadhar_card": user.aadharCard
  });

  d(uri);
  http.Response registerUserResponse = await http.get(uri);

  return registerUserResponse;
}

s(BuildContext context, String value) {
  try {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(
      value,
      style: TextStyle(fontFamily: 'Georgia'),
    )));
  } on Exception catch (e) {
    print("printing Exception $e");
  }
}
