import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';

class CalenderFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    CalenderFragmentState calenderFragmentState() =>
        new CalenderFragmentState();
    return calenderFragmentState();
  }
}

class CalenderFragmentState extends State<CalenderFragment> {
  String datevalue;
  void handleNewDate(date) {
    print(date);
    setState(() {
      datevalue = date.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
         fontFamily: 'Georgia'
      ),
      debugShowCheckedModeBanner: false,
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
              elevation: 6.0,
              margin: EdgeInsets.all(10.0),
              child: CustomScrollView(
                slivers: <Widget>[
                  new SliverList(
                    delegate: new SliverChildListDelegate(
                      <Widget>[
                        new Calendar(
                          onDateSelected: (date) => handleNewDate(date),
                        ),
                      ],
                    ),
                  ),
                  new SliverList(
                    delegate: new SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return GestureDetector(
                        child: Container(
                            margin: EdgeInsets.all(4.0),
                            child: new Card(
                                elevation: 6.0,
                                margin: EdgeInsets.all(10.0),
                                child: Table(
                                  children: [
                                    TableRow(children: [
                                      Container(
                                        margin: EdgeInsets.all(5.0),
                                        child: new Text(
                                          'Customer Name ',
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
                                          'Invoice Number ',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5.0),
                                        child: new Text(
                                          ' : 123456$index',
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
                                          'Amount ',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5.0),
                                        child: new Text(
                                          ' : 2500$index',
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
                                          'Status ',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5.0),
                                        child: new Text(
                                          ' : Paid',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              ),
                                        ),
                                      ),
                                    ])
                                  ],
                                ))),
                      );
                    }, childCount: 20),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
