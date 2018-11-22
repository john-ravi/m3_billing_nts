import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m3_billing_nts/basket_products_adapter.dart';
import 'package:m3_billing_nts/customerWithId.dart';
import 'package:m3_billing_nts/edit_item.dart';
import 'package:m3_billing_nts/model_items.dart';
import 'colorspage.dart';
import 'home.dart';
import 'product_details.dart';
import 'productadapter.dart';
import 'package:http/http.dart' as http;

import 'utils.dart';

class ProductsForBilling extends StatefulWidget {
  CustomerWithId selectedCustomer;

  ProductsForBilling(this.selectedCustomer);

  @override
  State<StatefulWidget> createState() {
    ProductState productState() => new ProductState();
    return productState();
  }
}

class ProductState extends State<ProductsForBilling> {
  List<ModelProductItem> listItems = new List();
  List<ModelProductItem> finalItems = new List();

  List<String> added = [];
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<ModelProductItem>> searchTextGlobalkey = new GlobalKey();
  List<ModelProductItem> suggestions = new List();
  List<ModelProductItem> basketItems = new List();



  AutoCompleteTextField textField;


  @override
  void initState() {
    callGetProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textField = new AutoCompleteTextField<ModelProductItem>(
        decoration: new InputDecoration(
          hintText: "Search Item",
        ),
        key: searchTextGlobalkey,
        submitOnSuggestionTap: true,
        clearOnSubmit: true,
        suggestions: suggestions,
        textInputAction: TextInputAction.go,
        textChanged: (item) {
          currentText = item;
          print("currwent $currentText");
          print("list ${suggestions.toString()}");
        },
        textSubmitted: (item) {
          print("Submitteed");
          setState(() {
            currentText = item;
            added.add(currentText);
            currentText = "";
          });
        },
        itemBuilder: (context, item) {
          var _itemCount = 0;
          return new Padding(
              padding: EdgeInsets.all(8.0), child: Column(
                children: <Widget>[
                  new Text(item.item_name),

                ],
              ));
        },
        itemSorter: (a, b) {
          return a.item_name.compareTo(b.item_name);
        },
        itemFilter: (item, query) {
          return item.item_name.toLowerCase().startsWith(query.toLowerCase());
        });

    Column body = new Column(children: [
      new ListTile(
          title: textField,
)
    ]);

    body.children.addAll(added.map((item) {
      var _itemCount = 0;

      return new ListTile(title: new Text(item), subtitle:                   Row(
        children: <Widget>[
          _itemCount!=0? new  IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>_itemCount--),):new Container(),
          new Text(_itemCount.toString()),
          new IconButton(icon: new Icon(Icons.add),onPressed: ()=>setState(()=>_itemCount++))
        ],
      ),);
    }));

    return MaterialApp(
      theme: ThemeData(fontFamily: 'Georgia'),
      home: Scaffold(
        appBar: new AppBar(
          title:
              new Text('Billing on ${widget.selectedCustomer.customer_name}'),
          backgroundColor: secondarycolor,
          leading: new IconButton(
              iconSize: 18.0,
              icon: new Icon(FontAwesomeIcons.chevronLeft),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: body,

      ),
    );
  }


  void callGetProducts() async {
    String authority = "18.191.190.195";
    String unencodedPath = "/billing";

    var uri = Uri.http(authority, unencodedPath, {"page": "getMyItems"});

    d(uri);
    http.Response htResponse;
    try {
      htResponse = await http.get(uri);
    } on Exception catch (e) {
      print("Exception OCCUred, check Network \n $e");
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
            suggestions = listItems;
          });
          searchTextGlobalkey.currentState.updateSuggestions(suggestions);
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

  Widget basketProduct(int index) {
    return new Card(
      elevation: 6.0,
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Table(
            children: [
              TableRow(children: [
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: new Text(
                    'Item Name ',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: new Text(
                    ' : ${finalItems[index].item_name}',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              ]),
              TableRow(children: [
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: new Text(
                    'Unit Cost ',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: new Text(
                    ' : ${finalItems[index].unit_cost}',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              ]),
            ],
          ),
/*          Row(
            children: <Widget>[
              _itemCount!=0? new  IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>_itemCount--),):new Container(),
              new Text(_itemCount.toString()),
              new IconButton(icon: new Icon(Icons.add),onPressed: ()=>setState(()=>_itemCount++))
            ],
          ),*/
        ],
      ),

    );
  }
}
