import 'package:flutter/material.dart';
import '../../../data/requests/login_request.dart';
import '../../../data/services/user_service.dart';

class LoginController {
  final UserService _service = UserService();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<String?> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      throw Exception("Username & Password wajib diisi");
    }

    isLoading.value = true;

    try {
      final response = await _service.login(
        LoginRequest(username: username, password: password),
      );

      return response.data;
    } catch (e) {
      throw Exception("Login gagal");
    } finally {
      isLoading.value = false;
    }
  }
}
