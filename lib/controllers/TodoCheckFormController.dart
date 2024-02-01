import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoCheckFormController extends GetxController {
  final TextEditingController titleController = TextEditingController();

  void clearFields() {
    titleController.clear();
  }

  @override
  void onClose() {
    titleController.dispose();
    super.onClose();
  }
}