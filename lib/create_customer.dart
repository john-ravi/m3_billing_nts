import 'dart:convert';

import 'package:flutter/material.dart';
import 'colorspage.dart';
import 'home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'utils.dart';
import 'customers.dart';
import 'customer.dart';

import 'appConstants.dart';

class CreateCustomer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    CreateCustomerState createCustomerState() => new CreateCustomerState();
    return createCustomerState();
  }
}

class CreateCustomerState extends State<CreateCustomer> {
  UserTest selectedUser;
  String selectedState;
  List<String> states = new List();
  List<UserTest> users = <UserTest>[
    const UserTest('Foo'),
    const UserTest('Bar')
  ];

  TextEditingController controllerName = new TextEditingController();
  TextEditingController ctrlMobile = new TextEditingController();
  TextEditingController ctrlMail = new TextEditingController();
  TextEditingController ctrlGST = new TextEditingController();
  TextEditingController ctrlAddress = new TextEditingController();
  TextEditingController ctrlCity = new TextEditingController();
  TextEditingController ctrlState = new TextEditingController();
  TextEditingController ctrlPincode = new TextEditingController();

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
          fontFamily: 'Georgia',
          primaryColor: Colors.black,
          accentColor: Colors.black,
          hintColor: Colors.black),
      home: Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          title: Text('Create Customer'),
          backgroundColor: secondarycolor,
          leading: new IconButton(
              iconSize: 18.0,
              icon: new Icon(FontAwesomeIcons.chevronLeft),
              onPressed: () {
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => new Home()));
              }),
        ),
        body: Stack(
          children: <Widget>[
            new Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            buildSingleChildScrollView(context)
          ],
        ),
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollView(BuildContext context) {
    return SingleChildScrollView(
            child: new Center(
              child: SizedBox(
                height: 550.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 540.0,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        elevation: 6.0,
                        margin: EdgeInsets.all(10.0),
                        child: new ListView(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              child: TextFormField(
                                controller: controllerName,
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0)),
                                  hintText: 'Enter Customer Name',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  labelText: 'Enter Customer Name',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              child: TextFormField(
                                controller: ctrlMobile,
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0)),
                                  hintText: 'Enter Contact Number',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  labelText: 'Enter Contact Number',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              child: Text('Other Info (Optional)',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black)),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              child: TextFormField(
                                controller: ctrlMail,
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0)),
                                  hintText: 'Enter Email',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  labelText: 'Enter Email',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              child: TextFormField(
                                controller: ctrlGST,
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0)),
                                  hintText: 'Enter Gst Number',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  labelText: 'Enter Gst Number',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              child: Text('Address Details (Optional)',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black)),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              child: TextFormField(
                                controller: ctrlAddress,
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0)),
                                  hintText: 'Enter Address',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  labelText: 'Enter Address',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              width: double.infinity,

                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1.0, style: BorderStyle.solid),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: new DropdownButton<String>(
                                    hint: new Text("Select State"),
                                    value: selectedState,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        selectedState = newValue;
                                      });
                                    },
                                    items: states.map((String state) {
                                      return new DropdownMenuItem<String>(
                                        value: state,
                                        child: FutureBuilder(
                                            future: callGetStates(),
                                            builder: (context, snapshot) {
                                              return Text(
                                                state,
                                                style: new TextStyle(
                                                    color: Colors.black),
                                              );
                                            }),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              width: double.infinity,

                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1.0, style: BorderStyle.solid),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: new DropdownButton<UserTest>(
                                    hint: new Text("Select City"),
                                    value: selectedUser,
                                    onChanged: (UserTest newValue) {
                                      setState(() {
                                        selectedUser = newValue;
                                      });
                                    },
                                    items: users.map((UserTest user) {
                                      return new DropdownMenuItem<UserTest>(
                                        value: user,
                                        child: FutureBuilder(
                                            future: getCitiesUtils(),
                                            builder: (context, snapshot) {
                                              return Text(
                                                user.name,
                                                style: new TextStyle(
                                                    color: Colors.black),
                                              );
                                            }),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              child: TextFormField(
                                controller: ctrlPincode,
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0)),
                                  hintText: 'Pincode',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  labelText: 'Pincode',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.only(top: 24.0),
                              child: ConstrainedBox(
                                constraints:
                                    new BoxConstraints(minWidth: 250.0),
                                child: new RaisedButton(
                                  onPressed: () {
                                    var name = controllerName.text;
                                    var mobile = controllerName.text;
                                    var email = controllerName.text;
                                    var gstNum = controllerName.text;
                                    var address = controllerName.text;
                                    var city = controllerName.text;
                                    //     var name = controllerName.text;
                                    //     var name = controllerName.text;
                                    if (controllerName.text.length < 2) {
                                      print(
                                          "Customer name should be atleast two letters");
                                    } else if (ctrlMobile.text.length != 10) {
                                      print("Mobile should be 10 Digits");
                                    } else if (ctrlMail.text.length > 0) {
                                      if (!isEmail(ctrlMail.text)) {
                                        print(
                                            "Please enter a valid email id");
                                      }
                                    } else if (ctrlGST.text.length > 0) {
                                      if (!ctrlGST.text.startsWith("GSTIN") ||
                                          !ctrlGST.text.startsWith("gstin")) {
                                        print("GST number starts with GSTIN");
                                      }
                                    } else if (ctrlAddress.text.length < 25) {
                                      print(
                                          "Address should not cross 25 characters");
                                    } else if (ctrlCity.text.length < 15) {
                                      print(
                                          "City should not cross 15 characters");
                                    } else if (ctrlState.text.length != 15) {
                                      print(
                                          "City should not cross 15 characters");
                                    } else {
                                      /*final uri = new Uri.http("18.191.190.195", "/billing", {
                                        "page": "createCustomer",
                                        "customer_name": controllerName.text,
                                        "mobile_number": controllerMobile.text,
                                        "email_id": ,
                                        "gst_number": ,
                                        "city": ,
                                        "state": ,
                                        "pincode":
                                      });
*/
                                      createCustomer();


                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  Customers()));
                                    }
                                  },
                                  color: primarycolor,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                  child: new Text('CREATE CUSTOMER',
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

Future<void>  createCustomer() async {
    String stringToShow;
    var uri = new Uri.http("18.191.190.195", "/billing", {
      "page": "createCustomer",
      "customer_name": "M3 Milk Customer",
      "mobile_number": "55555555",
      "email_id": "tst@tes.co",
      "gst_number": "GSTIN1111111111",
      "city": "3",
      "state": "3",
      "pincode": "534350"
    });

    print("Printing URI \n $uri");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      stringToShow = json.decode(response.body).toString();
      print(stringToShow);

      //   return Post();
//    return Post.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }

  }

  callGetStates() async{

    var statess = await getStates();
    setState(() {
      states = statess;
    });
  }


}

class UserTest {
  const UserTest(this.name);

  final String name;
}
