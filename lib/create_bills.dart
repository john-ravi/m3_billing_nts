import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m3_billing_nts/customer.dart';
import 'package:m3_billing_nts/customerWithId.dart';
import 'colorspage.dart';
import 'create_customer.dart';
import 'home.dart';
import 'colorspage.dart';
import 'user.dart';
import 'utils.dart';

class CreateBill extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    CreateBillState listcustomerState() => new CreateBillState();
    return listcustomerState();
  }
}

class CreateBillState extends State<CreateBill> {
  String title = "Loading Customers";
  String status;

  List<String> statuslist = new List<String>();

  CustomerWithId selectedCustomer = null;

  List<CustomerWithId> listCustomers = new List();
  List<CustomerWithId> finalCustomers = new List();

  TextEditingController controllerSearch = new TextEditingController();
  FocusNode focusNodeSearch = new FocusNode();

  List<CustomerWithId> _searchList;
  bool _isSearching;

  TextEditingController contrlAmount = new TextEditingController();

  CreateBillState() {
    controllerSearch.addListener(() {
      if (controllerSearch.text.isEmpty) {
        setState(() {
          _isSearching = false;
        });
      } else {
        setState(() {
          _isSearching = true;
        });
      }
    });
  }

  @override
  void initState() {
    statuslist.addAll(['PAID', 'UNPAID']);

    _isSearching = false;
    getCustomersWithId().then((onValue) {
      _searchList = new List();
      print("Listing Customers \n ${onValue.toString()}");
      setState(() {
        title = "Create Bill";
        listCustomers = onValue;
        finalCustomers = listCustomers;
      });
    });

    controllerSearch.addListener(searchListener);
    focusNodeSearch.addListener(() {
      searchListener();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
          fontFamily: 'Georgia',
          primaryColor: Colors.black,
          accentColor: Colors.black,
          hintColor: Colors.black),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          elevation: 0.0,
          title: Text(title),
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
          fit: StackFit.expand,
          children: <Widget>[
            new Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            CustomScrollView(
              slivers: <Widget>[
                new SliverList(
                  delegate: new SliverChildListDelegate(
                    <Widget>[
                      new Container(
                        margin:
                            EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                        child: TextFormField(
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.all(1.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search Customer',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            labelText: 'Search Customer',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          controller: controllerSearch,
                          focusNode: focusNodeSearch,
                        ),
                      ),
                    ],
                  ),
                ),
                buildSliverListDefault(),
              ],
            )
          ],
        ),
      ),
    );
  }

  SliverList buildSliverListDefault() {
    return new SliverList(
      delegate:
          new SliverChildBuilderDelegate((BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedCustomer = finalCustomers[index];
            });
            alertForCreateBill();
          },
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Card(
              elevation: 6.0,
              margin: EdgeInsets.all(4.0),
              child: Column(
                children: <Widget>[
                  Table(
                    children: [
                      TableRow(children: [
                        Container(
                          margin: EdgeInsets.only(top: 25.0, left: 5.0),
                          child: new Text(
                            'Customer Name ',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25.0, left: 5.0),
                          child: new Text(
                            finalCustomers.elementAt(index).customer_name,
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 10.0, left: 5.0, bottom: 25.0),
                          child: new Text(
                            'Mobile Number ',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 10.0, left: 5.0, bottom: 25.0),
                          child: new Text(
                            finalCustomers.elementAt(index).contact_number,
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }, childCount: finalCustomers.length),
    );
  }

  void searchListener() {
    _searchList.clear();
    if (_isSearching != null) {
      var mobile = controllerSearch.text;
      for (int i = 0; i < listCustomers.length; i++) {
        if (listCustomers[i].customer_name.contains(mobile)) {
          _searchList.add(listCustomers[i]);
        }
      }
      finalCustomers = _searchList;
    }
  }

  void alertForCreateBill() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
            title: new Text('Create Bill'),
            content: buildAlertBody(),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => createBillOnCustomer(),
                child: new Text('Yes'),
              ),
            ],
          ),
    );
  }

  Widget buildAlertBody() {
    return Container(
      height: 160.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
            child: Text('${selectedCustomer.customer_name}'),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
            child: TextFormField(
              controller: contrlAmount,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
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
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          new Container(
            padding: EdgeInsets.all(7.0),
            margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
            width: double.infinity,
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(5.0),
                border: new Border.all(color: Colors.black)),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                child: new DropdownButton<String>(
                  isDense: true,
                  hint: new Text("Select Paid Status"),
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
    );
  }

  createBillOnCustomer() {
    var amount = contrlAmount.text;
    if(amount.isEmpty){
      s(context, "Please Enter Bill Amount");
    } else {
      utilsCreateBill(selectedCustomer.id, amount, status);
    }
  }
}
