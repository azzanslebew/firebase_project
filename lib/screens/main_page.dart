import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/bottom_nav_controller.dart';
import 'pages/grade_page.dart';
import 'pages/student_page.dart';
import 'pages/profile_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    BottomNavController bottomNavController = Get.find();

    List<Widget> pages = [
      StudentPage(),
      GradePage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: bottomNavController.selectedIndex.value,
          children: pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: bottomNavController.selectedIndex.value,
          onTap: bottomNavController.changePage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Student',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Grade',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
