import 'package:flutter_firebase_project/bindings/auth_binding.dart';
import 'package:get/get.dart';

import '../screens/auth/login_page.dart';

class MyAppRoute {
  static const login = '/login';
}

class AppPages {
  static final pages = [
    GetPage(
        name: MyAppRoute.login,
        page: () => const LoginPage(),
        binding: AuthBinding()),
  ];
}
