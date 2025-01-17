import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_project/models/grade.dart';
import 'package:get/get.dart';

import '../models/student.dart';

class StudentController extends GetxController{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  RxList<Student> students = <Student>[].obs;
  RxList<Grade> grades = <Grade>[].obs;

  RxBool isLoadingStudents = false.obs;
  RxBool isLoadingGrades = false.obs;  

  @override
  void onInit() {
    super.onInit();
    _listenToStudents();
    _listenToGrades();
  }

  // Mendengarkan perubahan data students dari Firestore
  void _listenToStudents() {
    isLoadingStudents.value = true;
    _db.collection('students').snapshots().listen(
      (snapshot) {
        students.value = snapshot.docs
            .map((doc) => Student.fromJson(doc.data(), doc.id))
            .toList();
        isLoadingStudents.value = false;
      },
      onError: (error) {
        Get.snackbar(
            'Error', 'Failed to listen to students: ${error.toString()}');
        isLoadingStudents.value = false;
      },
    );
  }

  // Mendengarkan perubahan data grades dari Firestore
  void _listenToGrades() {
    isLoadingGrades.value = true;
    _db.collection('grades').snapshots().listen(
      (snapshot) {
        grades.value = snapshot.docs
            .map((doc) => Grade.fromJson(doc.data(), doc.id))
            .toList();
        isLoadingGrades.value = false;
      },
      onError: (error) {
        Get.snackbar(
            'Error', 'Failed to listen to grades: ${error.toString()}');
        isLoadingGrades.value = false;
      },
    );
  }

  // Menambahkan data student baru
  Future<void> addStudent(Student student) async {
    if (student.name.isEmpty || student.age <= 0) {
      Get.snackbar('Error', 'Please provide valid student data');
      return;
    }

    try {
      isLoadingStudents.value = true;
      await _db.collection('students').add(student.toJson());
      Get.snackbar('Success', 'Student added successfully',
          duration: const Duration(seconds: 2));
    } catch (error) {
      Get.snackbar('Error', 'Failed to add student: ${error.toString()}');
    } finally {
      isLoadingStudents.value = false;
    }
  }
}