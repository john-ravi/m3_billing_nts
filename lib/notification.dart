import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'colorspage.dart';
import 'home.dart';
import 'colorspage.dart';
import 'create_group.dart';

class Notifications extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    NotificationState notificationState() => new NotificationState();
    return notificationState();
  }
}

class NotificationState extends State<Notifications> {
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
          title: Text('Notifications'),
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
/*
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new CreateGroup()));
*/
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
                                        'M3 Sent Notification to you ',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            ),
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Container(
                                      margin: EdgeInsets.only( top: 10.0,left: 5.0, bottom: 25.0),
                                      child: new Text(
                                        '4Hrs Ago',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            ),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
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
