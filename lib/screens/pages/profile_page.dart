import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/controllers/auth_controller.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan instance AuthController menggunakan GetX
    final AuthController authController = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Obx(() {
        // Mendapatkan data user dari AuthController
        final user = authController.user.value;

        // Jika user null, tampilkan pesan bahwa belum login
        if (user == null) {
          return const Center(child: Text('Not logged in'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Menampilkan foto profil
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    user.photoURL != null ? NetworkImage(user.photoURL!) : null,
                child: user.photoURL == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
              const SizedBox(height: 16),

              // Menampilkan nama pengguna
              Text(
                user.displayName ?? 'No Name',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Menampilkan email pengguna
              Text(
                user.email ?? 'No Email',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Tombol logout
              ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                onPressed: () {
                  authController.signOut();
                  Get.snackbar(
                    'Logout',
                    'You have successfully logged out.',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
