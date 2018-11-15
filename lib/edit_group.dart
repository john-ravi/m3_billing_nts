import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m3_billing_nts/model_group.dart';
import 'package:m3_billing_nts/utils.dart';
import 'colorspage.dart';
import 'groups.dart';
import 'package:http/http.dart' as http;

class EditGroup extends StatefulWidget {
 final Group group;

  EditGroup(this.group);

  @override
  State<StatefulWidget> createState() {
    EditGroupState eGroupState() => new EditGroupState();
    return eGroupState();
  }
}

class EditGroupState extends State<EditGroup> {
  TextEditingController cntrlGroupName = new TextEditingController();
  TextEditingController cntrlAddress = new TextEditingController();
  TextEditingController cntrlPinCode = new TextEditingController();
  String selectedState = "";
  String selectedCity = "";
  Map mapStates = new Map();
  var cities = new List();

  @override
  void initState() {
    callGetStates();

    selectedState = widget.group.state;
    selectedCity = widget.group.city;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(fontFamily: 'Georgia'),
      home: Scaffold(
        appBar: new AppBar(
          title: Text('Edit Group'),
          backgroundColor: secondarycolor,
          leading: new IconButton(
              iconSize: 18.0,
              icon: new Icon(FontAwesomeIcons.chevronLeft),
              onPressed: () {
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => new Groups()));
              }),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            new Center(
              child: Builder(
                  builder: (context) => buildSingleChildScrollView(context)),
            )
          ],
        ),
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollView(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 410.0,
        child: Stack(
          children: <Widget>[
            buildContainer(),
            Container(
              alignment: Alignment.bottomCenter,
              child: ConstrainedBox(
                constraints: new BoxConstraints(minWidth: 250.0),
                child: new RaisedButton(
                  onPressed: () {
                    if (cntrlGroupName.text.isEmpty) {
                      s(context, "Please enter Group Name");
                    } else if (cntrlPinCode.text.isNotEmpty &&
                        cntrlPinCode.text.length != 6) {
                      s(context, "Please enter 6 digit pincode");
                    } else {
                  //    createGroup(context);
                    }
                  },
                  color: primarycolor,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  child: new Text('Edit Group',
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void createGroup(BuildContext context) async {
    /*
createGroup

Full texts	
id
state
city
group_name
address
pincode
*/

    showloader(context);

    var uri = new Uri.http("18.191.190.195", "/billing", {
      "page": "createGroup",
      "state": selectedState,
      "city": selectedCity,
      "group_name": cntrlGroupName.text,
      "address": cntrlAddress.text,
      "pincode": cntrlPinCode.text
    });

    print("Printing Create Group URI \n $uri");
    final response = await http.get(uri);

    removeloader();
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var responseBody = json.decode(response.body);
      print(responseBody.toString());

      if (responseBody["response"].toString().compareTo("success") == 0) {
        s(context, "Customer Group  ");
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => new Groups()));
      } else {
        s(context, "Failed Adding Group, Please Retry!");
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Network Error');
    }
  }

  Container buildContainer() {
    return Container(
      height: 400.0,
      child: Card(
        elevation: 6.0,
        margin: EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
              child: TextFormField(
                controller: cntrlGroupName,
                initialValue: widget.group.group_name,
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  hintText: 'Enter Group Name',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: 'Enter Group Name',
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
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
              child: Text('Address Details (Optional)',
                  style: TextStyle(fontSize: 16.0, color: Colors.black)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
              child: TextFormField(
                controller: cntrlAddress,
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
                inputFormatters: [
                  LengthLimitingTextInputFormatter(40),
                ],
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
                controller: cntrlPinCode,

                initialValue: widget.group.pincode,
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
          ],
        ),
      ),
    );
  }

  callGetStates() async {
    try {
      var statesMap = await getStates();
      setState(() {
        print("Steeting state of States after returning");
        mapStates = statesMap;
        selectedState = widget.group.state;

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

        selectedCity = widget.group.city;

        print("After get cities \n ${cities.toString()}");
      });
    } catch (e) {
      print(e);
    }
  }
}
