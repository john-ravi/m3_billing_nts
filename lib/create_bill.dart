import 'package:flutter/material.dart';
import 'colorspage.dart';
import 'home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateBill extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    CreateBillState createbillState() => new CreateBillState();
    return createbillState();
  }
}

class CreateBillState extends State<CreateBill> {
  String status;
  List<String> statuslist = new List<String>();
  @override
  void initState() {
    super.initState();
    statuslist.addAll(['PAID', 'UNPAID']);
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
          title: Text('Create Bill'),
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
                                    hintText: 'Enter Invoice Number',
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        ),
                                    labelText: 'Enter Invoice Number',
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
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    hintText: 'Enter Amount',
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        ),
                                    labelText: 'Enter Amount',
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        ),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              new Container(
                                padding: EdgeInsets.all(7.0),
                                margin: EdgeInsets.only(
                                    top: 10.0, right: 10.0, left: 10.0),
                                width: double.infinity,
                                decoration: new BoxDecoration(
                                    borderRadius:
                                        new BorderRadius.circular(5.0),
                                    border:
                                        new Border.all(color: Colors.black)),
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    child: new DropdownButton<String>(
                                      isDense: true,
                                      hint: new Text("Select Status"),
                                      value: status,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          status = newValue;
                                        });
                                      },
                                      items: statuslist.map((String map) {
                                        return new DropdownMenuItem<String>(
                                          value: map,
                                          child: new Text(
                                            map,
                                          ),
                                        );
                                      }).toList(),
                                    ),
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
                            child: new Text('CREATE BILL',
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
