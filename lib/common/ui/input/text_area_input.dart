import 'package:flutter/material.dart';
import 'package:pillowtalk/common/ui/input/input.dart';

class PTextAreaInput extends StatelessWidget {
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
  final int maxLines;
  final int? maxLength;
  final bool showCounter;

  const PTextAreaInput({
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
    this.maxLines = 4,
    this.maxLength,
    this.showCounter = false,
  });

  @override
  Widget build(BuildContext context) {
    return PInput(
      label: label,
      hintText: hintText ?? 'Enter text',
      helperText: helperText,
      errorText: errorText,
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      variant: variant,
      size: size,
      maxLines: maxLines,
      maxLength: maxLength,
      showCounter: showCounter,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      textCapitalization: TextCapitalization.sentences,
    );
  }
}
