import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:m3_billing_nts/products.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'colorspage.dart';
import 'utils.dart';

class CreateItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    CreateItemState createItemState() => new CreateItemState();
    return createItemState();
  }
}

class CreateItemState extends State<CreateItem> {
  String startdate = '';
  String endate = '';
  var itemAvailableStartDate;

  var sharedPreferences;

  TextEditingController itemName = new TextEditingController();
  TextEditingController itemUnitCost = new TextEditingController();
  TextEditingController itemUnits = new TextEditingController();
  TextEditingController cntrlTax = new TextEditingController();

  @override
  void initState() {
    super.initState();

    getPrefs();
  }

  Future selectDate(int selectedvalue, BuildContext context) async {
    if (selectedvalue == 2 && startdate == '') {
      s(context, "Please select Start Date Before End Date");
    } else {
      DateTime picked;
      if (selectedvalue == 1) {
        picked = await showDatePicker(
            context: context,
            initialDate: new DateTime.now(),
            firstDate: new DateTime(2016),
            lastDate: new DateTime(2044));

        if (picked != null) {
          setState(() =>
              startdate = '${picked.day}- ${picked.month} - ${picked.year}');
          print(startdate);
        }

        itemAvailableStartDate = picked;
      } else {
        picked = await showDatePicker(
            context: context,
            initialDate: new DateTime.now(),
            firstDate: itemAvailableStartDate,
            lastDate: new DateTime(2044));

        if (picked != null) {
          setState(
              () => endate = '${picked.day}- ${picked.month} - ${picked.year}');
          print(endate);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
          fontFamily: 'Georgia',
          primaryColor: Colors.black,
          accentColor: Colors.black,
          hintColor: Colors.black),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Create Item'),
          backgroundColor: secondarycolor,
          leading: new IconButton(
              iconSize: 18.0,
              icon: new Icon(FontAwesomeIcons.chevronLeft),
              onPressed: () {
                createItem(context);
              }),
        ),
        body: Stack(
          children: <Widget>[
            new Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            new Center(
              child: Column(
                //   height: 580.0,

                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    //   height: 570.0,
                    margin:
                    EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    child: Card(
                      elevation: 6.0,
                      child: Builder(
                          builder: (context) => buildColumn(context)),
                    ),
                  )                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column buildColumn(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
          child: TextFormField(
            controller: itemName,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              hintText: 'Enter Item Name',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              labelText: 'Item Name',
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
            controller: itemUnitCost,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              hintText: 'Enter Unit Cost',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              labelText: 'Unit Cost',
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
          margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
          child: TextFormField(
            controller: itemUnits,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              hintText: 'Enter No of units',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              labelText: 'No of units',
              labelStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(5),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: Text(
            'Start Date : ',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(5.0),
                    border: new Border.all(color: Colors.black)),
                child: Text(
                  startdate == '' ? 'DD/MM/YYYY' : startdate,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                selectDate(1, context);
              },
              child: Container(
                padding: EdgeInsets.only(
                    left: 4.0, right: 8.0, top: 8.0, bottom: 8.0),
                margin: EdgeInsets.only(top: 10.0, right: 10.0),
                child: Icon(FontAwesomeIcons.calendar),
              ),
            ),
          ],
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: Text(
            'End Date : ',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(5.0),
                    border: new Border.all(color: Colors.black)),
                child: Text(
                  endate == '' ? 'DD/MM/YYYY' : endate,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                selectDate(2, context);
              },
              child: Container(
                padding: EdgeInsets.only(
                    left: 4.0, right: 8.0, top: 8.0, bottom: 8.0),
                margin: EdgeInsets.only(top: 10.0, right: 10.0),
                child: Icon(FontAwesomeIcons.calendar),
              ),
            ),
          ],
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: Text(
            'Other Details (Optional) ',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: Text(
            'TAX',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: TextFormField(
            controller: cntrlTax,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              hintText: 'Enter Tax',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              labelText: 'Enter Tax',
              labelStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(3),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 16.0, left: 10.0, right: 10.0),
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: new BoxConstraints(minWidth: 250.0),
            child: new RaisedButton(
              onPressed: () {
                createItem(context);
              },
              color: primarycolor,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              child: new Text('Create Item',
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

  void createItem(BuildContext context) async {
    // item_name
// unit_cost
// no_of_units
// start_date
// end_date
// tax

    if (itemName.text.isEmpty) {
      s(context, "Please Enter Item Name");
    } else if (itemUnitCost.text.isEmpty) {
      s(context, "Please Enter Cost for ${itemName.text}");
    } else if (itemUnits.text.isEmpty) {
      s(context, "Please Number of Units available for the item");
    } else if (startdate == '' || endate == '' || startdate.isEmpty || endate
        .isEmpty) {
      s(context, "Please Enter correct dates");
    } else {
      var userMobile = sharedPreferences.get(CURRENT_USER);

      print("Before Creating Item User from Prefs $userMobile");

      if (userMobile != null) {
        var uri = Uri.http(authority, unencodedPath, {
          "page": "createItem",
          "seller": userMobile,
          "item_name":
          itemName.text,
          "unit_cost": itemUnitCost.text,
          "no_of_units": itemUnitCost.text,
          "start_date": startdate,
          "end_date": endate,
          "tax": cntrlTax.text == '' ? "0" : cntrlTax.text
        });

        d(uri);
        http.Response htResponse = await http.get(uri);

        if (htResponse.statusCode == 200) {
          // If the call to the server was successful, parse the JSON
          var decodedBody = json.decode(htResponse.body);
          print("decoded body \t" + decodedBody.toString());
          if (decodedBody['response'].toString().compareTo("success") == 0) {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => Products()));
          } else {
            print("Failed Creating Item ");
          }
        } else {
          print("Network Error: ${htResponse.statusCode} --- ${htResponse
              .reasonPhrase} ");
          s(context, "Network Error: ${htResponse.statusCode} --- ${htResponse
              .reasonPhrase} ");
        }
      } else {
        print("Failed User Fetching from Prefs");
      }
    }
  }

  void getPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
