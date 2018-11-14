import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m3_billing_nts/utils.dart';
import 'colorspage.dart';
import 'home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

BuildContext scaffoldContext;

class CreateCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    CreateCategoryState createCustomerState() => new CreateCategoryState();
    return createCustomerState();
  }
}

class CreateCategoryState extends State<CreateCategory> {
  List<String> listPaidStatus = new List();
  TextEditingController cntrlCategory = new TextEditingController();

  List<String> finalListPaidCategories = new List();

  @override
  void initState() {
    getPaidCategories();
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
          title: Text('Create Catergory'),
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
            Builder(builder: (context) {
              scaffoldContext = context;
              return buildContainer(context);
            })
          ],
        ),
      ),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 6.0,
        margin: EdgeInsets.all(10.0),
        child: buildColumn(context),
      ),
    );
  }

  Column buildColumn(BuildContext context) {
    return new Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
          child: TextFormField(
            controller: cntrlCategory,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              hintText: 'Catergory to Create',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              labelText: 'Catergory to Create',
              labelStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            keyboardType: TextInputType.text,
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp("^[A-Za-z ]+")),
              LengthLimitingTextInputFormatter(10),
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: new BoxConstraints(minWidth: 250.0),
            child: new RaisedButton(
              onPressed: () {
                if (cntrlCategory.text.isEmpty) {
                  s(scaffoldContext, "Please enter Paid Status Category");
                } else {
                  checkPaidCategory();
                }
              },
              color: primarycolor,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              child: new Text('CREATE CATERGORY',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  )),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 36.0, bottom: 16.0),
          child: Text("CATEGORIES",
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              //   Text("${finalListPaidCategories[index]}");
              return Container(
                margin: EdgeInsets.only(top: 10.0, left: 5.0, bottom: 25.0),
                child: new Text(
                  finalListPaidCategories.elementAt(index),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              );
            },
            //   itemCount: finalListPaidCategories.length,
            itemCount: finalListPaidCategories.length,
          ),
        ),
      ],
    );
  }

  void checkPaidCategory() async {
/*
*
Full texts
catergory_name
* */
    showloader(context);
    var uri = new Uri.http("18.191.190.195", "/billing", {
      "page": "checkPaidCategory",
      "catergory_name": cntrlCategory.text.trim()
    });

    print("Check Paid Categories \n $uri");
    final response = await http.get(uri);

    removeloader();

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var responseBody = json.decode(response.body);
      print(responseBody.toString());

      var stringResponse = responseBody["response"].toString();
      if (stringResponse == "Category_Present") {
        showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Alert!'),
                content: new Text('Category Already Exists'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text('Ok'),
                  ),
                ],
              ),
        );
      } else if (stringResponse == "success") {
        s(scaffoldContext, "Created Category");

        getPaidCategories();
      } else {
        s(scaffoldContext, "Failed Creating Category");
      }
    } else {
      // If that call was not successful, throw an error.
      s(scaffoldContext, "Network Error");
    }
  }

  void getPaidCategories() async {
    listPaidStatus.clear();
    var uri = new Uri.http(
        "18.191.190.195", "/billing", {"page": "getPaidCategories"});

    print("getPaidCategories \n $uri");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var responseBody = json.decode(response.body);
      print(responseBody.toString());

      var stringResponse = responseBody["response"].toString();
      if (stringResponse == "success") {
        List rawList = responseBody["body"];
        print("raw List \t ${rawList.toString()}");

        rawList.forEach((rawRow) {
          // catergory_name

          listPaidStatus.add(rawRow["catergory_name"]);
          print("list after this Iteration ${listPaidStatus.toString()}");

          setState(() {
            finalListPaidCategories = listPaidStatus;
          });
        });
      } else {
        s(scaffoldContext, "Failed Creating Category");
      }
    } else {
      // If that call was not successful, throw an error.
      s(scaffoldContext, "Network Error");
    }
  }
}
