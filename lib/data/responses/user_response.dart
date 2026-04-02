class UserResponse {
  final String? address;
  final String? name;
  final String? username;
  final String? image;

  UserResponse({this.address, this.name, this.username, this.image});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      address: json['address'],
      name: json['name'],
      username: json['username'],
      image: json['image'],
    );
  }
}
