class Customer {
  String customer_name;
  String contact_number;
  String email = "";
  String gst_number = "";
  String address = "";
  String city = "";
  String state = "";
  String pincode = "";

  Customer(this.customer_name, this.contact_number);

  Customer.fromMap(Map map) {

    customer_name = map[customer_name];
    contact_number = map[contact_number];
    email = map[email];
    gst_number = map[gst_number];
    address = map[address];
    city = map[city];
    state = map[state];
    pincode = map[pincode];
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Name: $customer_name \t Mobile: $contact_number" ;
  }
}
