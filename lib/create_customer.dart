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

String superState = "", superCity = "";
List<String> listStates = new List();
List<String> listCities = new List();

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

  String city = "";
  String state = "Tap to Select State";
  bool stateSelected = false;
  bool citySelected = false;

  String selectedState = "";
  String selectedCity = "";
  var mapStates = new Map();
  var cities = new List();

  var mapStatesToId;

  TextEditingController controllerName = new TextEditingController();
  TextEditingController ctrlMobile = new TextEditingController();
  TextEditingController ctrlMail = new TextEditingController();
  TextEditingController ctrlGST = new TextEditingController();
  TextEditingController ctrlAddress = new TextEditingController();
  TextEditingController ctrlPincode = new TextEditingController();

  @override
  void initState() {
    super.initState();

    initEverything();
  }

  void initEverything() async {

    mapStatesToId = await getStates();
    listStates = mapStatesToId.keys.toList();
    setState(() {});
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
//    var gstReg = "([0]{1}[1-9]{1}|[1-2]{1}[0-9]{1}|[3]{1}[0-7]{1})([a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}[zZ]{1}[0-9a-zA-Z]{1})";
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
          GestureDetector(
            onTap: () => dialogForState(listStates),
            child: Container(
              margin: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'State',
                        style: TextStyle(fontSize: 16.0, color: Colors.grey),
                      )),
                  Container(
                    child: Text(
                      state,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (stateSelected) {
                dialogForCity();
              } else {
                s(context, "Please Select State To Filter Cities");
              }
            },
            child: Container(
              margin: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'City',
                        style: TextStyle(fontSize: 16.0, color: Colors.grey),
                      )),
                  Container(
                    child: Text(
                      city,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
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
                  } else if (ctrlAddress.text.length > 35) {
                    s(context, "Address should not cross 35 characters");
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
        print("Customer Already Exists");

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
      "state": superState,
      "city": superCity,
      "pincode": ctrlPincode.text
    });



    print("Printing Create Customer URI \n $uri");
    final response = await http.get(uri, headers: {"Accept": "application/json"});

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
        ctrlPincode.clear();
      } else {
        s(context, "Failed Adding Customer, Please Retry!");
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

  dialogForCity() async {
    var stateID = mapStatesToId[superState];
    print("States ${mapStatesToId.toString()} \n StateID $stateID}");

    showloader(context);
    listCities = await getCitiesUtils(stateID);

    removeloader();
    print("after ge cities ${listCities.toString()}");
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SearchDialogWidget(false, listCities),
            ));
    print("Returned $superCity ");

    city = superCity;
    setState(() {});
  }

  dialogForState(List<String> listValuesString) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SearchDialogWidget(true, listValuesString),
            ));

    print("Returned State $superState ");
    state = superState;
    setState(() {
      city = "Tap To Select City";
      stateSelected = true;
    });

    dialogForCity();
  }
}

class SearchDialogWidget extends StatefulWidget {
  final List<String> listStrings;
  final bool isStateSearch;

  SearchDialogWidget(this.isStateSearch, this.listStrings);

  @override
  _SearchDialogWidgetState createState() => _SearchDialogWidgetState();
}

class _SearchDialogWidgetState extends State<SearchDialogWidget> {
  TextEditingController controllerSearch = new TextEditingController();
  FocusNode focusNodeSearch = new FocusNode();
  List<String> finalList = new List();

  String stringSearch = "";

  @override
  void initState() {
    if (widget.isStateSearch) {
      stringSearch = 'Search State';
    } else {
      stringSearch = 'Search City';
    }

    controllerSearch.addListener(searchListener);
    focusNodeSearch.addListener(searchListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.all(7.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(7.0)),
          hintText: stringSearch,
          hintStyle: TextStyle(color: Colors.white, fontSize: 18.0),
          labelText: stringSearch,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
        ),
        keyboardType: TextInputType.text,
        autofocus: true,
        controller: controllerSearch,
        focusNode: focusNodeSearch,
      ),
      Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print(
                    "Lsit Tapped ${finalList[index]} and \nfinal list ${finalList.toString()}");

                if (widget.isStateSearch) {
                  superState = finalList[index];
                } else {
                  superCity = finalList[index];
                }

                Navigator.pop(context);
                /** dont assign the selected value to controller before this;
                 *  makes index value unusable after tapping*/
                controllerSearch.text = finalList[index];
                setState(() {});
              },
              child: new ListTile(title: new Text(finalList[index])),
            );
          },
          itemCount: finalList.length,
          shrinkWrap: true,
        ),
      ),
    ]);
  }

  void searchListener() {
    if (controllerSearch.text.isEmpty) {
      finalList = widget.listStrings;
    } else {
      List<String> searchList = new List();
      widget.listStrings.forEach((string) {
        if (string
            .toLowerCase()
            .contains(controllerSearch.text.toLowerCase())) {
          searchList.add(string);
        }
      });

      finalList = searchList;
    }
    setState(() {});
  }
}
