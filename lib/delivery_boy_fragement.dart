import 'package:flutter/material.dart';
import 'deliveryboyadapter.dart';

class DeliveryBoyFragments extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    DeliveryBoyFragmentsState deliveryBoyFragmentsState() => new DeliveryBoyFragmentsState();
    return deliveryBoyFragmentsState();
  }
}

class DeliveryBoyFragmentsState extends State<DeliveryBoyFragments> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
         fontFamily: 'Georgia'
      ),
      home: new Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return Stack(
              children: <Widget>[
                new Image.asset(
                  'assets/images/bg.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                ListView.builder(
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                      child: DeliveryBoyAdapter(index),
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
