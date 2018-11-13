import 'package:flutter/material.dart';
import 'package:m3_billing_nts/all_fragment_paid.dart';
import 'package:m3_billing_nts/all_fragment_unpaid.dart';
import 'package:m3_billing_nts/model_bills.dart';
import 'package:m3_billing_nts/utils.dart';
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
