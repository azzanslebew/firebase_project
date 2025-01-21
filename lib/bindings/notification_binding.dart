import 'package:flutter_firebase_project/services/notification_service.dart';
import 'package:get/get.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationService());
  }
}
