import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m3_billing_nts/user.dart';
import 'package:m3_billing_nts/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colorspage.dart';
import 'home.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

List<String> listStates = new List();
List<String> listCities = new List();

String superState, superCity;

class ProfileFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    ProfileFragmentState profileState() => new ProfileFragmentState();
    return profileState();
  }
}

class ProfileFragmentState extends State<ProfileFragment> {
  String flatNo = "";
  String name = "";
  String mobile = "";
  String email, street, area, city, pincode;

  TextEditingController cntrlFlatNo = new TextEditingController();
  TextEditingController cntrlEmail = new TextEditingController();
  TextEditingController cntrlStreet = new TextEditingController();
  TextEditingController cntrlArea = new TextEditingController();
  TextEditingController cntrlCity = new TextEditingController();
  TextEditingController cntrlPincode = new TextEditingController();
  TextEditingController cntrlState = new TextEditingController();

  List listJsonArray;
  User user;

  String text;
  Future<Map> states;

  FocusNode focusState = new FocusNode();

  @override
  void initState() {

    initEverything();
    focusState.addListener(stateListener);
    cntrlState.addListener(stateListener);
    super.initState();
  }

  void stateListener() {
    dialogForState(cntrlState.text, listStates);
  }

  void initEverything() async {
    await getProfile().then((_) {
      print("After Get Profile");
      setState(() {

      });
      states = getStates();
      states.then((onValue) {
        listStates = onValue.keys.toList();
        setState(() {

        });
      });
    });
  }

