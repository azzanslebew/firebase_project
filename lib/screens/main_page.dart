import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
              activeIcon: Icon(Icons.people),
              icon: Icon(Icons.people_outline),
              label: 'Student',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.school),
              icon: Icon(Icons.school_outlined),
              label: 'Grade',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: GoogleFonts.manrope(fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.manrope(),
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
