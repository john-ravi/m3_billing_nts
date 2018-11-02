import 'package:flutter/material.dart';
import 'delivery_boy_fragement.dart';
import 'colorspage.dart';
import 'delivery_boy.dart';

class DeliveryBoyDetails extends StatefulWidget {
  final String boyname;

  DeliveryBoyDetails({this.boyname});

  @override
  State<StatefulWidget> createState() {
    DeliveryBoyDetailsState deliveryBoyDetailsState() =>
        new DeliveryBoyDetailsState();
    return deliveryBoyDetailsState();
  }
}

class DeliveryBoyDetailsState extends State<DeliveryBoyDetails>
    with SingleTickerProviderStateMixin {
  TabController deliverycontroller;

  @override
  void initState() {
    super.initState();
    deliverycontroller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    deliverycontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
         fontFamily: 'Georgia'
      ),
      home: Scaffold(
        appBar: AppBar(
            title: Text(widget.boyname),
            backgroundColor: secondarycolor,
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new DeliveryBoy()));
                }),
            bottom: TabBar(
              controller: deliverycontroller,
              indicatorColor: Colors.white,
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
            )),
        body: TabBarView(
          controller: deliverycontroller,
          children: <Widget>[DeliveryBoyFragments(), DeliveryBoyFragments(), DeliveryBoyFragments()],
        ),
      ),
    );
  }
}
