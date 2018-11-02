import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'colorspage.dart';
import 'home.dart';
import 'product_details.dart';
import 'productadapter.dart';

class Products extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    ProductState productState() => new ProductState();
    return productState();
  }
}

class ProductState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Georgia'),
      home: Scaffold(
        appBar: new AppBar(
          title: new Text('Products'),
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
            ListView.builder(
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return new GestureDetector(
                  onTap: (){
                       Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new ProductDetails( productTitle: 'M3$index',)));
                  },
                  child: ProductAdapter(index),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
