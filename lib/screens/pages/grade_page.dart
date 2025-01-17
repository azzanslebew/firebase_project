import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/grade_controller.dart';
import '../../dialogs/grade_dialog.dart';
import '../../models/grade.dart';

class GradePage extends StatelessWidget {
  final GradeController controller = Get.put(GradeController());

  GradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grades'),
        scrolledUnderElevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.grades.isEmpty) {
          return const Center(
            child: Text('No grades found',
                style: TextStyle(fontSize: 16, color: Colors.grey)),
          );
        }
        return ListView.builder(
          itemCount: controller.grades.length,
          itemBuilder: (context, index) {
            final grade = controller.grades[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: ListTile(
                title: Text(
                  grade.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => GradeDialog.showEditDialog(
                        context,
                        controller,
                        grade,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _showDeleteConfirmation(context, grade),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GradeDialog.showAddDialog(context, controller),
        child: const Icon(Icons.add),
      ), 
    );
  }

  void _showDeleteConfirmation(BuildContext context, Grade grade) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Grade'),
        content: Text(
          'Are you sure you want to delete the grade "${grade.name}"?',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.deleteGrade(grade.id!);
              Get.back();
              Get.snackbar('Success', 'Grade deleted successfully',
                  duration: const Duration(seconds: 2));
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}