import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home.dart';
import 'colorspage.dart';
import 'all_fragment.dart';
import 'orders_fragments.dart';

class Orders extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    OrdersState allBillState() => new OrdersState();
    return allBillState();
  }
}

class OrdersState extends State<Orders> with SingleTickerProviderStateMixin {
  TabController orderscontroller;

  void initState() {
    super.initState();
    orderscontroller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    orderscontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
         fontFamily: 'Georgia'
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: Text('Orders'),
          backgroundColor: secondarycolor,
          leading: new IconButton(
              iconSize: 18.0,
              icon: new Icon(FontAwesomeIcons.chevronLeft),
              onPressed: () {
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => new Home()));
              }),
          bottom: TabBar(
            controller: orderscontroller,
            indicatorColor: primarycolor,
             unselectedLabelColor: Colors.black,
            tabs: <Widget>[
              Tab(
                text: 'TODAY',
              ),
              Tab(
                text: 'WEEK',
              ),
              Tab(
                text: 'MONTH',
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: orderscontroller,
          children: <Widget>[OrderFragments(), AllFragments(), AllFragments()],
        ),
      ),
    );
  }
}
