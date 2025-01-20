import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/student.dart';
import '../controllers/student_controller.dart';

class StudentDialog {
  static void showAddDialog(
      BuildContext context, StudentController controller) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final RxString selectedGrade = ''.obs;

    if (controller.grades.isEmpty) {
      Get.snackbar('Error', 'No grades available',
          duration: const Duration(seconds: 2));
      return;
    }

    selectedGrade.value = controller.grades.first.name;

    _showDialog(
      context: context,
      title: 'Add Student',
      nameController: nameController,
      ageController: ageController,
      selectedGrade: selectedGrade,
      grades: controller.grades.map((grade) => grade.name).toList(),
      isEdit: false,
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

  static void showEditDialog(
      BuildContext context, StudentController controller, Student student) {
    final nameController = TextEditingController(text: student.name);
    final ageController = TextEditingController(text: student.age.toString());
    final RxString selectedGrade = student.grade.obs;

    _showDialog(
      context: context,
      title: 'Edit Student',
      nameController: nameController,
      ageController: ageController,
      selectedGrade: selectedGrade,
      grades: controller.grades.map((grade) => grade.name).toList(),
      isEdit: true,
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

        controller.updateStudent(Student(
          id: student.id,
          name: name,
          age: int.parse(ageText),
          grade: grade,
        ));
        Get.back();
      },
    );
  }

  static void _showDialog({
    required BuildContext context,
    required String title,
    required TextEditingController nameController,
    required TextEditingController ageController,
    required RxString selectedGrade,
    required List<String> grades,
    required bool isEdit,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: GoogleFonts.manrope(),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  style: GoogleFonts.manrope(),
                  autofocus: true,
                ),
              ),
              if (!isEdit) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      labelStyle: GoogleFonts.manrope(),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    style: GoogleFonts.manrope(),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Obx(() {
                    return DropdownButtonFormField<String>(
                      value: selectedGrade.value,
                      decoration: InputDecoration(
                        labelText: 'Grade',
                        labelStyle: GoogleFonts.manrope(),
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                      items: grades
                          .map((grade) => DropdownMenuItem<String>(
                                value: grade,
                                child: Text(
                                  grade,
                                  style: GoogleFonts.manrope(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          selectedGrade.value = value;
                        }
                      },
                      style: GoogleFonts.manrope(fontSize: 16),
                    );
                  }),
                ),
              ],
              if (isEdit) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: ageController,
                          decoration: InputDecoration(
                            labelText: 'Age',
                            labelStyle: GoogleFonts.manrope(),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          style: GoogleFonts.manrope(),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        flex: 2,
                        child: Obx(() {
                          return DropdownButtonFormField<String>(
                            value: selectedGrade.value,
                            decoration: InputDecoration(
                              labelText: 'Grade',
                              labelStyle: GoogleFonts.manrope(),
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                              ),
                            ),
                            items: grades
                                .map((grade) => DropdownMenuItem<String>(
                                      value: grade,
                                      child: Text(
                                        grade,
                                        style: GoogleFonts.manrope(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                selectedGrade.value = value;
                              }
                            },
                            style: GoogleFonts.manrope(fontSize: 16),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ]
            ],
          ),
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
              title == 'Add Student' ? 'Add' : 'Save Changes',
              style: GoogleFonts.manrope(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
