import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/controllers/auth_controller.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Obx(() {
        final user = authController.user.value;
        
        if (user == null) {
          return Center(child: Text('Not logged in'));
        }

        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: user.photoURL != null
                    ? NetworkImage(user.photoURL!)
                    : null,
                child: user.photoURL == null
                    ? Icon(Icons.person, size: 50)
                    : null,
              ),
              SizedBox(height: 16),
              Text(
                user.displayName ?? 'No Name',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                user.email ?? 'No Email',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton.icon(
                icon: Icon(Icons.logout),
                label: Text('Logout'),
                onPressed: () => authController.signOut(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}