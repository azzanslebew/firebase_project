import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_firebase_project/widgets/reusable_list_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(() {
        final user = authController.user.value;

        if (user == null) {
          return const Center(child: Text('Not logged in'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: user.photoURL != null
                          ? NetworkImage(user.photoURL!)
                          : null,
                      child: user.photoURL == null
                          ? const Icon(Icons.person, size: 50)
                          : null,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user.displayName ?? 'No Name',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.email ?? 'No Email',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Feature List
              const Text(
                'Features',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
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

              // Log Out button
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.red, // Red background
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: const Icon(Icons.logout, color: Colors.white), // White icon
                  title: const Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // White text
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.white), // White arrow
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Confirm Log Out'),
                        content: const Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red, // Red background
                            ),
                            onPressed: () {
                              authController.signOut();
                              Get.snackbar(
                                'Logout',
                                'You have successfully logged out.',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              Navigator.pop(context); // Close the dialog
                            },
                            child: const Text(
                              'Log Out',
                              style: TextStyle(
                                color: Colors.white, // White text
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
