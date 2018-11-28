import 'package:flutter/material.dart';
import 'package:m3_billing_nts/model_items.dart';

class ProductAdapter extends StatelessWidget {
  final ModelProductItem item;

  ProductAdapter(this.item);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Card(
        elevation: 6.0,
        margin: EdgeInsets.all(10.0),
        child: Table(
          border: TableBorder.all(width: 1.0, color: Colors.black54),
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
                  ' : ${item.item_name}',
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
                  ' : ${item.unit_cost}',
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
                  ' : ${item.no_of_units}',
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
                  ' : ${item.start_date}',
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
                  ' : ${item.end_date}',
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
                  ' : ${item.tax}',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ])
          ],
        ));
  }
}
