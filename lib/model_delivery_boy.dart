class ModelDeliveryBoy {


/*
Full texts
id
boy_name
contact_number
available_status
address
city
state
pincode
*/


  String id;
  String boy_name;
  String contact_number;
  String available_status;
  String address;
  String city;
  String state;
  String pincode;


  ModelDeliveryBoy.named({this.id, this.boy_name, this.contact_number, this.available_status,
      this.address, this.city, this.state, this.pincode});





  @override
  String toString() {
    // TODO: implement toString
    return "Name: $boy_name \t Mobile: $contact_number \t ID: $available_status" ;
  }
}
