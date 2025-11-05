import 'package:flutter/material.dart';
import 'package:github_restapi/theme/app_colors.dart';



class AppInputDecorations {
  static InputDecoration rounded({
    String? hintText,
    Widget? suffixIcon,
  }) {
    const radius = 28.0;
    const borderColor = Color(0xFFE2E8F0);

    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      alignLabelWithHint: false,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(
          color: borderColor,
          width: 1.2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: Colors.red),
      ),
      suffixIcon: suffixIcon,
      
    );
  }
}
