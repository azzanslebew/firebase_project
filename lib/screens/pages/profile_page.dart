import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/controllers/auth_controller.dart';
import 'package:flutter_firebase_project/widgets/reusable_app_bar.dart';
import 'package:flutter_firebase_project/widgets/reusable_button.dart';
import 'package:flutter_firebase_project/widgets/reusable_list_item.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: const ReusableAppBar(
        title: 'Profile',
        fontSize: 24,
        titleColor: Colors.white,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Obx(() {
                final user = authController.user.value;

                if (user == null) {
                  return const Center(child: Text('Not logged in'));
                }

                return Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blueAccent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: user.photoURL != null
                            ? NetworkImage(user.photoURL!)
                            : null,
                        child: user.photoURL == null
                            ? const Icon(Icons.person,
                                size: 50, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.displayName ?? 'No Name',
                            style: GoogleFonts.manrope(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user.email ?? 'No Email',
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 16),
              // Personal Information
              ReusableListItem(
                icon: Icons.person,
                title: 'Personal Information',
                onTap: () {
                  // Navigate to Personal Information Page
                },
              ),

              // Academic Information
              ReusableListItem(
                icon: Icons.school,
                title: 'Academic Information',
                onTap: () {
                  // Navigate to Academic Information Page
                },
              ),

              // Settings
              ReusableListItem(
                icon: Icons.settings,
                title: 'Settings',
                onTap: () {
                  // Navigate to Settings Page
                },
              ),

              // Activity or Progress
              ReusableListItem(
                icon: Icons.bar_chart,
                title: 'Activity or Progress',
                onTap: () {
                  // Navigate to Activity or Progress Page
                },
              ),

              // Help and Support
              ReusableListItem(
                icon: Icons.help,
                title: 'Help and Support',
                onTap: () {
                  // Navigate to Help and Support Page
                },
              ),

              const SizedBox(height: 20),
              // Log Out Button
              ReusableButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'Confirm Logout',
                        style: GoogleFonts
                            .manrope(), // Apply Manrope font to title
                      ),
                      content: Text(
                        'Are you sure want to logout?',
                        style: GoogleFonts
                            .manrope(), // Apply Manrope font to content
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.manrope(
                                color: Colors
                                    .blueAccent), // Apply Manrope font to Cancel text
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, // Red background
                          ),
                          onPressed: () {
                            authController.signOut();
                            Get.back(); // Close the dialog
                          },
                          child: Text(
                            'Logout',
                            style: GoogleFonts.manrope(
                              color:
                                  Colors.white, // White text with Manrope font
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                category: 'Logout',
                backgroundColor: Colors.red,
                showBorder: false,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
