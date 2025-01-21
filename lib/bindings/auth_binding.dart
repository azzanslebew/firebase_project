import 'package:flutter_firebase_project/controllers/auth_controller.dart';
import 'package:flutter_firebase_project/services/auth_service.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService());
    Get.put(AuthController());
  }
}