  void updateAddress(BuildContext context) async {
    if (cntrlEmail.text.isNotEmpty && !isEmail(cntrlEmail.text)) {
      s(context, "Please Enter a Valid Email");
    } else {
      var uri = Uri.http(authority, unencodedPath, {
        "page": "updateProfile",
        "email_id": cntrlEmail.text,
        "flat_no": cntrlFlatNo.text,
        "street": cntrlStreet.text,
        "area": cntrlArea.text,
        "city": cntrlCity.text,
        "pincode": cntrlPincode.text,
        "mobile_number": user.mobile
        /** Not updating mobile but passing for where mobile = clause*/
      });

      /*

user_id
user_name
email_id
flat_no
street
area
city
pincode
*/

      d(uri);
      http.Response registerUserResponse = await http.get(uri);

      if (registerUserResponse.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        var decodedBody = json.decode(registerUserResponse.body);
        print("decoded body \t" + decodedBody.toString());
        if (decodedBody['response'].toString().compareTo("success") == 0) {
          s(context, "Successfully Updated ${user.username}");
          Fluttertoast.showToast(
              msg: "Successfully Updated ${user.username}",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 4,
              textcolor: '#ffffff');
        } else {
          s(context, "Failed Update, please retry");
        }
      } else {
        print("Please Check Network: ");
      }

      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => new Home()));
    }
  } // UPDATE Adress

  Future<void> getProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = preferences.getString(CURRENT_USER);

    print("USer Id is $userId");
    var uri = Uri.http(
        authority, unencodedPath, {"page": "getMyProfile", "user_id": userId});

    d(uri);
    http.Response registerUserResponse;
    try {
      registerUserResponse = await http.get(uri);
    } catch (e) {
      print(e);

      // await Duration()
    }
    List<User> listUser = new List();

    if (registerUserResponse.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var decodedBody = json.decode(registerUserResponse.body);
      if (decodedBody['response'].toString().compareTo("success") == 0) {
        print("decoded body \t" + decodedBody.toString());
        listJsonArray = decodedBody["body"];

        print("List \t" + listJsonArray.toString() + "\n");

        listJsonArray.forEach((rowUser) {
          print(rowUser.toString());
          /*
+ Options
Full texts
user_id
user_name
email_id
mobile_number
user_password
aadhar_card
registration_date
flat_no
street
area
city
pincode

    */

          listUser.add(User.named(
              mobile: rowUser["mobile_number"],
              email: rowUser["email_id"],
              username: rowUser["user_name"],
              flatNo: rowUser["flat_no"],
              street: rowUser["street"],
              area: rowUser["area"],
              city: rowUser["city"],
              pincode: rowUser["pincode"]));
          print("List as Whiole \t" + listUser.toString());
        });

        setState(() {
          user = listUser[0];
          cntrlPincode.text = user.pincode;
          cntrlCity.text = user.city;
          cntrlArea.text = user.area;
          cntrlStreet.text = user.street;
          cntrlFlatNo.text = user.flatNo;
          cntrlEmail.text = user.email;
          name = user.username;
          mobile = user.mobile;

          print("My Profile PRINTING $user");
        });
      } else {
        print("Couldn't fetch rows, please check");
      }
    } else {
      print("Error Fetching States, Check Network: In Utility");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Image.asset(
          'assets/images/bg.png',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Container(
          margin: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 42.0),
          child: Card(
            elevation: 6.0,
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.user,
                        color: secondarycolor,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.grey),
                                )),
                            Container(
                              child: Text(
                                name,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.mobileAlt,
                        color: secondarycolor,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  'Mobile',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.grey),
                                )),
                            Container(
                              child: Text(
                                mobile,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                new Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.envelope,
                        color: secondarycolor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                      ),
                      Expanded(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new TextField(
                              decoration: const InputDecoration(
                                labelText: 'Email:',
                                hintText: 'Email',
                              ),
                              maxLines: 1,
                              controller: cntrlEmail,
                            ),
                            const Padding(padding: EdgeInsets.only(top: 8.0)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                new Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.home,
                        color: secondarycolor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                      ),
                      Expanded(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new TextField(
                              decoration: const InputDecoration(
                                labelText: 'Flat/House No:',
                                hintText: 'Flat/House No:',
                              ),
                              maxLines: 1,
                              controller: cntrlFlatNo,
                            ),
                            const Padding(padding: EdgeInsets.only(top: 8.0)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                new Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.home,
                        color: secondarycolor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                      ),
                      Expanded(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new TextField(
                              decoration: const InputDecoration(
                                labelText: 'Street:',
                                hintText: 'Street',
                              ),
                              maxLines: 1,
                              controller: cntrlStreet,

                              focusNode: focusState,
                            ),
                            const Padding(padding: EdgeInsets.only(top: 8.0)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                new Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.home,
                        color: secondarycolor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                      ),
                      Expanded(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new TextField(
                              decoration: const InputDecoration(
                                labelText: 'Area:',
                                hintText: 'Area:',
                              ),
                              maxLines: 1,
                              controller: cntrlArea,
                            ),
                            const Padding(padding: EdgeInsets.only(top: 8.0)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                new Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.home,
                        color: secondarycolor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                      ),
                      Expanded(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new TextField(
                              decoration: const InputDecoration(
                                labelText: 'State:',
                                hintText: 'State:',
                              ),
                              maxLines: 1,
                              controller: cntrlState,
                              onChanged: (text) =>
                                  dialogForState(text, listStates),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 8.0)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                new Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.home,
                        color: secondarycolor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                      ),
                      Expanded(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new TextField(
                              decoration: const InputDecoration(
                                labelText: 'City:',
                                hintText: 'City:',
                              ),
                              maxLines: 1,
                              controller: cntrlCity,
                              onChanged: (text) => dialodForCity(text),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 8.0)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                new Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.home,
                        color: secondarycolor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                      ),
                      Expanded(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new TextField(
                              decoration: const InputDecoration(
                                labelText: 'Pincode:',
                                hintText: 'Pincode:',
                              ),
                              maxLines: 1,
                              controller: cntrlPincode,
                            ),
                            const Padding(padding: EdgeInsets.only(top: 8.0)),
                          ],
                        ),
                      ),
                    ],
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
                updateAddress(context);
              },
              color: primarycolor,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              child: new Text('UPDATE ADDRESS',
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ],
    );
  }

  dialodForCity(String text) {
    showDialog(
        context: null,
        builder: (context) {
          Column body = new Column(children: [
            new ListTile(
              title: TextField(),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print("Lsit Tapped");
             //         addBoyToGroup(widget.listGroup[index]);
                    },
                    child: new ListTile(
                      title: new Text(listCities[index])),
                  );
                },
                itemCount: listCities.length,
                shrinkWrap: true,
              ),
            ),
          ]);

          return AlertDialog(
            content: body,
          );
        });
  }

  dialogForState(String text, List<String> listStates) {

    TextEditingController controllerSearch = new TextEditingController();
    FocusNode focusNodeSearch = new FocusNode();

    Column body = new Column(children: [
      TextField(
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.all(1.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0)),
          hintText: 'Search State',
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          labelText: 'Search State',
          labelStyle: TextStyle(
            color: Colors.black,
          ),
        ),
        keyboardType: TextInputType.text,
        autofocus: true,
        controller: controllerSearch,
        focusNode: focusNodeSearch,

      ),
      Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                superState = listStates[index];
                print("Lsit Tapped $superState");
                Navigator.pop(context);
                cntrlState.text = superState;
              },
              child: new ListTile(
                  title: new Text(listStates[index])),
            );
          },
          itemCount: listStates.length,
          shrinkWrap: true,
        ),
      ),
    ]);

    showDialog(context: context,
    builder: (context) => AlertDialog(content: body,));
  }
}
