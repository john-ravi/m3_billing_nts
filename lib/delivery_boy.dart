import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'colorspage.dart';
import 'delivery_boy_details.dart';
import 'home.dart';
import 'createDeliveryBoy.dart';

class DeliveryBoy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    DeliveryBoyState deliveryBoyState() => new DeliveryBoyState();
    return deliveryBoyState();
  }
}

class DeliveryBoyState extends State<DeliveryBoy> {
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
                                      boyname: 'M3$index',
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
                                        ' : M3$index',
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
                                        ' : M3$index',
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
                                        ' : Available',
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
                  }, childCount: 20),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
