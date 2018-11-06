import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'allbills.dart';
import 'colorspage.dart';
import 'create_bill.dart';
import 'create_catergory.dart';
import 'create_item.dart';
import 'groups.dart';
import 'help.dart';
import 'list_customer.dart';
import 'main.dart';
import 'notification.dart';
import 'products.dart';
import 'user.dart';

import 'bills_fragment.dart';
import 'calender_fragment.dart';
import 'delivery_boy.dart';
import 'orders.dart';
import 'profile.dart';
import 'profileFragment.dart';
import 'settings.dart';
import 'utils.dart';
import 'vacation.dart';
import 'vacationfragment.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    HomeState homeState() => new HomeState();
    return homeState();
  }
}

class HomeState extends State<Home> {
  int homeIndex = 3;
  User user;
  String userMobile;

  Future<bool> matchMobileWithLoggedInFire() {
    _auth.currentUser().then((fireUser) => {});
  }

  @override
  void initState() {
    // initMobile();
    super.initState();
  }

  final List<Widget> homechildren = [
    CalenderFragment(),
    BillFragments(),
    VacationFragment(),
    ProfileFragment(),
  ];

  initMobile() async {
    print("Init Mobile");
    await getUserMobile().then((stringM) {
      if (stringM == null) {
        print("NULL Mobile");
        // initMobile();
      } else {
        setState(() {
          print(stringM);
          userMobile = stringM;
        });
      }
    });
  }

  void onTabTapped(int index) {
    setState(() {
      homeIndex = index;
    });
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () => exit(0),
                    child: new Text('Yes'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: new MaterialApp(
          theme: ThemeData(fontFamily: 'Georgia'),
          home: new Scaffold(
            appBar: new AppBar(
              elevation: 0.0,
              title: Text('Home Screen'),
              backgroundColor: secondarycolor,
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: onTabTapped,
              currentIndex: homeIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.calendar,
                      color: secondarycolor,
                    ),
                    title: Text(
                      'CALENDER',
                      style: TextStyle(color: secondarycolor),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.moneyBill,
                      color: secondarycolor,
                    ),
                    title:
                        Text('BILLS', style: TextStyle(color: secondarycolor))),
                BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.hotel,
                      color: secondarycolor,
                    ),
                    title: Text('VACATION',
                        style: TextStyle(color: secondarycolor))),
                BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.user,
                      color: secondarycolor,
                    ),
                    title: Text('PROFILE',
                        style: TextStyle(color: secondarycolor)))
              ],
            ),
            drawer: Drawer(
              child: new ListView(
                children: <Widget>[
                  DrawerHeader(
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                      color: secondarycolor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Icon(FontAwesomeIcons.user,size: 48.0,
                                color: Colors.white),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Text(
                              '',
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Text(
                                "",
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new ListTile(
                    title: new Text('Create Bill'),
                    leading: new Icon(
                      FontAwesomeIcons.moneyBillWave,
                      color: secondarycolor,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new CreateBill()));
                    },
                  ),
                  new ListTile(
                    title: new Text('Customers'),
                    leading: new Icon(
                      FontAwesomeIcons.fileInvoice,
                      color: secondarycolor,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Customers()));
                    },
                  ),
                  new ListTile(
                    title: new Text('Create Catergory'),
                    leading: new Icon(
                      FontAwesomeIcons.caretUp,
                      color: secondarycolor,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new CreateCategory()));
                    },
                  ),
                  new ListTile(
                    title: new Text('Products'),
                    leading: new Icon(
                      FontAwesomeIcons.productHunt,
                      color: secondarycolor,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Products()));
                    },
                  ),
                  new ListTile(
                    title: new Text('All Bills'),
                    leading: new Icon(
                      FontAwesomeIcons.moneyBillAlt,
                      color: secondarycolor,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new AllBills()));
                    },
                  ),
                  new ListTile(
                    title: new Text('Delivery Boy'),
                    leading: new Icon(
                      FontAwesomeIcons.truck,
                      color: secondarycolor,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new DeliveryBoy()));
                    },
                  ),
                  new ListTile(
                    title: new Text('Orders'),
                    leading: new Icon(
                      FontAwesomeIcons.solidHandPaper,
                      color: secondarycolor,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Orders()));
                    },
                  ),
                  new ListTile(
                    title: new Text('Create Item'),
                    leading: new Icon(
                      FontAwesomeIcons.plusCircle,
                      color: secondarycolor,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new CreateItem()));
                    },
                  ),
                  new ListTile(
                    title: new Text('Reports'),
                    leading: new Icon(
                      FontAwesomeIcons.flag,
                      color: secondarycolor,
                    ),
                  ),
                  new ListTile(
                    title: new Text('My Profile'),
                    leading: new Icon(
                      FontAwesomeIcons.userCircle,
                      color: secondarycolor,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Profile()));
                    },
                  ),
                  new ListTile(
                    title: new Text('Groups'),
                    leading: new Icon(
                      FontAwesomeIcons.layerGroup,
                      color: secondarycolor,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Groups()));
                    },
                  ),
                  new ListTile(
                    title: new Text('Vacation'),
                    leading: new Icon(
                      FontAwesomeIcons.hotel,
                      color: secondarycolor,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Vacation()));
                    },
                  ),
                  new ListTile(
                    title: new Text('Refer Friend'),
                    leading: new Icon(
                      FontAwesomeIcons.share,
                      color: secondarycolor,
                    ),
                  ),
                  new ListTile(
                    title: new Text('Notification'),
                    leading: new Icon(
                      FontAwesomeIcons.bell,
                      color: secondarycolor,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Notifications()));
                    },
                  ),
                  new ListTile(
                    title: new Text('Help'),
                    leading: new Icon(
                      FontAwesomeIcons.infoCircle,
                      color: secondarycolor,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Help()));
                    },
                  ),
                  new ListTile(
                    title: new Text('Settings'),
                    leading: new Icon(
                      FontAwesomeIcons.cog,
                      color: secondarycolor,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Settings()));
                    },
                  ),
                  new ListTile(
                    title: new Text('Log Out'),
                    leading: new Icon(
                      FontAwesomeIcons.signOutAlt,
                      color: secondarycolor,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new MyApp()));
                    },
                  ),
                ],
              ),
            ),
            body: homechildren[homeIndex],
          )),
    );
  }
}
