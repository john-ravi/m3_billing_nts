import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'colorspage.dart';
import 'home.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    SettingsState settingsState() => new SettingsState();
    return settingsState();
  }
}

class SettingsState extends State<Settings> {
  String selectedcurrency;
  String selecteddof;
  String selectedlanguage;
  List<String> currencylist = new List<String>();
  List<String> doflist = new List<String>();
  List<String> languagelist = new List<String>();

  @override
  void initState() {
    super.initState();
    currencylist.addAll(['INR', 'USD']);
    doflist.addAll(['DD/MM/YYYY', 'YYYY/MM/DD']);
    languagelist.addAll(['ENGLISH', 'RUSSIAN']);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
          fontFamily: 'Georgia',
          primaryColor: Colors.black,
          accentColor: Colors.black,
          hintColor: Colors.black),
      home: new Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: new AppBar(
            elevation: 0.0,
            title: Text('Settings'),
            backgroundColor: secondarycolor,
            leading: new IconButton(
                iconSize: 18.0,
                icon: new Icon(FontAwesomeIcons.chevronLeft),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
          body: SafeArea(
            child: new Stack(
              children: <Widget>[
                new Image.asset(
                  'assets/images/bg.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                ListView(
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
                      child: new Center(
                        child: SizedBox(
                          height: 400.0,
                          child: new Stack(
                            children: <Widget>[
                              Container(
                                height: 380.0,
                                child: new Card(
                                  margin:
                                      EdgeInsets.only(right: 10.0, left: 10.0),
                                  elevation: 6.0,
                                  child: Column(
                                    children: <Widget>[
                                      new Container(
                                        alignment: Alignment(0.0, 0.0),
                                        margin: EdgeInsets.only(top: 20.0),
                                        child: new Text(
                                          'Settings',
                                          style: TextStyle(
                                              fontSize: 25.0,
                                              color: secondarycolor),
                                        ),
                                      ),
                                      new ListTile(
                                        leading: const Icon(
                                          Icons.shop,
                                          color: Colors.black,
                                        ),
                                        title: new TextFormField(
                                          decoration: new InputDecoration(
                                            hintText: 'Enter your invoice',
                                            hintStyle: TextStyle(),
                                            labelText: 'Invoice',
                                            labelStyle: TextStyle(),
                                          ),
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                          Icons.attach_money,
                                          color: Colors.black,
                                        ),
                                        title: new Container(
                                          child: DropdownButtonHideUnderline(
                                            child: ButtonTheme(
                                              child: new DropdownButton<String>(
                                                isDense: true,
                                                hint:
                                                    new Text("Select Currency"),
                                                value: selectedcurrency,
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    selectedcurrency = newValue;
                                                  });
                                                },
                                                items: currencylist
                                                    .map((String map) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: map,
                                                    child: new Text(
                                                      map,
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                          Icons.calendar_today,
                                          color: Colors.black,
                                        ),
                                        title: new Container(
                                          child: DropdownButtonHideUnderline(
                                            child: ButtonTheme(
                                              child: new DropdownButton<String>(
                                                isDense: true,
                                                hint: new Text("Date Format"),
                                                value: selecteddof,
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    selecteddof = newValue;
                                                  });
                                                },
                                                items:
                                                    doflist.map((String map) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: map,
                                                    child: new Text(
                                                      map,
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                          Icons.language,
                                          color: Colors.black,
                                        ),
                                        title: new Container(
                                          child: DropdownButtonHideUnderline(
                                            child: ButtonTheme(
                                              child: new DropdownButton<String>(
                                                isDense: true,
                                                hint: new Text("Language"),
                                                value: selectedlanguage,
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    selectedlanguage = newValue;
                                                  });
                                                },
                                                items: languagelist
                                                    .map((String map) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: map,
                                                    child: new Text(
                                                      map,
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                child: ConstrainedBox(
                                  constraints:
                                      new BoxConstraints(minWidth: 250.0),
                                  child: new RaisedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new Home()));
                                    },
                                    color: primarycolor,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    child: new Text('UPDATE SETTINGS',
                                        style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
