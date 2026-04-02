import 'package:flutter/material.dart';
import '../../../data/requests/daftar_request.dart';
import '../../../data/services/user_service.dart';

class RegisterController {
  final UserService _service = UserService();

  final fullNameController = TextEditingController();
  final usernameController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> register() async {
    final fullName = fullNameController.text.trim();
    final username = usernameController.text.trim();
    final address = addressController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (fullName.isEmpty ||
        username.isEmpty ||
        address.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      throw Exception("Semua field wajib diisi");
    }

    if (password != confirmPassword) {
      throw Exception("Password tidak sama");
    }

    isLoading.value = true;

    try {
      await _service.daftar(
        DaftarRequest(
          username: username,
          password: password,
          nama: fullName,
          alamat: address,
          telpon: "-",
        ),
      );
    } catch (e) {
      throw Exception("Daftar gagal");
    } finally {
      isLoading.value = false;
    }
  }
}
