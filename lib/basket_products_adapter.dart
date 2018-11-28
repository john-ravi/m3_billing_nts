import 'package:flutter/material.dart';
import 'package:m3_billing_nts/model_product_items.dart';

class BasketProductAdapter extends StatefulWidget {
  final ModelProductItem item;

  BasketProductAdapter(this.item);

  @override
  BasketProductAdapterState createState() {
    return new BasketProductAdapterState();
  }
}

class BasketProductAdapterState extends State<BasketProductAdapter> {
  var _itemCount = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Card(
      elevation: 6.0,
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Table(
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
                    ' : ${widget.item.item_name}',
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
                    ' : ${widget.item.unit_cost}',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              ]),
            ],
          ),
          Row(
            children: <Widget>[
              _itemCount!=0? new  IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>_itemCount--),):new Container(),
              new Text(_itemCount.toString()),
              new IconButton(icon: new Icon(Icons.add),onPressed: ()=>setState(()=>_itemCount++))
            ],
          ),
        ],
      ),

    );
  }
}
