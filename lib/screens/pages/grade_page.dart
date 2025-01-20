import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/widgets/reusable_app_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/grade_controller.dart';
import '../../dialogs/grade_dialog.dart';
import '../../models/grade.dart';

class GradePage extends StatelessWidget {
  final GradeController controller = Get.put(GradeController());

  GradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: const ReusableAppBar(
        title: 'Grades',
        fontSize: 24,
        backgroundColor: Colors.blueAccent,
        titleColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
        ),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.grades.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.school_outlined,
                      size: 80, color: Colors.grey),
                  const SizedBox(height: 10),
                  Text(
                    'No grades found',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.grades.length,
            itemBuilder: (context, index) {
              final grade = controller.grades[index];
              return Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  title: Text(
                    grade.name,
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  trailing: Transform.translate(
                    offset: const Offset(-15, 0),
                    child: PopupMenuButton<String>(
                      color: Colors.white,
                      elevation: 2,
                      onSelected: (value) {
                        if (value == 'edit') {
                          GradeDialog.showEditDialog(
                            context,
                            controller,
                            grade,
                          );
                        } else if (value == 'delete') {
                          _showDeleteConfirmation(context, grade);
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              const Icon(Icons.edit, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text(
                                'Edit',
                                style: GoogleFonts.manrope(),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              const Icon(Icons.delete, color: Colors.red),
                              const SizedBox(width: 8),
                              Text(
                                'Delete',
                                style: GoogleFonts.manrope(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GradeDialog.showAddDialog(context, controller),
        backgroundColor: Colors.blueAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Grade grade) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          'Delete Grade',
          style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Are you sure you want to delete the grade "${grade.name}"?',
          style: GoogleFonts.manrope(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: GoogleFonts.manrope(color: Colors.blueAccent),
            ),
          ),
          TextButton(
            onPressed: () {
              controller.deleteGrade(grade.id!);
              Get.back();
              Get.snackbar('Success', 'Grade deleted successfully',
                  duration: const Duration(seconds: 2));
            },
            child:
                Text('Delete', style: GoogleFonts.manrope(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
