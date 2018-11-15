import 'dart:async';
import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m3_billing_nts/model_delivery_boy.dart';
import 'package:m3_billing_nts/model_group.dart';
import 'package:m3_billing_nts/utils.dart';
import 'colorspage.dart';
import 'delivery_boy_details.dart';
import 'home.dart';
import 'createDeliveryBoy.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class DeliveryBoys extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    DeliveryBoysState deliveryBoyState() => new DeliveryBoysState();
    return deliveryBoyState();
  }
}

class DeliveryBoysState extends State<DeliveryBoys> {
  List<ModelDeliveryBoy> listItems = new List();

  List<ModelDeliveryBoy> finalItems = new List();

  TextEditingController controllerSearch = new TextEditingController();
  FocusNode focusNodeSearch = new FocusNode();

  List<ModelDeliveryBoy> _searchList;
  bool _isSearching;

  List<Group> listGroup = new List();

  @override
  void initState() {
    _isSearching = false;

    callGetDeliveryBoys().then((_) => callGetGroups());

    controllerSearch.addListener(searchListener);
    focusNodeSearch.addListener(() {
      searchListener();
    });

    super.initState();
  }

  void searchListener() {
    print("search has ${controllerSearch.text}");

    _searchList = new List();

    setState(() {
      finalItems = listItems;
    });
    _searchList.clear();
    if (_isSearching != null) {
      var name = controllerSearch.text;
      if (name.isNotEmpty) {
        for (int i = 0; i < finalItems.length; i++) {
          if (finalItems[i].boy_name.contains(name)) {
            _searchList.add(finalItems[i]);
          }
        }
        setState(() {
          finalItems = _searchList;
        });
      } else {
        print("Resetting List");
        setState(() {
          finalItems = listItems;
        });
      }
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
        body: buildStack(),
      ),
    );
  }

  Stack buildStack() {
    return Stack(
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
                    margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
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
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) {
                      print("Delivery Boy Selected ${finalItems[index]}");
                      return new DeliveryBoyDetails(finalItems[index]);
                    }));
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
                              showGroupListDialog(finalItems[index]);
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
                                    border:
                                        new Border.all(color: secondarycolor)),
                                child: Text(
                                  'Add to group',
                                  style: TextStyle(
                                      fontSize: 14.0, color: secondarycolor),
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
    );
  }

  Future<void> callGetDeliveryBoys() async {
    var uri = Uri.http(authority, unencodedPath, {"page": "getDeliveryBoys"});

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
              pincode: row["pincode"]));

          setState(() {
            finalItems = listItems;
          });
        });
      } else {
        print("Failed Pulling Boys ");
      }
    } else {
      print(
          "Network Error: ${htResponse.statusCode} --- ${htResponse.reasonPhrase} ");
      s(context,
          "Network Error: ${htResponse.statusCode} --- ${htResponse.reasonPhrase} ");
    }
  }

  void showGroupListDialog(ModelDeliveryBoy finalItem) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
            title: new Text('Add ${finalItem.boy_name} to Group'),
            content: AddBoyToGroupDialog(finalItem, listGroup),
          ),
    );
  }

  void callGetGroups() async {
    var uri = Uri.http(authority, unencodedPath, {"page": "getGroups"});

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
createGroup

Full texts
id
state
city
group_name
address
pincode
*/

        rows.forEach((row) {
          listGroup.add(Group(
            group_name: row["group_name"],
            id: row["id"],
          ));

          setState(() {});
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

class AddBoyToGroupDialog extends StatefulWidget {
  ModelDeliveryBoy boy;
  List<Group> listGroup;

  AddBoyToGroupDialog(this.boy, this.listGroup);

  @override
  _AddBoyToGroupDialogState createState() => _AddBoyToGroupDialogState();
}

class _AddBoyToGroupDialogState extends State<AddBoyToGroupDialog> {
  List<String> added = [];
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<Group>> key = new GlobalKey();
  List<String> suggestions = new List();

  List<Group> finalItems = [];

  AutoCompleteTextField textField;

  @override
  void initState() {
    finalItems = widget.listGroup;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textField = new AutoCompleteTextField<Group>(
        decoration: new InputDecoration(
          hintText: "Search Group",
        ),
        key: key,
        submitOnSuggestionTap: true,
        clearOnSubmit: true,
        suggestions: widget.listGroup,
        textInputAction: TextInputAction.go,
        textChanged: (item) {
          //  onTextChanged(item);
        },
        textSubmitted: (item) {
          ontextSubmitted(item);
        },
        itemBuilder: (context, item) {
          return new Padding(
              padding: EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () {
                    print("Auto Tapped TApped");
                    addBoyToGroup(item);
                  },
                  child: Text(item.group_name)));
        },
        itemSorter: (a, b) {
          return a.group_name.compareTo(b.group_name);
        },
        itemFilter: (item, query) {
          return item.group_name.toLowerCase().contains(query.toLowerCase());
        });

    Column body = new Column(children: [
      new ListTile(
        title: textField,
      ),
      Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print("Lsit Tapped");
                addBoyToGroup(widget.listGroup[index]);
              },
              child: new ListTile(
                  title: new Text(widget.listGroup[index].group_name)),
            );
          },
          itemCount: widget.listGroup.length,
          shrinkWrap: true,
        ),
      ),
    ]);

    return body;
  }

  void onTextChanged(String item) {
    currentText = item;
    print("currwent $currentText");

    List<Group> _search = [];

    if (currentText.isNotEmpty) {
      for (int i = 0; i < widget.listGroup.length; i++) {
        if (widget.listGroup[i].group_name.contains(currentText)) {
          _search.add(widget.listGroup[i]);
        }
      }
      setState(() {
        finalItems = _search;
      });
    } else {
      print("Resetting List");
      setState(() {
        finalItems = widget.listGroup;
      });
    }
  }

  void ontextSubmitted(item) {
    setState(() {
      print("submitted $item");

      //     addBoyToGroup(item);
    });
  }

  void addBoyToGroup(Group group) async {
    /*
putBoyOnGroup

boys_to_groups

id	boy_name	group_name	boy_id	group_id
*/


    showloader(context);

    var uri = new Uri.http("18.191.190.195", "/billing", {
      "page": "putBoyOnGroup",
      "boy_name": widget.boy.boy_name,
      "group_name": group.group_name,
      "boy_id": widget.boy.id,
      "group_id": group.id,
    });

    print("Printing Create Group URI \n $uri");
    final response = await http.get(uri);

    removeloader();
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var responseBody = json.decode(response.body);
      print(responseBody.toString());

      if (responseBody["response"].toString().compareTo("success") == 0) {
        showToast("Added ${widget.boy.boy_name} to ${group.group_name}");
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => DeliveryBoys()));
      } else {
        showToast("Failed Adding to Group, Please Retry!");
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Network Error');
    }


  }
}
