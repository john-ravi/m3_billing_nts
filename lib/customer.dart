class Customer {
  String customer_name;
  String contact_number;
  String email = "";
  String gst_number = "";
  String address = "";
  String city = "";
  String state = "";
  String pincode = "";
  String id = "";

  Customer(this.customer_name, this.contact_number);


  Customer.includeId(String customer_name, contact_number, String id){
    customer_name = customer_name;
    contact_number = contact_number;
    id = id;

  }

  Customer.fromMap(Map map) {

    customer_name = map[customer_name];
    contact_number = map[contact_number];
    email = "";
    gst_number = "";
    address = "";
    city = "";
    state = "";
    pincode = "";
    id = map[id];
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Name: $customer_name \t Mobile: $contact_number \t ID: $id" ;
  }
}
