class User {
  String businessName;
  String mobile;
  String email;
  String password;
  String aadharCard;
  String username;



  User(this.businessName, this.username, this.mobile, this.email, this.password,
      this.aadharCard);

  User.fromMap(Map map) {
    businessName = map[businessName];
    username = map[username];
    mobile = map[mobile];
    email = map[email];
    password = map[password];
    aadharCard = map[aadharCard];
  }
}
