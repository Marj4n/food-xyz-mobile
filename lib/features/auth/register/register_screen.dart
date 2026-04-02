import 'package:flutter/material.dart';
import 'register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controller = RegisterController();

  void handleRegister() async {
    try {
      await controller.register();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Daftar sukses")));

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Daftar gagal")));
    }
  }

  Widget input({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: "$label *",
          hintText: "Masukan ${label.toLowerCase()}",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Silahkan isi data pribadi anda",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              input(
                label: "Nama Lengkap",
                controller: controller.fullNameController,
              ),
              input(
                label: "Username",
                controller: controller.usernameController,
              ),
              input(label: "Alamat", controller: controller.addressController),
              input(
                label: "Password",
                controller: controller.passwordController,
                isPassword: true,
              ),
              input(
                label: "Konfirmasi Password",
                controller: controller.confirmPasswordController,
                isPassword: true,
              ),

              const SizedBox(height: 20),

              ValueListenableBuilder(
                valueListenable: controller.isLoading,
                builder: (_, isLoading, __) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : handleRegister,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.blue,
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Daftar"),
                    ),
                  );
                },
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.grey[400],
                  ),
                  child: const Text("Sudah Punya Akun"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
