import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'colorspage.dart';
import 'home.dart';

class Vacation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    VacationState vacationState() => new VacationState();
    return vacationState();
  }
}

class VacationState extends State<Vacation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
         fontFamily: 'Georgia'
      ),
      home: Scaffold(
        appBar: new AppBar(
            elevation: 0.0,
            title: Text('Vacation'),
            backgroundColor: secondarycolor,
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
              height: double.infinity,
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
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
                    child: SizedBox(
                      height: 300.0,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 280.0,
                            child: new Card(
                              elevation: 6.0,
                              margin: EdgeInsets.only(right: 10.0, left: 10.0),
                              child: Column(
                                children: <Widget>[
                                  new Container(
                                    alignment: Alignment(0.0, 0.0),
                                    margin: EdgeInsets.only(top: 20.0),
                                    child: new Text(
                                      'VACATION',
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          color: secondarycolor),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(
                                        top: 10.0, left: 10.0, right: 10.0),
                                    child: Text(
                                      'START DATE : ',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          ),
                                    ),
                                  ),
                                  new ListTile(
                                    title: Container(
                                      padding: EdgeInsets.all(5.0),
                                      alignment: Alignment.centerLeft,
                                      decoration: new BoxDecoration(
                                          borderRadius:
                                              new BorderRadius.circular(5.0),
                                          border: new Border.all(
                                              color: Colors.black)),
                                      child: Text(
                                        'DD / MM / YYYY',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            ),
                                      ),
                                    ),
                                    trailing: new Icon(
                                      FontAwesomeIcons.calendar,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(
                                        top: 10.0, left: 10.0, right: 10.0),
                                    child: Text(
                                      'END DATE : ',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          ),
                                    ),
                                  ),
                                  new ListTile(
                                    title: Container(
                                      padding: EdgeInsets.all(5.0),
                                      alignment: Alignment.centerLeft,
                                      decoration: new BoxDecoration(
                                          borderRadius:
                                              new BorderRadius.circular(5.0),
                                          border: new Border.all(
                                              color: Colors.black)),
                                      child: Text(
                                        'DD / MM / YYYY',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            ),
                                      ),
                                    ),
                                    trailing: new Icon(
                                      FontAwesomeIcons.calendar,
                                      color: Colors.black,
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
                                child: new Text('CREATE VACATION',
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
