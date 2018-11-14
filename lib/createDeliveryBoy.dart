import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m3_billing_nts/utils.dart';
import 'colorspage.dart';
import 'delivery_boys.dart';
import 'package:http/http.dart' as http;

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
  TextEditingController city = new TextEditingController();
  TextEditingController state = new TextEditingController();
  TextEditingController pincode = new TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        builder: (context) => new DeliveryBoy()));
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
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 450.0,
                  child: Builder(builder: (context) => buildStack(context)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Stack buildStack(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 440.0,
          child: Card(
            elevation: 6.0,
            margin: EdgeInsets.all(10.0),
            child: new Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                  child: TextFormField(
                    controller: boyName,
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
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
                  child: TextFormField(
                    controller: city,
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      hintText: 'City',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      labelText: 'City',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                  child: TextFormField(
                    controller: state,
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      hintText: 'State',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      labelText: 'State',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                  child: TextFormField(
                    controller: pincode,
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
                      LengthLimitingTextInputFormatter(6)
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
                //     var name = controllerName.text;
                if (boyName.text.length < 2) {
                  s(context,"Delivery Boy name should be atleast two letters");
                } else if (mobile.text.length != 10) {
                  s(context,"Mobile should be 10 Digits");
                } else if (address.text.length > 0) {
                  if (address.text.length > 50) {
                    s(context,"Address should not exceed 50 characters");
                  }
                } else if (state.text.length > 0) {
                  if (state.text.length > 20) {
                    s(context,"State should not exceed 20 characters");
                  }
                } else if (city.text.length > 0) {
                  if (city.text.length > 20) {
                    s(context,"City should not exceed 20 characters");
                  }
                } else if (pincode.text.length > 0) {
                  if (pincode.text.length != 6) {
                    s(context,"Pincode should be 6 Digits");
                  }
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
        )
      ],
    );
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
      "city": city.text == "" ? " " : city.text,
      "state": state.text == "" ? " " : state.text,
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
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => DeliveryBoy()));

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
        s(context,
            "Delivery Boy Alredy Exists with this Mobile Number");

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
        s(context, "Creating Customer");
      }
    } else {
      // If that call was not successful, throw an error.
      print("Network Error - ${response.reasonPhrase}");
    }
  }
}
