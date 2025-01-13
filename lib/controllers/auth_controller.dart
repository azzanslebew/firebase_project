import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_project/routes/route.dart';
import 'package:flutter_firebase_project/services/notification_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService authService = Get.put(AuthService());
  final Rx<User?> user = Rx<User?>(null);
  final notification = NotificationService();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    user.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    isLoading.value = true;
    final userCredential = await authService.signInWithEmailAndPassword(
      email,
      password,
    );

    if (userCredential != null) {
      // Save login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      await notification.showNotification(
          title: 'Login Succesfully',
          body: 'Welcome ${userCredential.user?.email ?? "User"}!');

      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false;

      // Navigate to main page
      Get.offAllNamed(MyAppRoute.main);
    }
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    final userCredential = await authService.signInWithGoogle();

    if (userCredential != null) {
      // Save login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      await notification.showNotification(
          title: 'Login Succesfully',
          body: 'Welcome ${userCredential.user?.displayName ?? "User"}!');

      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false;

      // Navigate to main page
      Get.offAllNamed(MyAppRoute.main);
    }
  }

  Future<void> signOut() async {
    await authService.signOut();

    // Clear login state
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    // Navigate to login page
    Get.offAllNamed(MyAppRoute.login);
  }
}