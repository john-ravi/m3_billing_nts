import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m3_billing_nts/utils.dart';
import 'colorspage.dart';
import 'delivery_boys.dart';
import 'package:http/http.dart' as http;

String superState = "", superCity = "";
List<String> listStates = new List();
List<String> listCities = new List();

class CreateDeliveryBoy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    CreateDeliveryBoyState createDeliveryBoyState() =>
        new CreateDeliveryBoyState();
    return createDeliveryBoyState();
  }
}

class CreateDeliveryBoyState extends State<CreateDeliveryBoy> {
  TextEditingController boyName = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController mobile = new TextEditingController();
  TextEditingController pincode = new TextEditingController();

  String city = "";
  String state = "Tap to Select State";
  bool stateSelected = false;
  bool citySelected = false;

  String selectedState = "";
  String selectedCity = "";
  var mapStates = new Map();
  var cities = new List();

  var mapStatesToId;

  GlobalKey<AutoCompleteTextFieldState<String>> keyStates = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> keyCities = new GlobalKey();
  List<String> citiesList = new List();
  List<String> listStates = new List();
  AutoCompleteTextField textFieldStates;
  AutoCompleteTextField textFieldCities;

  @override
  void initState() {
    initEverything();
    super.initState();
  }

  void initEverything() async {
    mapStatesToId = await getStates();
    listStates = mapStatesToId.keys.toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {


    textFieldCities = new AutoCompleteTextField<String>(
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          hintText: "City",
        ),
        key: keyCities,
        submitOnSuggestionTap: true,
        clearOnSubmit: false,
        suggestions: citiesList,
        textInputAction: TextInputAction.go,
        textChanged: (item) {
          city = item;
          print(city);
        },
        textSubmitted: (item) {
          city = item;
          print("submitted city");
        },
        itemBuilder: (context, item) {
          return new Padding(
              padding: EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () {
                    print("Auto Tapped TApped");
                  },
                  child: Text(item)));
        },
        itemSorter: (a, b) {
          return a.compareTo(b);
        },
        itemFilter: (item, query) {
          return item.toLowerCase().contains(query.toLowerCase());
        });

    return new MaterialApp(
      theme: ThemeData(fontFamily: 'Georgia'),
      home: Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          title: Text('Create Delivery Boy'),
          backgroundColor: secondarycolor,
          leading: new IconButton(
              iconSize: 18.0,
              icon: new Icon(FontAwesomeIcons.chevronLeft),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new DeliveryBoys()));
              }),
        ),
        body: Stack(
          //    fit: StackFit.expand,
          children: <Widget>[
            new Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Column(
              children: <Widget>[
                Expanded(
                  child: Card(
                      elevation: 6.0,
                      margin: EdgeInsets.all(10.0),
                      child: Builder(
                          builder: (context) => buildListView(context))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ListView buildListView(BuildContext context) {
    return new ListView(
      shrinkWrap: true,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
          child: TextFormField(
            controller: boyName,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              hintText: 'Enter Delivery Boy Name',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              labelText: 'Enter Delivery Boy Name',
              labelStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            keyboardType: TextInputType.text,
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp("^[A-Za-z ]+")),
              LengthLimitingTextInputFormatter(25),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
          child: TextFormField(
            controller: mobile,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
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
            maxLength: 10,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10)
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
          child: Text('Assign to Group (Optional)',
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  color: secondarycolor)),
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
            controller: address,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
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
                    state ?? "",
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
                    city ?? "",
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
            controller: pincode,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
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
              LengthLimitingTextInputFormatter(6)
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 24.0),
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: new BoxConstraints(minWidth: 250.0),
            child: new RaisedButton(
              onPressed: () {
                if (boyName.text.length < 2) {
                  s(context, "Delivery Boy name should be atleast two letters");
                } else if (mobile.text.length != 10) {
                  s(context, "Mobile should be 10 Digits");
                } else if (address.text.isNotEmpty &&
                    address.text.length > 50) {
                  s(context, "Address should not exceed 50 characters");
                } else if (state.isNotEmpty && state.length > 20) {
                  s(context, "State should not exceed 20 characters");
                } else if (city.isNotEmpty && city.length > 20) {
                  s(context, "City should not exceed 20 characters");
                } else if (pincode.text.isNotEmpty &&
                    pincode.text.length != 6) {
                  s(context, "Pincode should be 6 Digits");
                } else {
                  checkIfBoyExists(context);
                }
              },
              color: primarycolor,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              child: new Text('Create Delivery Boy',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  )),
            ),
          ),
        ),
      ],
    );
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

  void createDeliveryBoy(BuildContext context) async {
    /*

Full texts
id
boy_name
contact_number
available_status
address
city
state
pincode*/

    var uri = new Uri.http("18.191.190.195", "/billing", {
      "page": "createDeliveryBoy",
      "boy_name": boyName.text,
      "available_status": "available",
      "contact_number": mobile.text,
      "address": address.text == "" ? " " : address.text,
      "city": city == "" ? " " : city,
      "state": state == "" ? " " : state,
      "pincode": pincode.text.isEmpty ? " " : pincode.text
    });

    showloader(context);
    print("Printing Create boy_name URI \n $uri");
    final response = await http.get(uri);

    removeloader();

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var responseBody = json.decode(response.body);
      print(responseBody.toString());

      if (responseBody["response"].toString().compareTo("success") == 0) {
        s(context, "Delivery Boy ${boyName.text} created");
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => DeliveryBoys()));
      } else {
        s(context, "Failed Adding Delivery Boy, Please Retry!");
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Network Error ${response.reasonPhrase}');
    }
  }

  void checkIfBoyExists(BuildContext context) async {
    showloader(context);
    var uri = new Uri.http("18.191.190.195", "/billing", {
      "page": "checkDeliveryBoy",
      "contact_number": mobile.text,
    });

    print("Checking If Delivery Boy Exists \n $uri");
    final response = await http.get(uri);
    removeloader();

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var responseBody = json.decode(response.body);
      print(responseBody.toString());

      if (responseBody["response"].toString().compareTo("Mobile_Registered") ==
          0) {
        s(context, "Delivery Boy Alredy Exists with this Mobile Number");

        showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Alert!'),
                content: new Text(
                    'Delivery Boy Alredy Exists with this Mobile Number'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text('OK'),
                  ),
                ],
              ),
        );
      } else {
        print("Delivery Boy Mobile Not REgisted calling create ");
        createDeliveryBoy(context);
        s(context, "Creating Delivery Boy");
      }
    } else {
      // If that call was not successful, throw an error.
      print("Network Error - ${response.reasonPhrase}");
    }
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
