import 'package:flutter/material.dart';
import 'colorspage.dart';
import 'home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateCustomer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    CreateCustomerState createCustomerState() => new CreateCustomerState();
    return createCustomerState();
  }
}

class CreateCustomerState extends State<CreateCustomer> {
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
            SingleChildScrollView(
              child: new Center(
                child: SizedBox(
                  height: 510.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 500.0,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          elevation: 6.0,
                          margin: EdgeInsets.all(10.0),
                          child: new Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10.0, right: 10.0, left: 10.0),
                                child: TextFormField(
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
                                        fontSize: 16.0,
                                        
                                        color: Colors.black)),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10.0, right: 10.0, left: 10.0),
                                child: TextFormField(
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
                                        fontSize: 16.0,
                                        
                                        color: Colors.black)),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10.0, right: 10.0, left: 10.0),
                                child: TextFormField(
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
                                child: TextFormField(
                                  decoration: new InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    hintText: 'Enter City',
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        ),
                                    labelText: 'Enter City',
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
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    hintText: 'Select State',
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        ),
                                    labelText: 'Select State',
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
                            child: new Text('CREATE CUSTOMER',
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
