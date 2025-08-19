import 'package:flutter/material.dart';
import 'package:pillowtalk/common/ui/button/button.dart';

import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

class PIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final double? borderRadius;
  final bool isLoading;

  const PIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.borderRadius,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonSize = _getButtonSize();
    final loadingSize = _getLoadingSize();

    Widget buttonChild = isLoading
        ? SizedBox(
            height: loadingSize,
            width: loadingSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                _getLoadingColor(context),
              ),
            ),
          )
        : icon;

    final buttonStyle = ButtonStyle(
      fixedSize: WidgetStateProperty.all(Size(buttonSize, buttonSize)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? PSizes.s12),
        ),
      ),
      elevation: WidgetStateProperty.all(0),
      padding: WidgetStateProperty.all(EdgeInsets.zero),
    );

    switch (variant) {
      case ButtonVariant.primary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle.copyWith(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return context.pColor.neutral.n60;
              }
              return context.pColor.primary.base;
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return context.pColor.neutral.n40;
              }
              return context.pColor.neutral.n10;
            }),
          ),
          child: buttonChild,
        );

      case ButtonVariant.secondary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle.copyWith(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return context.pColor.neutral.n30;
              }
              return context.pColor.secondary.base;
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return context.pColor.neutral.n60;
              }
              return context.pColor.neutral.n10;
            }),
          ),
          child: buttonChild,
        );

      case ButtonVariant.outline:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle.copyWith(
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return context.pColor.neutral.n60;
              }
              return context.pColor.primary.base;
            }),
            side: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return BorderSide(color: context.pColor.neutral.n60);
              }
              return BorderSide(color: context.pColor.primary.base);
            }),
          ),
          child: buttonChild,
        );

      case ButtonVariant.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle.copyWith(
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return context.pColor.neutral.n60;
              }
              return context.pColor.primary.base;
            }),
            overlayColor: WidgetStateProperty.all(
              context.pColor.primary.base.withOpacity(0.1),
            ),
          ),
          child: buttonChild,
        );
    }
  }

  double _getButtonSize() {
    switch (size) {
      case ButtonSize.small:
        return PSizes.s36;
      case ButtonSize.medium:
        return PSizes.s48;
      case ButtonSize.large:
        return PSizes.s52;
    }
  }

  double _getLoadingSize() {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 24;
    }
  }

  Color _getLoadingColor(BuildContext context) {
    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.secondary:
        return context.pColor.neutral.n10;
      case ButtonVariant.outline:
      case ButtonVariant.text:
        return context.pColor.primary.base;
    }
  }
}
