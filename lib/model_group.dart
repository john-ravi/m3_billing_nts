class Group {


  /*
    /*
createGroup

Full texts
id
state
city
group_name
address
pincode
*/

*/
  String id;
  String state;
  String city = "";
  String group_name = "";
  String address = "";
  String pincode = "";

  Group({this.id, this.state, this.city, this.group_name, this.pincode, this.address});


  @override
  String toString() {
    // TODO: implement toString
    return "Name: $group_name \t City: $city " ;
  }
}
