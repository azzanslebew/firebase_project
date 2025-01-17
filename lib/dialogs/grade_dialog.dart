import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/grade.dart';
import '../controllers/grade_controller.dart';

class GradeDialog {

  // Menampilkan dialog untuk menambahkan grade
  static void showAddDialog(BuildContext context, GradeController controller) {
    final TextEditingController nameController = TextEditingController();

    _showDialog(
      context: context,
      title: 'Add Grade',
      controller: nameController,
      onConfirm: () {
        final gradeName = nameController.text.trim();

        if (gradeName.isEmpty) {
          Get.snackbar('Error', 'Please enter a valid grade name');
          return;
        }

        controller.addGrade(Grade(name: gradeName));
        Get.back();
        Get.snackbar('Success', 'Grade added successfully',
            duration: const Duration(seconds: 2));
      },
    );
  }

  // Menampilkan dialog untuk mengedit grade
  static void showEditDialog(
      BuildContext context, GradeController controller, Grade grade) {
    final TextEditingController nameController =
        TextEditingController(text: grade.name);

    _showDialog(
      context: context,
      title: 'Edit Grade',
      controller: nameController,
      onConfirm: () {
        final gradeName = nameController.text.trim();

        if (gradeName.isEmpty) {
          Get.snackbar('Error', 'Please enter a valid grade name');
          return;
        }

        controller.updateGrade(
          Grade(
            id: grade.id,
            name: gradeName,
          ),
        );
        Get.back();
        Get.snackbar('Success', 'Grade updated successfully',
            duration: const Duration(seconds: 2));
      },
    );
  }

  // Fungsi privat untuk menampilkan dialog umum
  static void _showDialog({
    required BuildContext context,
    required String title,
    required TextEditingController controller,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Grade Name'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: onConfirm,
            child: Text(title == 'Add Grade' ? 'Add' : 'Save Changes'),
          ),
        ],
      ),
    );
  }
}