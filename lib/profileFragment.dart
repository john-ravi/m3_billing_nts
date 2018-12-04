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

String superState = "", superCity = "";

class ProfileFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    ProfileFragmentState profileState() => new ProfileFragmentState();
    return profileState();
  }
}

class ProfileFragmentState extends State<ProfileFragment> {
  String name = "";
  String mobile = "";
  String city = "";
  String state = "Tap to Select State";
  bool stateSelected = false;
  bool citySelected = false;
  List<User> listUser = new List();

  TextEditingController cntrlFlatNo = new TextEditingController();
  TextEditingController cntrlEmail = new TextEditingController();
  TextEditingController cntrlStreet = new TextEditingController();
  TextEditingController cntrlArea = new TextEditingController();
  TextEditingController cntrlPincode = new TextEditingController();

  List listJsonArray;
  User user;
  List listCities = new List();

  String text;
  var mapStatesToId;

  FocusNode focusState = new FocusNode();

  @override
  void initState() {
    initEverything();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void stateListener() async {
    dialogForState(listStates);
  }

  void initEverything() async {
    focusState.addListener(stateListener);
    print("added State Foucs listener");
    await showProfileFromPrefs();
    await getProfile().then((_) {
      print("After Get Profile");
      setState(() {});
    });

    mapStatesToId = await getStates();
    listStates = mapStatesToId.keys.toList();
    setState(() {});
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
        "state": superState,
        // validations are done on superStateCity vars as they are ""
        "city": superCity,
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

          await updateProfilePrefs();
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
      print("PRINTING ERROR \n $e");

      // await Duration()
    }
    listUser = new List();

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
state
city
pincode

    */

          listUser.add(User.named(
              mobile: rowUser["mobile_number"],
              id: rowUser["id"],
              email: rowUser["email_id"],
              username: rowUser["user_name"],
              flatNo: rowUser["flat_no"],
              street: rowUser["street"],
              area: rowUser["area"],
              state: rowUser["state"],
              city: rowUser["city"],
              pincode: rowUser["pincode"]));
          print("List as Whiole \t" + listUser.toString());
        });

        setState(() {
          user = listUser[0] ?? new User();
          cntrlPincode.text = user.pincode ?? "";
          cntrlArea.text = user.area ?? "";
          cntrlStreet.text = user.street ?? "";
          cntrlFlatNo.text = user.flatNo ?? "";
          cntrlEmail.text = user.email ?? "";
          state = user.state ?? "";
          city = user.city ?? "";
          name = user.username ?? "";
          mobile = user.mobile ?? "";

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
                                name ?? "",
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
                                mobile ?? "",
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
                GestureDetector(
                  onTap: () => dialogForState(listStates),
                  child: Container(
                    margin: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.home,
                          color: secondarycolor,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(bottom: 10.0),
                                    child: Text(
                                      'Tap to Select State',
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.grey),
                                    )),
                                Container(
                                  child: Text(
                                    state ?? "",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (stateSelected) {
                      dialogForCity();
                    } else {
                      s(context, "Please Select State To Filter Cities");
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
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
                                    'City',
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.grey),
                                  )),
                              Container(
                                child: Text(
                                  city ?? "",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                new Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 4.0, right: 16.0),
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

  dialogForCity() async {
    superCity = "";

    var stateID = mapStatesToId[superState];
    print("States ${mapStatesToId.toString()} \n StateID $stateID}");

    showloader(context);
    try {
      listCities = await getCitiesUtils(stateID);
    } catch (e) {
      print(e);
      removeloader();
    }

    removeloader();
    print("after ge cities ${listCities.toString()}");
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SearchDialogWidget(false, listCities),
            ));
    print("Returned $superCity ");

    if (superCity != "") {
      city = superCity ?? "";
    } else {
      city = "";
    }
    setState(() {});
  }

  dialogForState(List<String> listValuesString) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SearchDialogWidget(true, listValuesString),
            ));

    print("Returned State $superState ");
    state = superState ?? "";
    if (superState != "") {
      setState(() {
        city = "Tap To Select City";
        stateSelected = true;
      });
      dialogForCity();
    }
  }

  showProfileFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("Showing from prefs ${prefs.getString(CURRENT_USER)} \n "
        "prefs: ${prefs.toString()}");

    name = prefs.getString(CURRENT_USER_NAME);
    mobile = prefs.getString(CURRENT_USER);
    cntrlEmail.text = prefs.getString(CURRENT_USER_EMAIL);
    cntrlFlatNo.text = prefs.getString(CURRENT_USER_FLAT_NO);
    cntrlArea.text = prefs.getString(CURRENT_USER_AREA);
    state = prefs.getString(CURRENT_USER_STATE);
    city = prefs.getString(CURRENT_USER_CITY);
    cntrlPincode.text = prefs.getString(CURRENT_USER_PINCODE);

    setState(() {

    });
  }

  updateProfilePrefs() async {
    SharedPreferences prefs = await saveUserInPrefs(user);

    print("Updated Prefs ${prefs.toString()}");
  }
}

class SearchDialogWidget extends StatefulWidget {
  final List<String> listStrings;
  final bool isStateSearch;

  SearchDialogWidget(this.isStateSearch, this.listStrings);

  @override
  _SearchDialogWidgetState createState() => _SearchDialogWidgetState();
}

class _SearchDialogWidgetState extends State<SearchDialogWidget> {
  TextEditingController controllerSearch = new TextEditingController();
  FocusNode focusNodeSearch = new FocusNode();
  List<String> finalList = new List();

  String stringSearch = "";

  @override
  void initState() {
    if (widget.isStateSearch) {
      stringSearch = 'Search State';
    } else {
      stringSearch = 'Search City';
    }

    controllerSearch.addListener(searchListener);
    focusNodeSearch.addListener(searchListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.all(7.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(7.0)),
          hintText: stringSearch,
          hintStyle: TextStyle(color: Colors.white, fontSize: 18.0),
          labelText: stringSearch,
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
                print(
                    "Lsit Tapped ${finalList[index]} and \nfinal list ${finalList.toString()}");

                if (widget.isStateSearch) {
                  superState = finalList[index];
                } else {
                  superCity = finalList[index];
                }

                setState(() {});
                Navigator.of(context).pop();
                /** dont assign the selected value to controller before this;
                 *  makes index value unusable after tapping*/
                controllerSearch.text = finalList[index];
              },
              child: new ListTile(title: new Text(finalList[index])),
            );
          },
          itemCount: finalList.length,
          shrinkWrap: true,
        ),
      ),
    ]);
  }

  void searchListener() {
    if (controllerSearch.text.isEmpty) {
      finalList = widget.listStrings;
    } else {
      List<String> searchList = new List();
      widget.listStrings.forEach((string) {
        if (string
            .toLowerCase()
            .contains(controllerSearch.text.toLowerCase())) {
          searchList.add(string);
        }
      });

      finalList = searchList;
    }
    setState(() {});
  }
}
