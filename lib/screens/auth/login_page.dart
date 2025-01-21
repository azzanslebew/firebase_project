// ignore_for_file: avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/widgets/reusable_app_bar.dart';
import 'package:flutter_firebase_project/widgets/reusable_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/auth_controller.dart';
import '../../widgets/reusable_button.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.find();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: const ReusableAppBar(
        title: 'Log in to your account',
        fontSize: 26,
        showIcon: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome to our app!',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  color: const Color(0xff757575),
                ),
              ),
              const SizedBox(height: 30),
              ReusableTextField(
                controller: emailController,
                labelText: 'Email',
                prefixIcon: Icons.email,
                isPassword: false,
              ),
              const SizedBox(height: 16),
              ReusableTextField(
                controller: passwordController,
                labelText: 'Password',
                prefixIcon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 16),
              Text(
                'Forgot your password?',
                style: GoogleFonts.manrope(color: Colors.blueAccent),
              ),
              const SizedBox(height: 16),
              ReusableButton(
                category: 'Log In',
                onPressed: () async {
                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();

                  if (email.isNotEmpty && password.isNotEmpty) {
                    try {
                      await authController.signInWithEmailAndPassword(
                          email, password);
                    } catch (e) {
                      print("Login error: $e"); // Untuk debugging
                    }
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
                backgroundColor: Colors.blueAccent,
                textColor: Colors.white,
                borderRadius: 12,
                elevation: 2,
                showBorder: false,
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              ReusableButton(
                onPressed: () async {
                  try {
                    await authController.signInWithGoogle();
                  } catch (e) {
                    print("Google sign in error: $e"); // Untuk debugging
                  }
                },
                category: 'Log In with Google',
                backgroundColor: const Color(0xffF5F5F5),
                textColor: Colors.blueAccent,
                borderRadius: 10.0,
                showIcon: true,
                isIconLeft: true,
                showBorder: true,
                icon: Icons.g_mobiledata,
              ),
              const SizedBox(height: 5),
              ReusableButton(
                onPressed: () {},
                category: 'Log In with Facebook',
                backgroundColor: const Color(0xffF5F5F5),
                textColor: Colors.blueAccent,
                borderRadius: 10.0,
                showIcon: true,
                isIconLeft: true,
                showBorder: true,
                icon: Icons.facebook,
              ),
              const SizedBox(height: 50),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: GoogleFonts.manrope(
                      color: const Color(0xff404040),
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: 'Register',
                        style: GoogleFonts.manrope(
                          color: Colors.blueAccent,
                          fontSize: 14,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
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
