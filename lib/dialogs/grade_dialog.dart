import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/grade.dart';
import '../controllers/grade_controller.dart';

class GradeDialog {
  // Menampilkan dialog untuk menambahkan grade
  static void showAddDialog(BuildContext context, GradeController controller) {
    final TextEditingController nameController = TextEditingController();
    final RxString errorText = ''.obs; // Validasi real-time

    _showDialog(
      context: context,
      title: 'Add Grade',
      controller: nameController,
      errorText: errorText,
      onConfirm: () {
        final gradeName = nameController.text.trim();
        if (gradeName.isEmpty) {
          errorText.value = 'Grade name cannot be empty';
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
    final RxString errorText = ''.obs; // Validasi real-time

    _showDialog(
      context: context,
      title: 'Edit Grade',
      controller: nameController,
      errorText: errorText,
      onConfirm: () {
        final gradeName = nameController.text.trim();
        if (gradeName.isEmpty) {
          errorText.value = 'Grade name cannot be empty';
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

  // Fungsi privat untuk menampilkan dialog umum (digunakan untuk Add dan Edit)
  static void _showDialog({
    required BuildContext context,
    required String title,
    required TextEditingController controller,
    required RxString errorText,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title == 'Add Grade'
                  ? 'Enter a new grade name below:'
                  : 'Update the grade name below:',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 10),
            Obx(
              () => TextField(
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Grade Name',
                  errorText: errorText.value.isNotEmpty ? errorText.value : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Enter grade name...',
                ),
                onChanged: (value) {
                  // Validasi real-time
                  if (value.trim().isEmpty) {
                    errorText.value = 'Grade name cannot be empty';
                  } else {
                    errorText.value = '';
                  }
                },
              ),
            ),
          ],
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
