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

  static String? emailIsValid(String? v) {
    if (v == null || v.isEmpty) {
      return 'Email is Required';
    }
    final okay = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v);
    return okay ? null : 'Enter a valid Email';
  }

  static String? passwordIsValid(String? v) {
    if (v == null || v.isEmpty) {
      return 'Password is Required';
    }
    if (v.length < 8) {
      return 'At least 8 characters';
    }
    return null;
  }

  static String? confirmPassvalid(String? v, String c) {
    if (v == null || v.isEmpty) {
      return 'Password is Required';
    }
    if (v != c) {
      return 'Password do not match';
    }
    return null;
  }

  static String? nameValid(String? v) {
    if (v == null || v.isEmpty) {
      return 'Name is Required';
    }

    return null;
  }

  static String? nonEmpty(
    String? v, {
    String field = 'Field',
  }) {
    if (v == null || v.trim().isEmpty) {
      return '$field is required';
    }
    return null;
  }

  static Map<String, dynamic> checkPasswordStrength(
    String password,
  ) {
    int score = 0;

    if (password.isEmpty) {
      return {
        'score': 0,
        'label': 'Weak',
        'color': const Color(0xFF94A3B8),
      };
    }

    if (password.length >= 8) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(
      r'[!@#\$%^&*(),.?":{}|<>_\-]',
    ).hasMatch(password)) {
      score++;
    }

    String label;
    Color color;

    switch (score) {
      case 0:
      case 1:
        label = 'Weak';
        color = const Color(0xFFF87171);
        break;
      case 2:
      case 3:
        label = 'Medium';
        color = const Color(0xFFFACC15);
        break;
      default:
        label = 'Strong';
        color = const Color(0xFF22C55E);
        break;
    }

    return {'score': score, 'label': label, 'color': color};
  }

  static void showError(
    Object e, {
    String title = 'Error',
  }) {
    errorSnack(title, e.toString());
  }
}
