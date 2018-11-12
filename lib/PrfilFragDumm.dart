import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m3_billing_nts/user.dart';
import 'package:m3_billing_nts/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colorspage.dart';
import 'home.dart';

import 'package:http/http.dart' as http;

class ProfileFragmentd extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {
    ProfileFragmentState profileState() => new ProfileFragmentState();
    return profileState();
  }
}

class ProfileFragmentState extends State<ProfileFragmentd> {

  String flatNo, email, street, area, city, pincode = "";

  TextEditingController cntrlFlatNo = new TextEditingController();
  TextEditingController cntrlEmail = new TextEditingController();
  TextEditingController cntrlStreet = new TextEditingController();
  TextEditingController cntrlArea = new TextEditingController();
  TextEditingController cntrlCity = new TextEditingController();
  TextEditingController cntrlPincode = new TextEditingController();

  List listJsonArray;
  User user;


  @override
  void initState() {
    getProfile();
    super.initState();
  }

  void updateAddress(BuildContext context) async {
    String validEmail;
    if (cntrlEmail.text.isNotEmpty) {
      if (!isEmail(cntrlEmail.text)) {
        s(context, "Please Enter a Valid Email");
      } else {
        validEmail = cntrlEmail.text;
      }
    }

    var uri = Uri.http(authority, unencodedPath, {
      "page": "updateProfile",
      "email_id": validEmail.isEmpty ? "" : validEmail,
      "flat_no": cntrlFlatNo.text,
      "street": cntrlStreet.text,
      "area": cntrlArea.text,
      "city": cntrlCity.text,
      "pincode": cntrlPincode.text
    });

    /*

user_id
user_name
email_id
flat_no
street
area
city
pincode
*/

    d(uri);
    http.Response registerUserResponse = await http.get(uri);

    if (registerUserResponse.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var decodedBody = json.decode(registerUserResponse.body);
      print("decoded body \t" + decodedBody.toString());
      if (decodedBody['response'].toString().compareTo("success") == 0) {
        print("Successfully Updated $user");
      } else {
        print("Couldn't fetch User , please check");
      }
    } else {
      print("Please Check Network: ");
    }

    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new Home()));
  }

  getProfile() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = preferences.getString(CURRENT_USER);

    print("USer Id is $userId");
    var uri = Uri.http(
        authority, unencodedPath, {"page": "getMyProfile", "user_id": userId});

    /*
Full texts
user_id
user_name
email_id
mobile_number
user_password
aadhar_card
registration_date*/
    d(uri);
    http.Response registerUserResponse = await http.get(uri);
    List<User> listUser = new List();

    if (registerUserResponse.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var decodedBody = json.decode(registerUserResponse.body);
      if (decodedBody['response'].toString().compareTo("success") == 0) {
        print("decoded body \t" + decodedBody.toString());
        listJsonArray = decodedBody["body"];

        print("List \t" + listJsonArray.toString());

        listJsonArray.forEach((rowUser) {
          print("ROW \t" + rowUser.toString());
          listUser.add(User.named(
              mobile: rowUser["mobile"],
              email: rowUser["email"],
              username: rowUser["username"],
              flatNo: rowUser["flatNo"],
              street: rowUser["street"],
              area: rowUser["area"],
              city: rowUser["city"],
              pincode: rowUser["pincode"]));
          print("Map as Whiole \t" + listJsonArray.toString());
        });

        setState(() {
          user = listJsonArray[0];
          cntrlPincode.text = user.pincode;
          cntrlCity.text = user.city;
          cntrlArea.text = user.area;
          cntrlStreet.text = user.street;
          cntrlFlatNo.text = user.flatNo;
          cntrlEmail.text = user.email;

        });
        print("My Profile $user");
      } else {
        print("Couldn't fetch rows, please check");
      }
    } else {
      print("Error Fetching States, Check Network: In Utility");
    }
  }


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(fontFamily: 'Georgia'),
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              new Image.asset(
                'assets/images/bg.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: new SizedBox(
                        height: 670.0,
                        child: buildStack(context),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack buildStack(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        height: 650.0,
        margin: EdgeInsets.only(right: 10.0, left: 10.0),
        child: Card(
          elevation: 6.0,
          child: new Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.user,
                      color: secondarycolor,
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'Name',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey),
                              )),
                          Container(
                            child: Text(",",
                     //         user == null ? " " : user.username,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.mobileAlt,
                      color: secondarycolor,
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'Mobile Number',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey),
                              )),
                          Container(
                            child: Text("",
                       //       user == null ? " " : user.mobile,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.envelope,
                      color: secondarycolor,
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey),
                              )),
                          Container(
                            child: TextFormField(
                              controller: cntrlEmail,
                              keyboardType: TextInputType.emailAddress,

                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.home,
                      color: secondarycolor,
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'Flat No',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey),
                              )),
                          Container(
                            child: TextFormField(
                              controller: cntrlFlatNo,
                              keyboardType: TextInputType.text,
                      //        initialValue: user == null ? " " : user.flatNo,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.home,
                      color: secondarycolor,
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'Building & Street Address',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey),
                              )),
                          Container(
                            child: TextFormField(
                              controller: cntrlStreet,
                              keyboardType: TextInputType.text,
                   //           initialValue: user == null ? " " : user.street,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.home,
                      color: secondarycolor,
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'Area',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey),
                              )),
                          Container(
                            child: TextFormField(
                              controller: cntrlArea,
                              keyboardType: TextInputType.text,
                 //             initialValue: user == null ? " " : user.area,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.home,
                      color: secondarycolor,
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'City',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey),
                              )),
                          Container(
                            child: TextFormField(
                              controller: cntrlCity,
                              keyboardType: TextInputType.text,
                        //      initialValue: user == null ? " " : user.city,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.home,
                      color: secondarycolor,
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'Pincode',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey),
                              )),
                          Container(
                            child: TextFormField(
                                controller: cntrlPincode,
                                keyboardType: TextInputType.number,
                       //         initialValue: user == null ? " " : user.pincode,
                                style: TextStyle(fontSize: 16.0),
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(6)
                                ]),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        alignment: Alignment.bottomCenter,
        child: ConstrainedBox(
          constraints: new BoxConstraints(minWidth: 250.0),
          child: new RaisedButton(
            onPressed: () {
              updateAddress(context);
            },
            color: primarycolor,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            child: new Text('UPDATE ADDRESS',
                style: new TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      )
    ]);
  }

}
