import 'dart:convert';
import 'dart:io';

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
  String selectedState = "";
  String selectedCity = "";
  var mapStates = new Map();
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
        body: Builder(builder: (BuildContext context) {
          return Stack(
            children: <Widget>[
              new Image.asset(
                'assets/images/bg.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Container(
                margin: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 42.0),
                child: Card(
                  elevation: 6.0,
                  child: buildForm(context),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Form buildForm(BuildContext context) {
    var gstReg = "([0]{1}[1-9]{1}|[1-2]{1}[0-9]{1}|[3]{1}[0-7]{1})([a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}[zZ]{1}[0-9a-zA-Z]{1})";
    return Form(
      autovalidate: true,
      key: _formKey,
      child: new ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
            child: TextFormField(
              controller: controllerName,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                hintText: 'Enter Name',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                labelText: 'Enter Name',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              keyboardType: TextInputType.text,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp("^[A-Za-z ]+")),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
            child: TextFormField(
              controller: ctrlMobile,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                hintText: 'Mobile No:',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                labelText: 'Mobile No:',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              keyboardType: TextInputType.number,
              maxLength: 10,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
            child: Text('Other Info (Optional)',
                style: TextStyle(fontSize: 16.0, color: Colors.black)),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
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
            margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
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
              keyboardType: TextInputType.text,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp("^[0-9A-Za-z0-9]+")),
                LengthLimitingTextInputFormatter(14),

              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
            child: Text('Address Details (Optional)',
                style: TextStyle(fontSize: 16.0, color: Colors.black)),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
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
            margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
            width: double.infinity,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                child: new DropdownButton<String>(
                  hint: new Text("Select State"),
                  value: selectedState == "" ? null : selectedState,
                  onChanged: (String newValue) {
                    setState(() {
                      selectedState = newValue;
                      selectedCity = "";
                    });
                    callGetCities(newValue);
                  },
                  items: mapStates.keys.map((state) {
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
            margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
            width: double.infinity,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                child: new DropdownButton<String>(
                  hint: new Text("Select City"),
                  value: selectedCity == "" ? null : selectedCity,
                  onChanged: (String newValue) {
                    print("Printing Changed City $newValue");
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
            margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
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
              maxLength: 6,
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
                  if (controllerName.text.length < 2) {
                    s(context, "Customer name should be atleast two letters");
                  } else if (ctrlMobile.text.length != 10) {
                    s(context, "Mobile should be 10 Digits");
                  } else if (ctrlMail.text.length > 0 &&
                      !isEmail(ctrlMail.text)) {
                    s(context, "Please enter a valid email id");
                  }  else if (ctrlAddress.text.length > 35) {
                    s(context, "Address should not cross 35 characters");
                  } else if (ctrlCity.text.length > 15) {
                    s(context, "City should not cross 15 characters");
                  } else if (ctrlState.text.length > 15) {
                    s(context, "State should not cross 15 characters");
                  } else {
                    checkIfCustomerExists(context);
                  }
                },
                color: primarycolor,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
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
    );
  }

  checkIfCustomerExists(BuildContext context) async {
    /*
customer_name
contact_number
email
gst_number
address*/

    print("Mobile ${ctrlMobile.text}");

    showloader(context);
    var uri = new Uri.http("18.191.190.195", "/billing", {
      "page": "checkCustomerMobile",
      "contact_number": ctrlMobile.text,
    });

    print("Checking If Customer Exists \n $uri");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var responseBody = json.decode(response.body);
      print(responseBody.toString());

      if (responseBody["response"].toString().compareTo("Mobile_Registered") ==
          0) {
        print(
            "Customer Already Exists");

        removeloader();
        showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Alert!'),
                content:
                    new Text('Customer Already Exists for this Mobile Number'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      createCustomer(context);
                      Navigator.of(context).pop();
                    },
                    child: new Text('Ok'),
                  ),
                ],
              ),
        );
      } else {
        print("Customer Mobile Not REgisted calling create ");
        createCustomer(context);
        s(context, "Creating Customer");
      }
    } else {
      // If that call was not successful, throw an error.
      print("Failed to load post, Network Error");
      throw Exception('Failed to load post, Network Error');
    }
  }

  Future<void> createCustomer(BuildContext context) async {
    var uri = new Uri.http("18.191.190.195", "/billing", {
      "page": "createCustomer",
      "customer_name": controllerName.text,
      "mobile_number": ctrlMobile.text,
      "email_id": ctrlMail.text,
      "gst_number": ctrlGST.text,
      "city": selectedCity,
      "state": selectedState,
      "pincode": ctrlPincode.text
    });

    print("Printing Create Customer URI \n $uri");
    final response = await http.get(uri);

    removeloader();
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var responseBody = json.decode(response.body);
      print(responseBody.toString());

      if (responseBody["response"].toString().compareTo("success") == 0) {
        s(
            context,
            "Customer Created as " +
                controllerName.text +
                " with Mobile " +
                ctrlMobile.text);
        controllerName.clear();
        ctrlMobile.clear();
        ctrlMail.clear();
        ctrlGST.clear();
        ctrlAddress.clear();
        ctrlState.clear();
        ctrlCity.clear();
        ctrlPincode.clear();
      } else {
        s(context,
            "Failed Adding Customer, Please Retry!");
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post, Network Error');
    }

    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => Customers()));
  }

  callGetStates() async {
    try {
      var statesMap = await getStates();
      setState(() {
        print("Steeting state of States after returning");
        mapStates = statesMap;
      });
    } catch (e) {
      // print(e);
    }
  }

  void callGetCities(String newState) async {
    try {
      showloader(context);
      print("call get cities \n ${cities.toString()}");

      // cities.clear();
      var stateId = mapStates[newState];
      print("Call Get Citites for $newState with Id: $stateId");

      List citiesList = await getCitiesUtils(stateId);
      removeloader();

      setState(() {
        print("Steeting state of States after returning");
        cities = citiesList;

        print("After get cities \n ${cities.toString()}");
      });
    } catch (e) {
      print(e);
    }
  }
}

class UserTest {
  const UserTest(this.name);

  final String name;
}
