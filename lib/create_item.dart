import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'colorspage.dart';
import 'home.dart';

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

  Future selectDate(int selectedvalue) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2044));
    if (picked != null) {
      if (selectedvalue == 1) {
        setState(() => startdate = '${picked.day}/ ${picked.month} / ${picked.year}');
      } else {
        setState(() => endate = '${picked.day}/ ${picked.month} / ${picked.year}');
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
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Home()));
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
              child: SizedBox(
                height: 480.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 450.0,
                      margin:
                          EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                      child: Card(
                        elevation: 6.0,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
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
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
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
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
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
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(
                                  top: 10.0, left: 10.0, right: 10.0),
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
                                    margin: EdgeInsets.only(
                                        top: 10.0, left: 10.0, right: 10.0),
                                    decoration: new BoxDecoration(
                                        borderRadius:
                                            new BorderRadius.circular(5.0),
                                        border: new Border.all(
                                            color: Colors.black)),
                                    child: Text(
                                      startdate == ''
                                          ? 'DD/MM/YYYY'
                                          : startdate,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    selectDate(1);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 4.0,
                                        right: 8.0,
                                        top: 8.0,
                                        bottom: 8.0),
                                    margin:
                                        EdgeInsets.only(top: 10.0, right: 10.0),
                                    child: Icon(FontAwesomeIcons.calendar),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(
                                  top: 10.0, left: 10.0, right: 10.0),
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
                                    margin: EdgeInsets.only(
                                        top: 10.0, left: 10.0, right: 10.0),
                                    decoration: new BoxDecoration(
                                        borderRadius:
                                            new BorderRadius.circular(5.0),
                                        border: new Border.all(
                                            color: Colors.black)),
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
                                    selectDate(2);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 4.0,
                                        right: 8.0,
                                        top: 8.0,
                                        bottom: 8.0),
                                    margin:
                                        EdgeInsets.only(top: 10.0, right: 10.0),
                                    child: Icon(FontAwesomeIcons.calendar),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(
                                  top: 10.0, left: 10.0, right: 10.0),
                              child: Text(
                                'Other Details (Optional) ',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(
                                  top: 10.0, left: 10.0, right: 10.0),
                              child: Text(
                                'TAX',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(
                                  top: 10.0, left: 10.0, right: 10.0),
                              decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.circular(5.0),
                                  border: new Border.all(color: Colors.black)),
                              child: Text(
                                'Select Tax',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    ),
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
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new Home()));
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
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
