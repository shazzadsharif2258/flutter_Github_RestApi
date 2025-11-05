import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Utils {
  static void toastMessage(
    String message, {
    ToastGravity gravity = ToastGravity.TOP,
  }) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
      gravity: gravity,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: const Color(0xFF2563EB),
      textColor: Colors.white,
      fontSize: 15,
      timeInSecForIosWeb: 2,
    );
  }

  static void successSnack(String title, String message) {
    _baseSnack(
      title,
      message,
      bg: const Color(0xFFEFF6FF),
      text: const Color(0xFF111827),
      icon: const Icon(
        Icons.check_circle,
        color: Color(0xFF2563EB),
      ),
    );
  }

  static void errorSnack(String title, String message) {
    _baseSnack(
      title,
      message,
      bg: const Color(0xFFFFF1F2),
      text: const Color(0xFF111827),
      icon: const Icon(
        Icons.error_rounded,
        color: Color(0xFFDC2626),
      ),
    );
  }

  static void infoSnack(String title, String message) {
    _baseSnack(
      title,
      message,
      bg: const Color(0xFFF1F5F9),
      text: const Color(0xFF111827),
      icon: const Icon(
        Icons.info_rounded,
        color: Color(0xFF0EA5E9),
      ),
    );
  }

  static void _baseSnack(
    String title,
    String message, {
    required Color bg,
    required Color text,
    required Icon icon,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(12),
      backgroundColor: bg,
      colorText: text,
      icon: icon,
      borderRadius: 14,
      isDismissible: true,
      duration: const Duration(seconds: 3),
      forwardAnimationCurve: Curves.easeOutBack,
      messageText: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
          height: 1.35,
          color: Color(0xFF334155),
          fontWeight: FontWeight.w600,
        ),
      ),
      titleText: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF0F172A),
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
