import 'package:flutter/material.dart';
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

  List<Customer> listCustomers = new List();

  @override
  void initState() {
    getCustomers().then((onValue) {
      print("Listing Customers \n ${onValue.toString()}");
      setState(() {
        listCustomers = onValue;

      });
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
          title: Text('Customers'),
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
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new CreateCustomer()));
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
                        margin: EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
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
                        ),
                      ),
                    ],
                  ),
                ),
                new SliverList(
                  delegate: new SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
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
                                          margin: EdgeInsets.only( top: 25.0,left: 5.0),
                                          child: new Text(
                                            'Customer Name ',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only( top: 25.0,left: 5.0),
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
                                          margin: EdgeInsets.only( top: 10.0,left: 5.0, bottom: 25.0),
                                          child: new Text(
                                            'Mobile Number ',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only( top: 10.0,left: 5.0, bottom: 25.0),
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
                      }, childCount: listCustomers.length),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
