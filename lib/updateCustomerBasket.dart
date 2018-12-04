import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m3_billing_nts/customerWithId.dart';
import 'package:m3_billing_nts/model_basket_item.dart';
import 'package:m3_billing_nts/model_product_items.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String authority = "18.191.190.195";
  String unencodedPath = "/billing";

  List<ModelProductItem> listSellerItems = new List();
  List<ModelBasketItem> listBasketItems = new List();

  GlobalKey<AutoCompleteTextFieldState<ModelProductItem>> searchTextGlobalkey =
      new GlobalKey();
  List<ModelProductItem> suggestions = new List();

  AutoCompleteTextField textField;

  SharedPreferences prefs;

  @override
  void initState() {
    initEverything();
    super.initState();
  }

  void initEverything() async {
    callGetProducts();

    prefs = await SharedPreferences.getInstance();
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
            ModelProductItem suggestionFromList = suggestions
                .firstWhere((suggestion) => suggestion.item_name == item);

            int index = suggestions.indexOf(suggestionFromList);

            print(
                "first Suggestion from list $suggestionFromList \t its index $index");
            addItemsToBAsket(suggestions[index]);
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

    var iterableBasktetItems = buildBasketItemsIterable();

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
    galleries.addAll(iterableBasktetItems);

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

    galleries.addAll(suggestions.map((item) => buildSellerItemContainer(item)));

    ListView body = new ListView(
      children: galleries,
    );

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

  Iterable<ListTile> buildBasketItemsIterable() {
    return listBasketItems.map((item) {
      print("Basket Item as PAssed $item");
      return new ListTile(
        title: new Text(item.modelProductItem.item_name +
            "\n" +
            "Cost: Rs.${item.modelProductItem.unit_cost}"
            "\n"
            "Available: ${item.modelProductItem.no_of_units.floor()}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            item.purchaseQuantity > 0
                ? new IconButton(
                    icon: new Icon(Icons.remove),
                    onPressed: () {
                      if (item.purchaseQuantity == 1) {
                        removeBasketItemUpdateSellerList(item);
                      } else {
                        item.purchaseQuantity--;
                        setState(() {});
                      }
                    },
                  )
                : retrunEmptyContainerAfterRemovingBasketItem(item),
            new Text(item.purchaseQuantity.toString()),
            item.purchaseQuantity < item.modelProductItem.no_of_units
                ? new IconButton(
                    icon: new Icon(Icons.add),
                    onPressed: () => setState(() => item.purchaseQuantity++))
                : Container(),
          ],
        ),
      );
    });
  }

  addBasketItemToCloud(ModelBasketItem basketItem) async {
    /*
    *
id	seller_name	customer_name	master_list_items	is_in_basket	delivery_boy_id	master_start_date_time	master_event_interval	customer_id	seller_id	item_id
    * */

    var todayAtMorning6 = DateTime.now()
        .subtract(Duration(hours: DateTime.now().hour))
        .add(Duration(
          hours: 6,
        ));

    var uri = Uri.http(authority, unencodedPath, {
      "page": "createBasketItem",
      "seller_name": prefs.getString(CURRENT_USER_NAME),
      "customer_name": widget.selectedCustomer.customer_name,
      "master_list_item": basketItem.modelProductItem.item_name,
      "is_in_basket": "1",
      "master_start_date_time": todayAtMorning6.toIso8601String(),
      "master_event_interval": Duration(days: 1).inMilliseconds.toString(),
      "customer_id": widget.selectedCustomer.id.toString(),
      "seller_id": prefs.getString(CURRENT_USER_ID),
      "item_id": basketItem.modelProductItem.id
    });

    d(uri);
    http.Response httpResponse = await http.post(uri);

    if(httpResponse.statusCode == 200) {
      var decode = json.decode(httpResponse.body);
      print("Decoded body $decode");



    } else {
      print("Network Error ${httpResponse.reasonPhrase}");
    }
  }

  updateBasketItemToCloud(ModelBasketItem basketItem) {

/*
    http.Response httpResponse = await http.post(uri);

    if(httpResponse.statusCode == 200) {

    } else {
      print("Network Error ${httpResponse.reasonPhrase}");
    }
*/

  }

  List<ModelBasketItem> getBasketItemsFromCloud() {
    return null;
  }

  Container retrunEmptyContainerAfterRemovingBasketItem(ModelBasketItem item) {
    removeBasketItemUpdateSellerList(item);
    return new Container();
  }

  Container buildSellerItemContainer(ModelProductItem item) {
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
                addItemsToBAsket(item);
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

  void addItemsToBAsket(ModelProductItem item) {
    suggestions.remove(item);
    listBasketItems.add(
        ModelBasketItem.named(modelProductItem: item,
            purchaseQuantity: 1,
         customer_id: widget.selectedCustomer.id,
          item_id: int.tryParse(item.id),
          customer_name: widget.selectedCustomer.customer_name,
          master_list_item: ""

        ));
    setState(() {});
  }

  void callGetProducts() async {
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
            listSellerItems.add(ModelProductItem.named(
                id: row["id"],
                item_name: row["item_name"],
                unit_cost: double.tryParse(row["unit_cost"]) ?? 0.0,
                no_of_units: double.tryParse(row["no_of_units"]) ?? 0.0,
                start_date: row["start_date"],
                end_date: row["end_date"],
                tax: row["tax"]));

            suggestions = listSellerItems;
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

  void removeBasketItemUpdateSellerList(ModelBasketItem item) {
    suggestions.add(item.modelProductItem);

    listBasketItems.remove(item);

    setState(() {});
  }
}
