import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController = Get.find();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: emailController,
              hintText: "Email",
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
            ),
            const SizedBox(height: 32),
            CustomButton(
              title: "Login with Email",
              onPressed: () {
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  Get.snackbar(
                    "Error",
                    "Please fill in both email and password.",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                } else {
                  authController.loginWithEmail(
                      emailController.text, passwordController.text);
                }
              },
            ),
            const SizedBox(height: 16),
            CustomButton(
              title: "Login with Google",
              onPressed: () {
                authController.loginWithGoogle();
              },
            ),
          ],
        ),
      ),
    );
  }
}
