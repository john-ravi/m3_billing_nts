import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:m3_billing_nts/model_bills.dart';
import 'package:m3_billing_nts/customer.dart';
import 'package:m3_billing_nts/customerWithId.dart';
import 'package:m3_billing_nts/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'user.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:fluttertoast/fluttertoast.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

String commonUrl = "http://149.248.0.189:8080/billing/";
String testingUrl = "http://18.191.190.195/billing/?page=";
String zeroUrl = "http://johnravi.000webhostapp.com/?page=";

String authority = "18.191.190.195";
String unencodedPath = "/billing";

String activeUrl = testingUrl;

OverlayEntry loaderentry;

const String LOGGED_IN = "billingLoggedIn";
const String CURRENT_USER = "billingCurrentUser";

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

Future<String> getUserMobile() async {
  if (_auth != null) {
    if (_auth.currentUser() != null)
      return _auth.currentUser().then((fireUser) => fireUser.phoneNumber);
  }

  return "";
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
    return httpResponse;
  }

  return httpResponse;
}

void changeUserPassword(String mobile, String password) async {
  print("Change User Password");

  var uri = Uri.http(authority, unencodedPath, {
    "page": "changePassword",
    "mobile_number": mobile,
    "user_password": password
  });

  d(uri);
  http.Response httpChngPaswdRespnse = await http.get(uri);
  var body = json.decode(httpChngPaswdRespnse.body);
  print(body.toString());
  var bodyResponse = json.decode(body);
  if (bodyResponse.toString().compareTo("Password_Changed") == 0) {
    print("Passwrd Changed");
  } else {
    print("Paswrd chnae failed");
  }
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}

void createUserInDB(User user, BuildContext context) async {
  print("Create User");


  /** Creating User in database*/
  await putUserOnDb(user).then((httpResponse) {
    var bodyJson = json.decode(httpResponse.body);
    print(bodyJson.toString());

    switch (bodyJson["response"]) {
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
      duration: Duration(seconds: 5),
        content: new Text(
      value,
      style: TextStyle(fontFamily: 'Georgia'),
    )));
  } on Exception catch (e) {
    print("printing Exception $e");
  }
}

showToast(String msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      textcolor: '#ffffff'
  );
}

void showSnack(String string, GlobalKey<ScaffoldState> keyScaffold) {
  var snackbar = new SnackBar(content: new Text(string));
  keyScaffold.currentState.showSnackBar(snackbar);
}

Future<List<Bills>> getBills() async {
  List<Bills> bills = new List();

  var uri = Uri.http(authority, unencodedPath, {
    "page": "getBills",
  });

  d(uri);
  http.Response registerUserResponse = await http.get(uri);

  if (registerUserResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody = json.decode(registerUserResponse.body);
    if (decodedBody['response'].toString().compareTo("success") == 0) {

      print("decoded body \t" + decodedBody.toString());
      List billsDecoded = decodedBody["body"];

      print("List \t" + bills.toString());

      billsDecoded.forEach((rowCustomerObject) {
        print("ROW \t" + rowCustomerObject.toString());

        Map billsMap = rowCustomerObject;

        print("CustomerMap  ${billsMap.toString()}");
/*
* 
Full texts	
invoice_number
amount
status
customer_name
* */

        bills.add(Bills(billsMap["invoice_number"], billsMap["amount"],
            billsMap["status"], billsMap["customer_name"]));

        print("List as Whiole \t" + bills.toString());
      });

//    return Post.fromJson(json.decode(response.body));
    } else {
      print("Couldn't fetch rows, please check");
    }
  } else {
    print("Error Fetching States, Check Network: In Utility");
  }

  return bills;
}

Future<Map<String, String>> getStates() async {
  var uri = Uri.http(authority, unencodedPath, {
    "page": "getStates",
  });

  d(uri);
  http.Response registerUserResponse = await http.get(uri);

  if (registerUserResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody = json.decode(registerUserResponse.body);
    if (decodedBody['response'].toString().compareTo("success") == 0) {
      Map<String, String> mapStateToId = new Map();

      print("decoded body \t" + decodedBody.toString());
      List statesTableList = decodedBody["body"];

      print("List \t" + statesTableList.toString());

      statesTableList.forEach((row) {
        print("ROW \t" + row.toString());

        mapStateToId[row["state_name"]] = row["state_id"];

        print("Map as Whiole \t" + mapStateToId.toString());
      });
      return mapStateToId;
//    return Post.fromJson(json.decode(response.body));
    } else {
      print("Couldn't fetch rows, please check");
    }
  } else {
    print("Error Fetching States, Check Network: In Utility");
  }

  return null;
}

