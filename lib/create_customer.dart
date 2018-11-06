import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m3_billing_nts/list_customer.dart';
import 'colorspage.dart';
import 'home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'utils.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  UserTest selectedUser;
  String selectedState;
  String selectedCity;
  var states = new Map();
  var cities = new List();

  List<String> blankList = new List.filled(1, "");

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

    callGetStates();
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
        key: _scaffoldKey,
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
                  child: Form(
                    autovalidate: true,
                    key: _formKey,
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
                                  borderRadius: BorderRadius.circular(5.0)),
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
                                  borderRadius: BorderRadius.circular(5.0)),
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
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
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
                                  borderRadius: BorderRadius.circular(5.0)),
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
                                  borderRadius: BorderRadius.circular(5.0)),
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
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                            ],
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
                                  borderRadius: BorderRadius.circular(5.0)),
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
                              side: BorderSide(
                                  width: 1.0, style: BorderStyle.solid),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: new DropdownButton<String>(
                                hint: new Text("Select State"),
                                value: selectedState,
                                onChanged: (String newValue) {
                                  setState(() {
                                    cities = blankList;
                                    selectedState = newValue;
                                  });
                                  callGetCities(newValue);
                                },
                                items: states.keys.map((state) {
                                  return new DropdownMenuItem<String>(
                                    value: state,
                                    child: Text(state),
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
                              side: BorderSide(
                                  width: 1.0, style: BorderStyle.solid),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: new DropdownButton<String>(
                                hint: new Text("Select City"),
                                value: selectedCity,
                                onChanged: (String newValue) {
                                  setState(() {
                                    selectedCity = newValue;
                                  });
                                },
                                items: cities.map((city) {
                                  return new DropdownMenuItem<String>(
                                    value: city,
                                    child: Text(city),
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
                                  borderRadius: BorderRadius.circular(5.0)),
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
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(6),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.only(top: 24.0),
                          child: ConstrainedBox(
                            constraints: new BoxConstraints(minWidth: 250.0),
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
                                    print("Please enter a valid email id");
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
                                  print("City should not cross 15 characters");
                                } else if (ctrlState.text.length != 15) {
                                  print("City should not cross 15 characters");
                                } else if (ctrlPincode.text.length != 6) {
                                  print("PINCODE has Six Numbers");
                                } else {
                                  createCustomer().then((_) {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => Customers()));
                                  });
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createCustomer() async {
    String stringToShow;
    var uri = new Uri.http("18.191.190.195", "/billing", {
      "page": "createCustomer",
      "customer_name": controllerName.text,
      "mobile_number": ctrlMobile.text,
      "email_id": ctrlMail.text,
      "gst_number": ctrlGST.text,
      "city": ctrlCity.text,
      "state": ctrlState.text,
      "pincode": ctrlPincode.text
    });

    print("Printing URI \n $uri");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var responseBody = json.decode(response.body);
      print(responseBody.toString());
      
      if(responseBody["response"].toString().compareTo("success") == 0){
        s(_scaffoldKey.currentContext, "Customer Created as " + controllerName.text + " with Mobile " + ctrlMobile.text);
        controllerName.clear();
        ctrlMobile.clear();
        ctrlMail.clear();
        ctrlGST.clear();
        ctrlAddress.clear();
        ctrlState.clear();
        ctrlCity.clear();
        ctrlPincode.clear();
      } else {
        s(_scaffoldKey.currentContext, "Failed Adding Customer, Please Retry!");
      }

      //   return Post();
//    return Post.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  callGetStates() async {
    print("call get States");
    var statesMap = await getStates();
    setState(() {
      print("Steeting state of States after returning");
      states = statesMap;
    });
  }

  void callGetCities(String newState) async {
    showloader(context);

    var stateId = states[newState];
    print("Call Get Citites for $newState with Id: $stateId");

    List citiesList = await getCitiesUtils(stateId);
    setState(() {
      print("Steeting state of States after returning");
      cities = citiesList;
    });
    removeloader();
  }
}

class UserTest {
  const UserTest(this.name);

  final String name;
}
