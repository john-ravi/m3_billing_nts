import 'package:flutter/material.dart';

class ProductAdapter extends StatelessWidget {
  final int index;

  ProductAdapter(this.index);

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
                  'Item Name ',
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
                  'Unit Cost ',
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
                  'No Of Units ',
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
                  'Available From ',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                child: new Text(
                  ' : $index',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ]),
            TableRow(children: [
              Container(
                margin: EdgeInsets.all(5.0),
                child: new Text(
                  'Available To ',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                child: new Text(
                  ' : $index',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ]),
            TableRow(children: [
              Container(
                margin: EdgeInsets.all(5.0),
                child: new Text(
                  'Tax ',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                child: new Text(
                  ' : $index',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ])
          ],
        ));
  }
}
