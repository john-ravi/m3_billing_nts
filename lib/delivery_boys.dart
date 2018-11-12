import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m3_billing_nts/model_delivery_boy.dart';
import 'package:m3_billing_nts/utils.dart';
import 'colorspage.dart';
import 'delivery_boy_details.dart';
import 'home.dart';
import 'createDeliveryBoy.dart';
import 'package:http/http.dart' as http;

class DeliveryBoy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    DeliveryBoyState deliveryBoyState() => new DeliveryBoyState();
    return deliveryBoyState();
  }
}

class DeliveryBoyState extends State<DeliveryBoy> {

  List<ModelDeliveryBoy> listItems = new List();

  List<ModelDeliveryBoy> finalItems = new List();

  TextEditingController controllerSearch = new TextEditingController();
  FocusNode focusNodeSearch = new FocusNode();

  List<ModelDeliveryBoy> _searchList;
  bool _isSearching;



  @override
  void initState() {
    _isSearching = false;

    callGetDeliveryBoys();

    controllerSearch.addListener(searchListener);
    focusNodeSearch.addListener(() => searchListener());

    super.initState();
  }

  void searchListener() {
    _searchList = new List();

    _searchList.clear();
    if (_isSearching != null) {
      var name = controllerSearch.text;
      for (int i = 0; i < finalItems.length; i++) {
        if (finalItems[i].boy_name.contains(name)) {
          _searchList.add(finalItems[i]);
        }
      }
      setState(() {
        finalItems = _searchList;
      });
    }
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
          title: Text('Delivery Boy'),
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
                    builder: (context) => new CreateDeliveryBoy()));
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
                            contentPadding: EdgeInsets.all(3.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search of Delivery Boys',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                ),
                            labelText: 'Search of Delivery Boys',
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
                new SliverList(
                  delegate: new SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new DeliveryBoyDetails(
                                      finalItems[index],
                                    )));
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
                                      margin: EdgeInsets.all(5.0),
                                      child: new Text(
                                        'Boy Name ',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5.0),
                                      child: new Text(
                                        finalItems[index].boy_name,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            ),
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Container(
                                      margin: EdgeInsets.all(5.0),
                                      child: new Text(
                                        'Boy Mobile Number ',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5.0),
                                      child: new Text(
                                        finalItems[index].contact_number,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            ),
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Container(
                                      margin: EdgeInsets.all(5.0),
                                      child: new Text(
                                        'Status ',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5.0),
                                      child: new Text(
                                        finalItems[index].available_status,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            ),
                                      ),
                                    ),
                                  ])
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  print('Add to group');
                                },
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    margin: EdgeInsets.only(
                                        bottom: 10.0, top: 5.0, right: 10.0),
                                    decoration: new BoxDecoration(
                                        borderRadius:
                                            new BorderRadius.circular(5.0),
                                        border: new Border.all(
                                            color: secondarycolor)),
                                    child: Text(
                                      'Add to group',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          
                                          color: secondarycolor),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }, childCount: finalItems.length),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void callGetDeliveryBoys() async{

    var uri = Uri.http(authority, unencodedPath, {
      "page": "getDeliveryBoys"
    });

    d(uri);
    http.Response htResponse;
    try {
      htResponse = await http.get(uri);
    } on Exception catch (e) {

      print("Exception OCCUred, check Network");
    }

    if (htResponse.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var decodedBody = json.decode(htResponse.body);
      print("decoded body \t" + decodedBody.toString());
      if (decodedBody['response'].toString().compareTo("success") == 0) {
        List rows = decodedBody['body'];
        print("Listing Rows ${rows.toString()}");

        /*
Full texts
id
boy_name
contact_number
available_status
address
city
state
pincode
*/

        rows.forEach((row) {
          listItems.add(ModelDeliveryBoy.named(
              id: row["id"],
              boy_name: row["boy_name"],
              contact_number: row["contact_number"],
              available_status: row["available_status"],
              address: row["address"],
              city: row["city"],
              state: row["state"],
              pincode: row["pincode"]
          ));

          setState(() {
            finalItems = listItems;
          });

        });


      } else {
        print("Failed Pulling Boys ");
      }
    } else {
      print("Network Error: ${htResponse.statusCode} --- ${htResponse
          .reasonPhrase} ");
      s(context, "Network Error: ${htResponse.statusCode} --- ${htResponse
          .reasonPhrase} ");
    }

  }
}
