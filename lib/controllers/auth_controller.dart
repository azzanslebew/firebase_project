import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/routes/route.dart';
import 'package:flutter_firebase_project/services/notification_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService authService = Get.put(AuthService());
  final NotificationService notification = Get.put(NotificationService());

  final Rx<User?> user = Rx<User?>(null);
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    user.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      _showErrorSnackbar('Login Failed', 'Email and Password cannot be empty.');
      return;
    }

    _setLoading(true);

    try {
      final userCredential =
          await authService.signInWithEmailAndPassword(email, password);
      if (userCredential != null) {
        await _handleSuccessfulLogin(userCredential);
      }
    } catch (e) {
      _showErrorSnackbar('Login Failed', e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signInWithGoogle() async {
    _setLoading(true);

    try {
      final userCredential = await authService.signInWithGoogle();
      if (userCredential != null) {
        await _handleSuccessfulLogin(userCredential);
      }
    } catch (e) {
      _showErrorSnackbar('Google Sign-In Failed', e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    try {
      await authService.signOut();

      // Clear login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);

      // Navigate to login page
      Get.offAllNamed(MyAppRoute.login);
    } catch (e) {
      _showErrorSnackbar('Sign-Out Failed', e.toString());
    }
  }

  Future<void> _handleSuccessfulLogin(UserCredential userCredential) async {
    // Save login state
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    // Show notification
    await notification.showNotification(
      title: 'Login Successful',
      body:
          'Welcome ${userCredential.user?.displayName ?? userCredential.user?.email}!',
    );

    // Navigate to main page
    Get.offAllNamed(MyAppRoute.main);
  }

  void _setLoading(bool value) {
    isLoading.value = value;
  }

  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }
}
