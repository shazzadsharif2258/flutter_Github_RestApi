import 'package:flutter/material.dart';

class AppInputDecorations {
  static InputDecoration rounded({
    required BuildContext context,
    String? hintText,
    Widget? suffixIcon,
  }) {
    final theme = Theme.of(context);
    const radius = 28.0;

    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: theme.colorScheme.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      alignLabelWithHint: false,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(
          color: theme.colorScheme.outline.withAlpha(1),
          width: 1.2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(
          color: theme.colorScheme.primary,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(
          color: theme.colorScheme.error,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(
          color: theme.colorScheme.error,
        ),
      ),
      suffixIcon: suffixIcon,
    );
  }
}
