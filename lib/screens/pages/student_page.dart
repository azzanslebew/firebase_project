import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/widgets/reusable_card.dart';
import 'package:get/get.dart';
import '../../controllers/student_controller.dart';
import '../../models/student.dart';
import '../../dialogs/student_dialog.dart';  // Import dialog yang telah kamu buat

class StudentPage extends StatelessWidget {
  final StudentController controller = Get.put(StudentController());

  StudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students', style: TextStyle(fontWeight: FontWeight.bold)),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(() {
        if (controller.isLoadingStudents.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.students.isEmpty) {
          return const Center(
            child: Text(
              'No students found',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(8.0), // Padding for the grid
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 10, // Space between columns
            mainAxisSpacing: 10, // Space between rows
            childAspectRatio: 1, // Aspect ratio for each item
          ),
          itemCount: controller.students.length,
          itemBuilder: (context, index) {
            final student = controller.students[index];
            return ReusableCard(
              student: student,
              onEdit: () => StudentDialog.showEditDialog(
                context, controller, student, // Memanggil dialog edit
              ),
              onDelete: () => _showDeleteConfirmation(context, student),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => StudentDialog.showAddDialog(context, controller), // Memanggil dialog add
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, dynamic student) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Student', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(
          'Are you sure you want to delete student "${student.name}"?',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.deleteStudent(student.id!);
              Get.back();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
