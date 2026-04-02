class LoginResponse {
  final int status;
  final String? message;
  final String? data;

  LoginResponse({required this.status, this.message, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}
