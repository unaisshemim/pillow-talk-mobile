import 'package:flutter/material.dart';
import 'package:pillowtalk/common/common/input/input.dart';

class PEmailInput extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final InputVariant variant;
  final InputSize size;

  const PEmailInput({
    super.key,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.controller,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.focusNode,
    this.variant = InputVariant.outlined,
    this.size = InputSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    return PInput(
      label: label,
      hintText: hintText ?? 'Enter email address',
      helperText: helperText,
      errorText: errorText,
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      variant: variant,
      size: size,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.none,
      prefixIcon: const Icon(Icons.email_outlined),
    );
  }
}
