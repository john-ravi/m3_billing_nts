import 'package:flutter/material.dart';
import 'package:m3_billing_nts/model_bills.dart';

class AllAdapter extends StatelessWidget {
  final Bills bill;

  AllAdapter(this.bill);

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
                  ' : ${bill.customer_name}',
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
                  ' : ${bill.invoice_number}',
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
                  ' : ${bill.amount}',
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
                  ' : ${bill.status}',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ])
          ],
        ));
  }
}
