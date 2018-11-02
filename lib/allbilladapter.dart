import 'package:flutter/material.dart';

class AllAdapter extends StatelessWidget {
  final int index;

  AllAdapter(this.index);

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
                  'Customer Name ',
                  style: TextStyle(fontSize: 14.0),
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
                  'Invoice Number ',
                  style: TextStyle(fontSize: 14.0),
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
                  'Amount ',
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
                  'Status ',
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
            ])
          ],
        ));
  }
}
