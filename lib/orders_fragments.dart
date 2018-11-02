import 'package:flutter/material.dart';

class OrderFragments extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    OrderFragmentState orderFragmentState() => new OrderFragmentState();
    return orderFragmentState();
  }
}

class OrderFragmentState extends State<OrderFragments> {
  List<String> orderslist = new List();

  @override
  void initState() {
    super.initState();
    orderslist.add('PENDING ORDERS');
    orderslist.add('DELIVERED ORDERS');
    orderslist.add('TOTAL ORDERS');
    orderslist.add('CHANGE IN ORDERS');
    orderslist.add('QUANTITES REQUIRED');
    orderslist.add('DELIVERY BOY AVAILABLE');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
         fontFamily: 'Georgia'
      ),
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            new Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              elevation: 6.0,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverGrid(
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.0,
                    ),
                    delegate: new SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return new Container(
                          margin: EdgeInsets.all(2.0),
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(5.0),
                              border: new Border.all(
                                  color: Colors.black, width: 2.0)),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    '129',
                                    style:
                                        TextStyle(),
                                  )),
                              Container(
                                  child: Text(
                                orderslist[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              )),
                            ],
                          ),
                        );
                      },
                      childCount: 6,
                    ),
                  ),
                  new SliverList(
                  delegate: new SliverChildListDelegate(
                    <Widget>[
                      new Container(
                        margin:
                            EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                        child: Text('QUANTITIES REQUIRED'))
                    ],
                  ),
                ),
                new SliverList(
                  delegate: new SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return GestureDetector(
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Table(
                              children: [
                                TableRow(children: [
                                  Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: new Text(
                                      'Name ',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: new Text(
                                      ' : M3$index',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          ),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: new Text(
                                      'Quantity ',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: new Text(
                                      ' : M3$index',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          ),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: new Text(
                                      'Delivery Boy ',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: new Text(
                                      ' : Available',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          ),
                                    ),
                                  ),
                                ])
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }, childCount: 20),
                )
                ],
              ),
            )
           
          ],
        ),
      ),
    );
  }
}
