import 'package:flutter/material.dart';
import 'package:github_restapi/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final bool loading, filled;
  final String title;
  final double height, width;
  final VoidCallback? onPress;
  final Color textColor;

  const CustomButton({
    super.key,
    required this.loading,
    required this.title,
    required this.height,
    required this.width,
    this.onPress,
    required this.textColor,
    required this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: filled
              ? AppColors.primary
              : Colors.transparent,
          foregroundColor: filled
              ? Colors.white
              : AppColors.primary,

          side: filled
              ? null
              : const BorderSide(color: AppColors.primary),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: loading
            ? Center(child: CircularProgressIndicator())
            : Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
