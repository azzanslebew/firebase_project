import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/grade.dart';

class GradeController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  RxList<Grade> grades = <Grade>[].obs;

  RxBool isLoading = false.obs;

  Rx<Grade?> selectedGrade = Rx<Grade?>(null);

  @override
  void onInit() {
    super.onInit();
    _listenToGrades();
  }

  // Mendengarkan perubahan data grades di Firestore
  void _listenToGrades() {
    isLoading.value = true; // Set loading saat mendengarkan data
    _db.collection('grades').snapshots().listen(
      (snapshot) {
        grades.value = snapshot.docs
            .map((doc) => Grade.fromJson(doc.data(), doc.id))
            .toList();
        isLoading.value = false; // Set loading ke false setelah data diterima
      },
      onError: (error) {
        Get.snackbar(
          'Error',
          'Failed to listen to grades: ${error.toString()}',
        );
        isLoading.value = false;
      },
    );
  }

  // Menambahkan grade baru ke Firestore
  Future<void> addGrade(Grade grade) async {
    try {
      isLoading.value = true; // Set loading saat proses
      final docRef = await _db.collection('grades').add(grade.toJson());
      grade.id = docRef.id; // Set ID dari dokumen yang dibuat
      Get.snackbar('Success', 'Grade added successfully',
          duration: const Duration(seconds: 2));
    } catch (error) {
      Get.snackbar('Error', 'Failed to add grade: ${error.toString()}');
    } finally {
      isLoading.value = false; // Reset loading setelah proses selesai
    }
  }

  // Mengupdate grade di Firestore
  Future<void> updateGrade(Grade grade) async {
    if (grade.id == null) {
      Get.snackbar('Error', 'Grade ID is required for updating');
      return;
    }

    try {
      isLoading.value = true; // Set loading saat proses
      await _db.collection('grades').doc(grade.id).update(grade.toJson());
    } catch (error) {
      Get.snackbar('Error', 'Failed to update grade: ${error.toString()}');
    } finally {
      isLoading.value = false; // Reset loading setelah proses selesai
    }
  }

  // Menghapus grade dari Firestore
  Future<void> deleteGrade(String id) async {
    try {
      isLoading.value = true; // Set loading saat proses
      await _db.collection('grades').doc(id).delete();
    } catch (error) {
      Get.snackbar('Error', 'Failed to delete grade: ${error.toString()}');
    } finally {
      isLoading.value = false; // Reset loading setelah proses selesai
    }
  }

  // Mengatur grade yang dipilih
  void setSelectedGrade(Grade grade) {
    selectedGrade.value = grade;
  }
}