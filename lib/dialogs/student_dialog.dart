import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/student.dart';
import '../controllers/student_controller.dart';

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
      isEdit: false,  // Menandakan bahwa ini adalah dialog "Add"
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

  // Menampilkan dialog untuk mengedit student
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
      isEdit: true,  // Menandakan bahwa ini adalah dialog "Edit"
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

  // Fungsi privat untuk menampilkan dialog umum
  static void _showDialog({
    required BuildContext context,
    required String title,
    required TextEditingController nameController,
    required TextEditingController ageController,
    required RxString selectedGrade,
    required List<String> grades,
    required bool isEdit,  // Menambahkan parameter isEdit untuk menentukan apakah dialog ini untuk edit atau add
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Nama Mahasiswa
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  autofocus: true,
                ),
              ),
              // Age Input Field untuk Add Student
              if (!isEdit) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    controller: ageController,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                // Grade Dropdown untuk Add Student
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Obx(() {
                    return DropdownButtonFormField<String>(
                      value: selectedGrade.value,
                      decoration: const InputDecoration(
                        labelText: 'Grade',
                        border: OutlineInputBorder(),
                      ),
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
                ),
              ],
              // Row untuk Edit Student: gabungkan Age dan Grade dalam satu baris
              if (isEdit) ...[
                Row(
                  children: [
                    // Age Input Field
                    Expanded(
                      flex: 1,  // Atur agar input Age mengambil lebih sedikit ruang
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 8.0, bottom: 8.0),
                        child: TextField(
                          controller: ageController,
                          decoration: const InputDecoration(
                            labelText: 'Age',
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    // Grade Dropdown
                    Expanded(
                      flex: 2,  // Atur agar dropdown Grade mengambil lebih banyak ruang
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Obx(() {
                          return DropdownButtonFormField<String>(
                            value: selectedGrade.value,
                            decoration: const InputDecoration(
                              labelText: 'Grade',
                              border: OutlineInputBorder(),
                            ),
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
                      ),
                    ),
                  ],
                ),
              ]
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: onConfirm,
            child: Text(
              title == 'Add Student' ? 'Add' : 'Save Changes',
              style: const TextStyle(fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: isEdit ? Colors.green : Colors.blueAccent,  // Ubah warna tombol berdasarkan jenis dialog
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
