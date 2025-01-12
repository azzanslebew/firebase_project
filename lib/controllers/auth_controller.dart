import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_project/routes/route.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService authService = Get.put(AuthService());
  final Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await authService.signInWithEmailAndPassword(
      email,
      password,
    );

    if (userCredential != null) {
      // Save login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      // Navigate to main page
      Get.offAllNamed(MyAppRoute.main);
    }
  }

  Future<void> signInWithGoogle() async {
    final userCredential = await authService.signInWithGoogle();

    if (userCredential != null) {
      // Save login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

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
