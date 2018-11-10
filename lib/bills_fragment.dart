import 'package:flutter/material.dart';
import 'all_fragment.dart';
import 'colorspage.dart';

class BillFragments extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    BillFragmentState billfragmentState() => new BillFragmentState();
    return billfragmentState();
  }
}

class BillFragmentState extends State<BillFragments>
    with SingleTickerProviderStateMixin {
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
        fontFamily: 'Georgia',
        scaffoldBackgroundColor: secondarycolor,
      ),
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: TabBar(
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
        body: TabBarView(
          controller: allbillcontroller,
          children: <Widget>[/*AllFragments()*/null, /*AllFragments()*/null, /*AllFragments()*/],
        ),
      ),
    );
  }
}
