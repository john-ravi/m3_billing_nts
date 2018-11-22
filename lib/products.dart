import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m3_billing_nts/edit_item.dart';
import 'package:m3_billing_nts/model_items.dart';
import 'colorspage.dart';
import 'home.dart';
import 'product_details.dart';
import 'productadapter.dart';
import 'package:http/http.dart' as http;

import 'utils.dart';

class Products extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    ProductState productState() => new ProductState();
    return productState();
  }
}

class ProductState extends State<Products> {
  List<ModelProductItem> listItems = new List();

  List<ModelProductItem> finalItems = new List();

  @override
  void initState() {
    super.initState();
    callGetProducts();
  }

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
                Navigator.pop(context);
              }),
        ),
        body: Builder(builder: (context) => buildStack(context)),
      ),
    );
  }

  Stack buildStack(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Image.asset(
          'assets/images/bg.png',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        ListView.builder(
          itemCount: finalItems.length,
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new EditItem(finalItems[index])));
              },
              // ignore: argument_type_not_assignable
              /*EditItem(finalItems[index])*/
              child: ProductAdapter(finalItems[index]),
            );
          },
        )
      ],
    );
  }

  void callGetProducts() async {
    var uri = Uri.http(authority, unencodedPath, {"page": "getMyItems"});

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

        rows.forEach((row) {
          listItems.add(ModelProductItem.named(
              id: row["id"],
              item_name: row["item_name"],
              unit_cost: row["unit_cost"],
              no_of_units: row["no_of_units"],
              start_date: row["start_date"],
              end_date: row["end_date"],
              tax: row["tax"]));

          setState(() {
            finalItems = listItems;
          });
        });
      } else {
        print("Failed Pulling Item ");
      }
    } else {
      print(
          "Network Error: ${htResponse.statusCode} --- ${htResponse.reasonPhrase} ");
      s(context,
          "Network Error: ${htResponse.statusCode} --- ${htResponse.reasonPhrase} ");
    }
  }
}
