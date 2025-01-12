import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.put(AuthService());
  final _auth = FirebaseAuth.instance;

  final Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _authService.signInWithEmailAndPassword(email, password);
  }

  Future<void> signInWithGoogle() async {
    await _authService.signInWithGoogle();
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
