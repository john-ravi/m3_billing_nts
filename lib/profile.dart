import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m3_billing_nts/profileFragment.dart';
import 'package:m3_billing_nts/user.dart';
import 'package:m3_billing_nts/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  void initState() {
  }

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
        body: Builder(builder: (context) => ProfileFragment()),
      ),
    );
  }





}
