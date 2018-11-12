import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'colorspage.dart';
import 'delivery_boy.dart';

class CreateDeliveryBoy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    CreateDeliveryBoyState createDeliveryBoyState() =>
        new CreateDeliveryBoyState();
    return createDeliveryBoyState();
  }
}

class CreateDeliveryBoyState extends State<CreateDeliveryBoy> {

  TextEditingController boyName = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController mobile = new TextEditingController();
  TextEditingController city = new TextEditingController();
  TextEditingController state = new TextEditingController();
  TextEditingController pincode = new TextEditingController();




  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
         fontFamily: 'Georgia'
      ),
      home: Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          title: Text('Create Delivery Boy'),
          backgroundColor: secondarycolor,
          leading: new IconButton(
             iconSize: 18.0,
              icon: new Icon(FontAwesomeIcons.chevronLeft),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new DeliveryBoy()));
              }),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            new Center(
              child:  SingleChildScrollView(
                              child: SizedBox(
                  height: 450.0,
                  child: Builder(builder: (context) => buildStack(context)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Stack buildStack(BuildContext context) {
    return Stack(
                  children: <Widget>[
                    Container(
                      height: 440.0,
                      child: Card(
                        elevation: 6.0,
                        margin: EdgeInsets.all(10.0),
                        child: new Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              child: TextFormField(
                                controller: boyName,
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  hintText: 'Enter Delivery Boy Name',
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      ),
                                  labelText: 'Enter Delivery Boy Name',
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      ),
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              child: TextFormField(
                                controller: mobile,
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  hintText: 'Enter Contact Number',
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      ),
                                  labelText: 'Enter Contact Number',
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      ),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter
                                      .digitsOnly,
                                  LengthLimitingTextInputFormatter(
                                      10)],
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              child: Text('Assign to Group (Optional)',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      color: secondarycolor)),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              child: Text('Address Details (Optional)',
                                  style: TextStyle(
                                      fontSize: 16.0,

                                      color: Colors.black)),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              child: TextFormField(
                                controller: address,
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  hintText: 'Enter Address',
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      ),
                                  labelText: 'Enter Address',
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      ),
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              child: TextFormField(
                                controller: city,
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  hintText: 'City',
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      ),
                                  labelText: 'City',
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      ),
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              child: TextFormField(
                                controller: state,
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  hintText: 'State',
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      ),
                                  labelText: 'State',
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      ),
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10.0),
                              child: TextFormField(
                                controller: pincode,
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  hintText: 'Pincode',
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      ),
                                  labelText: 'Pincode',
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      ),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                WhitelistingTextInputFormatter
                                .digitsOnly,
                                LengthLimitingTextInputFormatter(
                                    6)],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: ConstrainedBox(
                        constraints: new BoxConstraints(minWidth: 250.0),
                        child: new RaisedButton(
                          onPressed: () {

                            createDeliveryBoy(context);
                          },
                          color: primarycolor,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          child: new Text('Create Customer',
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  )),
                        ),
                      ),
                    )
                  ],
                );
  }

  void createDeliveryBoy(BuildContext context) {



/*
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new DeliveryBoy()));
*/
  }
}
