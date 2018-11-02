import 'package:flutter/material.dart';

class DeliveryBoyAdapter extends StatelessWidget {
  final int index;

  DeliveryBoyAdapter(this.index);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Card(
        elevation: 6.0,
        margin: EdgeInsets.all(10.0),
        child: Table(
          children: [
            TableRow(children: [
              Container(
                margin: EdgeInsets.all(5.0),
                child: new Text(
                  'Order Number ',
                  style: TextStyle(fontSize: 14.0,),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                child: new Text(
                  ' : M3$index',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ]),
            TableRow(children: [
              Container(
                margin: EdgeInsets.all(5.0),
                child: new Text(
                  'Order Date ',
                  style: TextStyle(fontSize: 14.0,),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                child: new Text(
                  ' : 123456$index',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ]),
            TableRow(children: [
              Container(
                margin: EdgeInsets.all(5.0),
                child: new Text(
                  'No Of Items ',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                child: new Text(
                  ' : 2500$index',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ]),
            TableRow(children: [
              Container(
                margin: EdgeInsets.all(5.0),
                child: new Text(
                  'Amount ',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                child: new Text(
                  ' : Paid',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ]),
            TableRow(children: [
              Container(
                margin: EdgeInsets.all(5.0),
                child: new Text(
                  'Status ',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                child: new Text(
                  ' : Assigned',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ])
          ],
        ));
  }
}
