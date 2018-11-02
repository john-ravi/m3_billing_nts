import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'colorspage.dart';

class ProductDetails extends StatefulWidget {
  final String productTitle;

  ProductDetails({this.productTitle});

  @override
  State<StatefulWidget> createState() {
    ProductDetailsState productDetailsState() => new ProductDetailsState();
    return productDetailsState();
  }
}

class ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
         fontFamily: 'Georgia'
      ),
      home: new Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(widget.productTitle),
          backgroundColor: secondarycolor,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.pencilAlt,
                color: Colors.white,
              ),
              onPressed: null,
            ),
          ],
          leading: new IconButton(
              iconSize: 18.0,
              icon: new Icon(FontAwesomeIcons.chevronLeft),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Stack(
          children: <Widget>[
            new Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Card(
              elevation: 6.0,
              margin: EdgeInsets.all(10.0),
              child: ListView(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Text(
                        'Item Name : ',
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 10.0, top: 10.0,bottom: 10.0),
                    child: Text(
                      'M3',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only( right: 10.0, left: 10.0),
                     child: Divider( color: Colors.black,),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Text(
                        'Unit Cost : ',
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 10.0, top: 10.0,bottom: 10.0),
                    child: Text(
                      '40Rs',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only( right: 10.0, left: 10.0),
                     child: Divider( color: Colors.black,),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Text(
                        'No Of Units : ',
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 10.0, top: 10.0,bottom: 10.0),
                    child: Text(
                      '4',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only( right: 10.0, left: 10.0),
                     child: Divider( color: Colors.black,),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Text(
                        'Available From : ',
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 10.0, top: 10.0,bottom: 10.0),
                    child: Text(
                      '18-09-2018',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only( right: 10.0, left: 10.0),
                     child: Divider( color: Colors.black,),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Text(
                        'Available To : ',
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 10.0, top: 10.0,bottom: 10.0),
                    child: Text(
                      '30-09-2018',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only( right: 10.0, left: 10.0),
                     child: Divider( color: Colors.black,),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Text(
                        'Tax : ',
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 10.0, top: 10.0,bottom: 10.0),
                    child: Text(
                      '50Rs',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
