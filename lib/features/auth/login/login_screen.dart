import 'package:flutter/material.dart';
import 'login_controller.dart';
import '../register/register_screen.dart';
import '../../home/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = LoginController();

  String? usernameError;
  String? passwordError;

  void handleLogin() async {
    setState(() {
      usernameError = controller.usernameController.text.isEmpty
          ? "Username tidak boleh kosong"
          : null;
      passwordError = controller.passwordController.text.isEmpty
          ? "Password tidak boleh kosong"
          : null;
    });

    if (usernameError != null || passwordError != null) return;

    try {
      final token = await controller.login();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", token ?? "");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login berhasil")));

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login gagal")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset("assets/images/shop.png", height: 240),

                const SizedBox(height: 50),

                const Text(
                  "Login",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 30),

                // USERNAME
                TextField(
                  controller: controller.usernameController,
                  decoration: InputDecoration(
                    labelText: "Username *",
                    hintText: "Masukan username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorText: usernameError,
                  ),
                ),

                const SizedBox(height: 16),

                // PASSWORD
                TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password *",
                    hintText: "Masukan password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorText: passwordError,
                  ),
                ),

                const SizedBox(height: 20),

                // LOGIN BUTTON
                ValueListenableBuilder(
                  valueListenable: controller.isLoading,
                  builder: (_, isLoading, __) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : handleLogin,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Colors.blue,
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Login"),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.grey[400],
                    ),
                    child: const Text("Daftar"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
