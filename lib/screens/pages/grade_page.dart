import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/grade_controller.dart';
import '../../dialogs/grade_dialog.dart';

class GradePage extends StatelessWidget {
  final GradeController controller = Get.put(GradeController());

  GradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grades'),
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
}