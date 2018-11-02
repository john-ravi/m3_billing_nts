import 'package:flutter/material.dart';
import 'allbilladapter.dart';

class AllFragments extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    AllFragmentsState allFragmentsState() => new AllFragmentsState();
    return allFragmentsState();
  }
}

class AllFragmentsState extends State<AllFragments> {
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
                      child: AllAdapter(index),
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
