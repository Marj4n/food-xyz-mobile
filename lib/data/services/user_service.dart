import 'package:dio/dio.dart';
import '../requests/login_request.dart';
import '../responses/login_response.dart';
import '../requests/daftar_request.dart';
import '../responses/user_response.dart';

class UserService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://80c6-202-73-27-104.ngrok-free.app/api/",
      headers: {"Content-Type": "application/json"},
    ),
  );

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _dio.post("login", data: request.toJson());

    return LoginResponse.fromJson(response.data);
  }

  Future<UserResponse> daftar(DaftarRequest request) async {
    final response = await _dio.post("daftar", data: request.toJson());

    return UserResponse.fromJson(response.data);
  }

  Future<UserResponse> whoami(String token) async {
    final response = await _dio.get(
      "whoami",
      options: Options(headers: {"authorization": token}),
    );
    return UserResponse.fromJson(response.data);
  }
}
