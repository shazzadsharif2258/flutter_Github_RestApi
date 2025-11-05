import 'package:flutter/material.dart';
import 'package:github_restapi/resources/utils/app_input_decoration.dart';

import '../utils/responsive.dart';

class LabeledField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;

  const LabeledField({
    super.key,
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.suffix,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.keyboardType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscure,
          keyboardType: keyboardType,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          decoration: AppInputDecorations.rounded(
            hintText: hint,
            suffixIcon: suffix,
          ),
          onChanged: onChanged,
          validator: validator,
          onTap: onTap,
          autofillHints: obscure
              ? const [AutofillHints.password]
              : const [AutofillHints.email],
          textInputAction: obscure
              ? TextInputAction.done
              : TextInputAction.next,
        ),
      ],
    );
  }
}
