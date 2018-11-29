import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m3_billing_nts/customerWithId.dart';
import 'package:m3_billing_nts/model_product_items.dart';
import 'colorspage.dart';
import 'package:http/http.dart' as http;

import 'utils.dart';

class UpdateCustomerBasket extends StatefulWidget {
  final CustomerWithId selectedCustomer;

  UpdateCustomerBasket(this.selectedCustomer);

  @override
  State<StatefulWidget> createState() {
    ProductState productState() => new ProductState();
    return productState();
  }
}

class ProductState extends State<UpdateCustomerBasket> {
  List<ModelProductItem> listItems = new List();
  List<ModelProductItem> finalItems = new List();

  List<int> listCountRequestedItems = [];
  GlobalKey<AutoCompleteTextFieldState<ModelProductItem>> searchTextGlobalkey =
      new GlobalKey();
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
          print("text Changed $item");
        },
        textSubmitted: (item) {
          print("Submitteed $item");
          setState(() {
            listCountRequestedItems.add(0);

            ModelProductItem suggestionFromList = suggestions
                .firstWhere((suggestion) => suggestion.item_name == item);

            int index = suggestions.indexOf(suggestionFromList);

            print(
                "first Suggestion from list $suggestionFromList \t its index $index");
            basketItems.add(suggestions[index]);
          });
        },
        itemBuilder: (context, item) {
          return new Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
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

    var map = basketItems.map((item) {
      int indexOf = basketItems.indexOf(item);
      print("adding @ $indexOf index of basketItem");

      return new ListTile(
        title: new Text(item.item_name + "\nAvailable: ${item.no_of_units}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            listCountRequestedItems[indexOf] != 0
                ? new IconButton(
                    icon: new Icon(Icons.remove),
                    onPressed: () =>
                        setState(() => listCountRequestedItems[indexOf]--),
                  )
                : new Container(),
            new Text(listCountRequestedItems[indexOf].toString()),
            listCountRequestedItems[indexOf] <= item.no_of_units
                ? new IconButton(
                    icon: new Icon(Icons.add),
                    onPressed: () =>
                        setState(() => listCountRequestedItems[indexOf]++))
                : Container(),
          ],
        ),
      );
    });

    var galleries = <Widget>[];

    galleries.add(ListTile(
      title: textField,
    ));
    galleries.add(ListTile(
      title: Text(
        "Customer Basket Items",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18.0),
      ),
    ));
    galleries.addAll(map);

    galleries.add(Divider(
      color: secondarycolor,
      height: 1.6,
    ));

    galleries.add(ListTile(
      title: Text(
        "My Products",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18.0),
      ),
    ));

    galleries.addAll(listItems.map((item) => buildContainer(item)));

    ListView body = new ListView(children: galleries,);


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

  Container buildContainer(ModelProductItem item) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Card(
        elevation: 6.0,
        margin: EdgeInsets.all(4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Table(
              children: [
                TableRow(children: [
                  Container(
                    margin: EdgeInsets.all(5.0),
                    child: new Text(
                      'Product ',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5.0),
                    child: new Text(
                      item.item_name,
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
                      'Unit Cost ',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5.0),
                    child: new Text(
                      item.unit_cost.toString(),
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
                      'Tax ',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5.0),
                    child: new Text(
                      item.tax,
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
//                int index = listItems.indexOf(item);
                basketItems.add(item);
                listCountRequestedItems.add(0);
                setState(() {

                });
              },
              child: Container(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.only(bottom: 10.0, top: 5.0, right: 10.0),
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(5.0),
                      border: new Border.all(color: secondarycolor)),
                  child: Text(
                    'Add to Basket',
                    style: TextStyle(fontSize: 14.0, color: secondarycolor),
                  ),
                ),
              ),
            )
          ],
        ),
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
          setState(() {
            listItems.add(ModelProductItem.named(
                id: row["id"],
                item_name: row["item_name"],
                unit_cost: double.tryParse(row["unit_cost"]) ?? 0.0,
                no_of_units: double.tryParse(row["no_of_units"]) ?? 0.0,
                start_date: row["start_date"],
                end_date: row["end_date"],
                tax: row["tax"]));

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
