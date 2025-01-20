import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/grade.dart';
import '../controllers/grade_controller.dart';

class GradeDialog {
  static void showAddDialog(BuildContext context, GradeController controller) {
    final TextEditingController nameController = TextEditingController();
    final RxString errorText = ''.obs;

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

  static void showEditDialog(
      BuildContext context, GradeController controller, Grade grade) {
    final TextEditingController nameController =
        TextEditingController(text: grade.name);
    final RxString errorText = ''.obs;

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
        title: Text(
          title,
          style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Obx(
              () => TextField(
                controller: controller,
                autofocus: true,
                style: GoogleFonts.manrope(),
                decoration: InputDecoration(
                  labelText: 'Grade Name',
                  labelStyle: GoogleFonts.manrope(),
                  errorText:
                      errorText.value.isNotEmpty ? errorText.value : null,
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
            child: Text(
              'Cancel',
              style: GoogleFonts.manrope(color: Colors.red),
            ),
          ),
          ElevatedButton(
            onPressed: onConfirm,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Text(
              title == 'Add Grade' ? 'Add' : 'Save Changes',
              style: GoogleFonts.manrope(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
