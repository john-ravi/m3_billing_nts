import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'colorspage.dart';
import 'home.dart';

class VacationFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    VacationFragmentState vacationfragmentState() => new VacationFragmentState();
    return vacationfragmentState();
  }
}

class VacationFragmentState extends State<VacationFragment> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
         fontFamily: 'Georgia'
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            new Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(
                                        top: 20.0, left: 10.0, right: 10.0),
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
