import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m3_billing_nts/all_fragment_paid.dart';
import 'package:m3_billing_nts/all_fragment_unpaid.dart';
import 'package:m3_billing_nts/bills_model.dart';
import 'package:m3_billing_nts/utils.dart';
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

  List<Bills> listBills = new List();

  void initState() {
    super.initState();

    callGetBills();
    allbillcontroller = new TabController(vsync: this, length: 3);
  }

  void callGetBills() async {
    await getBills().then((listBillsPulled) {
      print("Bills PULLED ALLBILLS \n ${listBillsPulled.toString()}");
      setState(() {
        listBills = listBillsPulled;
      });
    });
  }

  @override
  void dispose() {
    allbillcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(fontFamily: 'Georgia'),
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
          children: <Widget>[
            AllFragments(listBills),
            AllFragmentsPaid(listBills),
            AllFragmentsUnPaid(listBills)
          ],
        ),
      ),
    );
  }
}
