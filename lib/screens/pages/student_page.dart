import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/widgets/reusable_app_bar.dart';
import 'package:flutter_firebase_project/widgets/reusable_card.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/student_controller.dart';
import '../../dialogs/student_dialog.dart';

class StudentPage extends StatelessWidget {
  final StudentController controller = Get.put(StudentController());

  StudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: const ReusableAppBar(
        title: 'Students',
        fontSize: 24,
        backgroundColor: Colors.blueAccent,
        titleColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.isLoadingStudents.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.students.isEmpty) {
          return Center(
            child: Text(
              'No students found',
              style: GoogleFonts.manrope(fontSize: 16, color: Colors.grey),
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemCount: controller.students.length,
          itemBuilder: (context, index) {
            final student = controller.students[index];
            return ReusableCard(
              student: student,
              onEdit: () => StudentDialog.showEditDialog(
                context,
                controller,
                student,
              ),
              onDelete: () => _showDeleteConfirmation(context, student),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => StudentDialog.showAddDialog(context, controller),
        backgroundColor: Colors.blueAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, dynamic student) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Student',
            style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
        content: Text(
          'Are you sure you want to delete student "${student.name}"?',
          style: GoogleFonts.manrope(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel',
                style: GoogleFonts.manrope(color: Colors.blueAccent)),
          ),
          TextButton(
            onPressed: () {
              controller.deleteStudent(student.id!);
              Get.back();
            },
            child:
                Text('Delete', style: GoogleFonts.manrope(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
