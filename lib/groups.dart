import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m3_billing_nts/model_Group.dart';
import 'colorspage.dart';
import 'home.dart';
import 'colorspage.dart';
import 'create_group.dart';

import 'package:http/http.dart' as http;

import 'utils.dart';

class Groups extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    GroupsState groupState() => new GroupsState();
    return groupState();
  }
}

class GroupsState extends State<Groups> {

  List<Group> listGroup = new List();

  @override
  void initState() {
    super.initState();
    callGetGroups();

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
          title: Text('Groups'),
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
                new MaterialPageRoute(builder: (context) => new CreateGroup()));
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
                            hintText: 'Search Groups',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                ),
                            labelText: 'Search Groups',
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
                                        'Group Name ',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            ),
                                      ),
                                    ),
                                    Container(
                                     margin: EdgeInsets.only( top: 25.0,left: 5.0),
                                      child: new Text(
                                        listGroup[index].group_name,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            ),
                                      ),
                                    ),
                                  ]),
/*                                  TableRow(children: [
                                    Container(
                                      margin: EdgeInsets.only( top: 10.0,left: 5.0, bottom: 25.0),
                                      child: new Text(
                                        'Status ',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only( top: 10.0,left: 5.0, bottom: 25.0),
                                      child: new Text(
                                        ' : Active',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            ),
                                      ),
                                    ),
                                  ])*/
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }, childCount: listGroup.length),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void callGetGroups() async{

    var uri = Uri.http(authority, unencodedPath, {
      "page": "getGroups"
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
              id: row["id"],
              state: row["state"],
              city: row["city"],
              group_name: row["group_name"],
              address: row["address"],
              pincode: row["pincode"]
          ));

          setState(() {
          });

        });


      } else {
        print("Failed Pulling Item ");
      }
    } else {
      print("Network Error: ${htResponse.statusCode} --- ${htResponse
          .reasonPhrase} ");
      s(context, "Network Error: ${htResponse.statusCode} --- ${htResponse
          .reasonPhrase} ");
    }

  }
}