Future<List<String>> getCitiesUtils(state_id) async {
  var uri = Uri.http(
      authority, unencodedPath, {"page": "getCities", "state_id": state_id});

  d(uri);
  http.Response registerUserResponse = await http.get(uri);
  List<String> listCities = new List();

  if (registerUserResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody = json.decode(registerUserResponse.body);
    if (decodedBody['response'].toString().compareTo("success") == 0) {
      print("decoded body \t" + decodedBody.toString());
      List objectCitiesList = decodedBody["body"];

      print("List \t" + objectCitiesList.toString());

      objectCitiesList.forEach((rowCityObject) {
        print("ROW \t" + rowCityObject.toString());
        listCities.add(rowCityObject["city_name"]);
        print("Map as Whiole \t" + objectCitiesList.toString());
      });
    } else {
      print("Couldn't fetch rows, please check");
    }
  } else {
    print("Error Fetching States, Check Network: In Utility");
  }

  return listCities;
}

Future<List<Customer>> getCustomers() async {
  print("Get Customers Called");
  var uri =
      Uri.http(authority, unencodedPath, {"page": "getCustomersAndMobile"});

  d(uri);
  http.Response registerUserResponse = await http.get(uri);
  List<Customer> listCustomers = new List();

  if (registerUserResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody = json.decode(registerUserResponse.body);
    if (decodedBody['response'].toString().compareTo("success") == 0) {
      print("decoded body \t" + decodedBody.toString());
      List objectCustomersList = decodedBody["body"];

      print("List \t" + objectCustomersList.toString());

      /** FOR EACH */
      objectCustomersList.forEach((rowCustomerObject) {
        print("ROW \t" + rowCustomerObject.toString());

        Map customerMap = rowCustomerObject;

        print("CustomerMap  ${customerMap.toString()}");

        listCustomers.add(new Customer(
            customerMap["customer_name"], customerMap["contact_number"]));

        //      print("List as Whiole \t" + listCustomers.toString());
      });
    } else {
      print("Couldn't fetch rows, please check");
    }
  } else {
    print("Error Fetching States, Check Network: In Utility");
  }

  return listCustomers;
}
Future<List<Customer>> dummy() async {
  print("Get Customers Called");
  var uri =
      Uri.http(authority, unencodedPath, {"page": "getCustomersAndMobile"});

  d(uri);
  http.Response registerUserResponse = await http.get(uri);
  List<Customer> listCustomers = new List();

  if (registerUserResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody = json.decode(registerUserResponse.body);
    if (decodedBody['response'].toString().compareTo("success") == 0) {
      print("decoded body \t" + decodedBody.toString());
      List objectCustomersList = decodedBody["body"];

      print("List \t" + objectCustomersList.toString());

      /** FOR EACH */
      objectCustomersList.forEach((rowCustomerObject) {
        print("ROW \t" + rowCustomerObject.toString());

        Map customerMap = rowCustomerObject;

        print("CustomerMap  ${customerMap.toString()}");

        listCustomers.add(new Customer(
            customerMap["customer_name"], customerMap["contact_number"]));

        //      print("List as Whiole \t" + listCustomers.toString());
      });
    } else {
      print("Couldn't fetch rows, please check");
    }
  } else {
    print("Error Fetching States, Check Network: In Utility");
  }

  return listCustomers;
}

Future<List<CustomerWithId>> getCustomersWithId() async {
  print("Get CustomersWITH ID Called");
  var uri = Uri.http(authority, unencodedPath, {"page": "getCustomers"});

  d(uri);
  http.Response registerUserResponse = await http.get(uri);
  List<CustomerWithId> listCustomers = new List();

  if (registerUserResponse.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var decodedBody = json.decode(registerUserResponse.body);
    if (decodedBody['response'].toString().compareTo("success") == 0) {
      print("decoded body \t" + decodedBody.toString());
      List objectCustomersList = decodedBody["body"];

      print("List \t" + objectCustomersList.toString());

      /** FOR EACH */
      objectCustomersList.forEach((rowCustomerObject) {
        print("ROW \t" + rowCustomerObject.toString());

        Map customerMap = rowCustomerObject;

        print("CustomerMap  ${customerMap.toString()}");

        listCustomers.add(CustomerWithId(customerMap["customer_name"],
            customerMap["contact_number"], customerMap["id"]));

        //      print("List as Whiole \t" + listCustomers.toString());
      });
    } else {
      print("Couldn't fetch rows, please check");
    }
  } else {
    print("Error Fetching States, Check Network: In Utility");
  }
  print("List as Whiole \t" + listCustomers.toString());

  return listCustomers;
}

Future<http.Response> utilsCreateBill(
    String id, String amount, String status) async {
  // id
// invoice_number
// customer_id
// amount
// status

  var uri = Uri.http(authority, unencodedPath, {
    "page": "createBill",
    "customer_id": id,
    "amount": amount,
    "status": status
  });

  d(uri);
  http.Response registerUserResponse = await http.get(uri);

  return registerUserResponse;
}
