class User {
  final String fullName;
  final String username;
  final String address;

  User({this.fullName = "", this.username = "", this.address = ""});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'] ?? '',
      username: json['username'] ?? '',
      address: json['address'] ?? '',
    );
  }
}
