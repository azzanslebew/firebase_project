import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email & Password Login
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();

                  if (email.isNotEmpty && password.isNotEmpty) {
                    authController.signInWithEmailAndPassword(email, password);
                  } else {
                    Get.snackbar(
                      'Error',
                      'Please fill in all fields',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Login'),
              ),

              // OR divider
              const SizedBox(height: 16),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('OR'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              // Google Sign In Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.g_mobiledata),
                  label: const Text('Sign in with Google'),
                  onPressed: () => authController.signInWithGoogle(),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
