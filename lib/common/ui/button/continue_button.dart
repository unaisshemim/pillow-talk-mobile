import 'package:flutter/material.dart';
import 'package:pillowtalk/common/ui/button/button.dart';

class ContinueButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final String text;

  const ContinueButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    this.text = 'Send Verification Code',
  });

  @override
  Widget build(BuildContext context) {
    return PButton.primary(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      size: ButtonSize.medium,
    );
  }
}
