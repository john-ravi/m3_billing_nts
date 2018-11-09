import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m3_billing_nts/customer.dart';
import 'colorspage.dart';
import 'create_customer.dart';
import 'home.dart';
import 'colorspage.dart';
import 'user.dart';
import 'utils.dart';

class Customers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    ListCustomerState listcustomerState() => new ListCustomerState();
    return listcustomerState();
  }
}

class ListCustomerState extends State<Customers> {
  String title = "Loading Customers";

  List<Customer> listCustomers = new List();
  List<Customer> finalCustomers = new List();

  TextEditingController controllerSearch = new TextEditingController();
  FocusNode focusNodeSearch = new FocusNode();

  List<Customer> _searchList;
  bool _isSearching;

  ListCustomerState() {
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
    _isSearching = false;
    getCustomers().then((onValue) {
      _searchList = new List();
      print("Listing Customers \n ${onValue.toString()}");
      setState(() {
        title = "Customers";
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
        floatingActionButton: FloatingActionButton(
          child: new Icon(Icons.add),
          backgroundColor: secondarycolor,
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new CreateCustomer()));
          },
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
                            hintText: 'Search Customer mobile',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            labelText: 'Search Customer mobile',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          controller: controllerSearch,
                          focusNode: focusNodeSearch,
                        ),
                      ),
                    ],
                  ),
                ),
                buildSliverListDefault(),
              ],
            ),
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
        if (listCustomers[i].contact_number.contains(mobile)) {
          _searchList.add(listCustomers[i]);
        }
      }
      finalCustomers = _searchList;
    }
  }

  SliverList buildSearchedSilverList() {
    return new SliverList(
      delegate:
          new SliverChildBuilderDelegate((BuildContext context, int index) {
        return GestureDetector(
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
                            listCustomers.elementAt(index).customer_name,
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
                            listCustomers.elementAt(index).contact_number,
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
      }, childCount: _searchList.length),
    );
  }
}
