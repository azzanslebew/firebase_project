import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/student_controller.dart';
import '../../dialogs/student_dialog.dart';

class StudentPage extends StatelessWidget {
  final StudentController controller = Get.put(StudentController());

  StudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
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
        return ListView.builder(
          itemCount: controller.students.length,
          itemBuilder: (context, index) {
            final student = controller.students[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: ListTile(
                title: Text(
                  student.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Grade: ${student.grade} | Age: ${student.age}',
                  style: const TextStyle(color: Colors.black54),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => StudentDialog.showAddDialog(context, controller),
        child: const Icon(Icons.add),
      ), 
    );
  }
}