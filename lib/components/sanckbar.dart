import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar(String title, String message, {bool isError = false}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: isError ? Colors.red : Colors.green,
    colorText: Colors.white,
    borderRadius: 8,
    margin: const EdgeInsets.all(10),
    duration: const Duration(seconds: 3),
    icon: Icon(
      isError ? Icons.error : Icons.check_circle,
      color: Colors.white,
    ),
  );
}
