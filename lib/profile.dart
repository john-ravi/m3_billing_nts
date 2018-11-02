import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'colorspage.dart';
import 'home.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    ProfileState profileState() => new ProfileState();
    return profileState();
  }
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        fontFamily: 'Georgia',
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: Text('Profile'),
          backgroundColor: secondarycolor,
          leading: new IconButton(
              iconSize: 18.0,
              icon: new Icon(FontAwesomeIcons.chevronLeft),
              onPressed: () {
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => new Home()));
              }),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              new Image.asset(
                'assets/images/bg.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      alignment: Alignment(0.0, -1.0),
                      child: new Image.asset(
                        'assets/images/logo.png',
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      child: new SizedBox(
                        height: 670.0,
                        child: Stack(children: <Widget>[
                          Container(
                            height: 650.0,
                            margin: EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Card(
                              elevation: 6.0,
                              child: new Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.user,
                                          color: secondarycolor,
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10.0),
                                                  child: Text(
                                                    'Name',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.grey),
                                                  )),
                                              Container(
                                                child: Text(
                                                  'M3',
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.mobileAlt,
                                          color: secondarycolor,
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10.0),
                                                  child: Text(
                                                    'Mobile Number',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.grey),
                                                  )),
                                              Container(
                                                child: Text(
                                                  '1234567890',
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.envelope,
                                          color: secondarycolor,
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10.0),
                                                  child: Text(
                                                    'Email',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.grey),
                                                  )),
                                              Container(
                                                child: Text(
                                                  'm3@gmail.com',
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.home,
                                          color: secondarycolor,
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10.0),
                                                  child: Text(
                                                    'Flat No',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.grey),
                                                  )),
                                              Container(
                                                child: Text(
                                                  'A2',
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.home,
                                          color: secondarycolor,
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10.0),
                                                  child: Text(
                                                    'Building & Street Address',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.grey),
                                                  )),
                                              Container(
                                                child: Text(
                                                  'm3street',
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.home,
                                          color: secondarycolor,
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10.0),
                                                  child: Text(
                                                    'Area',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.grey),
                                                  )),
                                              Container(
                                                child: Text(
                                                  'Area m3',
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.home,
                                          color: secondarycolor,
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10.0),
                                                  child: Text(
                                                    'City',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.grey),
                                                  )),
                                              Container(
                                                child: Text(
                                                  'Hyderbad',
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.home,
                                          color: secondarycolor,
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10.0),
                                                  child: Text(
                                                    'Pincode',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.grey),
                                                  )),
                                              Container(
                                                child: Text(
                                                  '5990011',
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: ConstrainedBox(
                              constraints: new BoxConstraints(minWidth: 250.0),
                              child: new RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => new Home()));
                                },
                                color: primarycolor,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                child: new Text('UPDATE ADDRESS',
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          )
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
