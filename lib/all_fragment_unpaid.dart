import 'package:flutter/material.dart';
import 'package:m3_billing_nts/bills_model.dart';
import 'allbilladapter.dart';

class AllFragmentsUnPaid extends StatefulWidget {
  List<Bills> listBills;
   List<Bills> finalBills = new List();

  AllFragmentsUnPaid(this.listBills){
   print("Paid Fragment");

   for(int i=0; i < listBills.length ; i++){

     if(listBills[i].status.compareTo("PAID") != 0) {
       finalBills.add(listBills[i]);

     }
   }
  }


  @override
  State<StatefulWidget> createState() {
    AllFragmentsStateUnPaid allFragmentsState() => new AllFragmentsStateUnPaid();
    return allFragmentsState();
  }
}

class AllFragmentsStateUnPaid extends State<AllFragmentsUnPaid> {
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
                  itemCount: widget.finalBills.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                      child: AllAdapter(widget.finalBills[index]),
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
