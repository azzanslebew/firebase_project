import 'package:flutter_firebase_project/bindings/auth_binding.dart';
import 'package:flutter_firebase_project/bindings/bottom_nav_binding.dart';
import 'package:flutter_firebase_project/screens/main_page.dart';
import 'package:get/get.dart';

import '../screens/auth/login_page.dart';

class MyAppRoute {
  static const login = '/login';
  static const main = '/main';
}

class AppPages {
  static final pages = [
    GetPage(
        name: MyAppRoute.login,
        page: () => const LoginPage(),
        binding: AuthBinding()),
    GetPage(
      name: MyAppRoute.main,
      page: () => const MainPage(),
      bindings: [
        BottomNavBinding(),
        AuthBinding(),
      ],
    ),
  ];
}
