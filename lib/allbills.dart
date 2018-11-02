import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home.dart';
import 'colorspage.dart';
import 'all_fragment.dart';

class AllBills extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    AllBillState allBillState() => new AllBillState();
    return allBillState();
  }
}

class AllBillState extends State<AllBills> with SingleTickerProviderStateMixin {
  TabController allbillcontroller;

  void initState() {
    super.initState();
    allbillcontroller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    allbillcontroller.dispose();
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
          elevation: 0.0,
          title: Text('All Bills'),
          backgroundColor: secondarycolor,
          leading: new IconButton(
                iconSize: 18.0,
              icon: new Icon(FontAwesomeIcons.chevronLeft),
              onPressed: () {
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => new Home()));
              }),
          bottom: TabBar(
            controller: allbillcontroller,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: 'ALL',
              ),
              Tab(
                text: 'PAID',
              ),
              Tab(
                text: 'UNPAID',
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: allbillcontroller,
          children: <Widget>[AllFragments(), AllFragments(), AllFragments()],
        ),
      ),
    );
  }
}
