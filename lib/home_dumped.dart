import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m3_billing_nts/bills_modified_fragment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share/share.dart';

import 'allbills.dart';
import 'calender_fragment.dart';
import 'colorspage.dart';
import 'create_bills.dart';
import 'create_catergory.dart';
import 'create_item.dart';
import 'delivery_boys.dart';
import 'groups.dart';
import 'help.dart';
import 'list_customer.dart';
import 'main.dart';
import 'notification.dart';
import 'orders.dart';
import 'products.dart';
import 'profile.dart';
import 'profileFragment.dart';
import 'settings.dart';
import 'user.dart';
import 'utils.dart';
import 'vacation.dart';
import 'vacationfragment.dart';


class HomeDumped extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    HomeState homeState() => new HomeState();
    return homeState();
  }
}

class HomeState extends State<HomeDumped> {
  int homeIndex = 3;
  User user;
  String userMobile;
  List listUser;

  @override
  void initState() {
    print('init state: $this');
    getUser();
    super.initState();
  }

  @override
  void dispose() {
    print('dispose: $this');
    super.dispose();
  }

  @override
  void didUpdateWidget(HomeDumped oldWidget) {
    print('didUpdateWidget: $this');
    super.didUpdateWidget(oldWidget);
  }

  final List<Widget> homechildren = [
    CalenderFragment(),
    BillFragments(),
    VacationFragment(),
    ProfileFragment(),
  ];

  void onTabTapped(int index) {

    setState(() {
      homeIndex = index;
    });
  }

  Future<bool> _onWillPop(BuildContext context) async{
    print("Do you want to exit this");

    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          items: itemsBottomNavigation(),
        ),
        drawer: Drawer(
          child: buildListViewDrawer(context),
        ),
        body: WillPopScope(
          child: homechildren[homeIndex],
          onWillPop: () => _onWillPop(context),
        ),
        floatingActionButton: FloatingActionButton(onPressed: callShowDialog, child: Icon(Icons.access_alarm),),
      ),
    );
  }

  ListView buildListViewDrawer(BuildContext context) {
    return new ListView(
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
                  child: Icon(FontAwesomeIcons.user,
                      size: 48.0, color: Colors.white),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text(
                    '',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text(userMobile ?? "",
                      style: TextStyle(fontSize: 18.0, color: Colors.white)),
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
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new CreateBill()));
          },
        ),
        new ListTile(
          title: new Text('Customers'),
          leading: new Icon(
            FontAwesomeIcons.fileInvoice,
            color: secondarycolor,
          ),
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Customers()));
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
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Products()));
          },
        ),
        new ListTile(
          title: new Text('All Bills'),
          leading: new Icon(
            FontAwesomeIcons.moneyBillAlt,
            color: secondarycolor,
          ),
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new AllBills()));
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
                    builder: (context) => new DeliveryBoys()));
          },
        ),
        new ListTile(
          title: new Text('Orders'),
          leading: new Icon(
            FontAwesomeIcons.solidHandPaper,
            color: secondarycolor,
          ),
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Orders()));
          },
        ),
        new ListTile(
          title: new Text('Create Item'),
          leading: new Icon(
            FontAwesomeIcons.plusCircle,
            color: secondarycolor,
          ),
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new CreateItem()));
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
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Profile()));
          },
        ),
        new ListTile(
          title: new Text('Groups'),
          leading: new Icon(
            FontAwesomeIcons.layerGroup,
            color: secondarycolor,
          ),
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Groups()));
          },
        ),
        new ListTile(
          title: new Text('Vacation'),
          leading: new Icon(
            FontAwesomeIcons.hotel,
            color: secondarycolor,
          ),
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Vacation()));
          },
        ),
        Builder(
            builder: (context) => new ListTile(
                title: new Text('Refer Friend'),
                leading: new Icon(
                  FontAwesomeIcons.share,
                  color: secondarycolor,
                ),
                onTap: () {
                  final RenderBox box = context.findRenderObject();
                  Share.share("Hi, I am Refering you M3 Billing App",
                      sharePositionOrigin:
                      box.localToGlobal(Offset.zero) & box.size);
                })),
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
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Help()));
          },
        ),
        new ListTile(
          title: new Text('Settings'),
          leading: new Icon(
            FontAwesomeIcons.cog,
            color: secondarycolor,
          ),
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Settings()));
          },
        ),
        new ListTile(
          title: new Text('Log Out'),
          leading: new Icon(
            FontAwesomeIcons.signOutAlt,
            color: secondarycolor,
          ),
          onTap: () {
            logoutBilling(context);
          },
        ),
      ],
    );
  }

  void logoutBilling(BuildContext context) async {
    showloader(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("billingLoggedIn");
    prefs.remove("billingCurrentUser");

    print(prefs.getBool("billingLoggedIn") ?? false);
    print(prefs.getString("billingCurrentUser"));

    removeloader();
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new MyApp()));
  }

  List<BottomNavigationBarItem> itemsBottomNavigation() {
    return [
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
          title: Text('BILLS', style: TextStyle(color: secondarycolor))),
      BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.hotel,
            color: secondarycolor,
          ),
          title: Text('VACATION', style: TextStyle(color: secondarycolor))),
      BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.user,
            color: secondarycolor,
          ),
          title: Text('PROFILE', style: TextStyle(color: secondarycolor)))
    ];
  }

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userMobile = prefs.getString(CURRENT_USER);
    });
  }

  callShowDialog() async{

    print("showing dialog");
    await showDialog(
      context: context,
      builder: (context) =>  new AlertDialog(
        title: new Text('Do you want to exit this application?'),
        content: new Text('We hate to see you leave...'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    );
  }
}
