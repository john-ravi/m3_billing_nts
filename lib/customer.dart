class Customer {
  String name;
  String mobile;
  String email;
  String gstNumber;
  String address;
  String city;
  String state;
  String pincode;


  Customer.fromMap(Map map) {

    name = map[name];
    mobile = map[mobile];
    email = map[email];
    gstNumber = map[gstNumber];
    address = map[address];
    city = map[city];
    state = map[state];
    pincode = map[pincode];
  }
}
