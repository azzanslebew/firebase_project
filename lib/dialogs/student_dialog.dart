import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/student_controller.dart';
import '../models/student.dart';

class StudentDialog {
  // Menampilkan dialog untuk menambahkan student
  static void showAddDialog(
      BuildContext context, StudentController controller) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final RxString selectedGrade = ''.obs;

    // Cek apakah grades tersedia
    if (controller.grades.isEmpty) {
      Get.snackbar('Error', 'No grades available',
          duration: const Duration(seconds: 2));
      return;
    }

    // Set nilai default untuk grade
    selectedGrade.value = controller.grades.first.name;

    _showDialog(
      context: context,
      title: 'Add Student',
      nameController: nameController,
      ageController: ageController,
      selectedGrade: selectedGrade,
      grades: controller.grades.map((grade) => grade.name).toList(),
      onConfirm: () {
        final name = nameController.text.trim();
        final ageText = ageController.text.trim();
        final grade = selectedGrade.value;

        if (name.isEmpty || ageText.isEmpty || grade.isEmpty) {
          Get.snackbar('Error', 'Please fill all fields');
          return;
        }

        if (int.tryParse(ageText) == null) {
          Get.snackbar('Error', 'Age must be a valid number');
          return;
        }

        controller.addStudent(Student(
          name: name,
          age: int.parse(ageText),
          grade: grade,
        ));
        Get.back();
      },
    );
  }

  // Fungsi privat untuk menampilkan dialog umum
  static void _showDialog({
    required BuildContext context,
    required String title,
    required TextEditingController nameController,
    required TextEditingController ageController,
    required RxString selectedGrade,
    required List<String> grades,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              autofocus: true,
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            Obx(() {
              return DropdownButton<String>(
                value: selectedGrade.value,
                items: grades
                    .map((grade) => DropdownMenuItem<String>(
                          value: grade,
                          child: Text(grade),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    selectedGrade.value = value;
                  }
                },
              );
            }),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: onConfirm,
            child: Text(title == 'Add Student' ? 'Add' : 'Save Changes'),
          ),
        ],
      ),
    );
  }
}