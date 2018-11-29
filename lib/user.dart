class User {
  String businessName = "";
  String mobile = "";
  String email = "";
  String password = "";
  String aadharCard = "";
  String username = "";

  String flatNo = "";
  String street = "";
  String area = "";
  String state = "";
  String city = "";
  String pincode = "";



  /*User(this.businessName, this.username, this.mobile, this.email, this.password,
      this.aadharCard);*/

  User();

  User.named({this.businessName, this.mobile, this.email, this.password,
      this.aadharCard, this.username, this.flatNo, this.street, this.area, this.state,
      this.city, this.pincode});

  User.fromMap(Map map) {
    businessName = map["businessName"];
    username = map[username];
    mobile = map[mobile];
    email = map[email];
    password = map[password];
    aadharCard = map[aadharCard];
  }

  @override
  String toString() {
    // TODO: implement toString
    return "User $username and mobile $mobile email $email";
  }
}
