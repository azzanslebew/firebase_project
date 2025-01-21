import 'package:flutter_firebase_project/controllers/grade_controller.dart';
import 'package:flutter_firebase_project/controllers/student_controller.dart';
import 'package:get/get.dart';

class FirestoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StudentController());
    Get.put(GradeController());
  }
}
