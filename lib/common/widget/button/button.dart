import 'package:flutter/material.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

enum ButtonVariant { primary, secondary, outline, text }

enum ButtonSize { small, medium, large }

class PButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonVariant variant;
  final ButtonSize size;
  final Widget? icon;
  final bool isFullWidth;
  final double? borderRadius;

  const PButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.icon,
    this.isFullWidth = true,
    this.borderRadius,
  });

  // Convenient constructors for common use cases
  const PButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.size = ButtonSize.medium,
    this.icon,
    this.isFullWidth = true,
    this.borderRadius,
  }) : variant = ButtonVariant.primary;

  const PButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.size = ButtonSize.medium,
    this.icon,
    this.isFullWidth = true,
    this.borderRadius,
  }) : variant = ButtonVariant.secondary;

  const PButton.outline({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.size = ButtonSize.medium,
    this.icon,
    this.isFullWidth = true,
    this.borderRadius,
  }) : variant = ButtonVariant.outline;

  const PButton.text({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.size = ButtonSize.medium,
    this.icon,
    this.isFullWidth = false,
    this.borderRadius,
  }) : variant = ButtonVariant.text;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle(context);
    final textStyle = _getTextStyle(context);
    final padding = _getPadding();
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
        : Row(
            mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: PSizes.s8)],
              Text(text, style: textStyle),
            ],
          );

    if (variant == ButtonVariant.text) {
      return TextButton(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle,
        child: Padding(padding: padding, child: buttonChild),
      );
    }

    if (variant == ButtonVariant.outline) {
      return OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle,
        child: Padding(padding: padding, child: buttonChild),
      );
    }

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: buttonStyle,
      child: Padding(padding: padding, child: buttonChild),
    );
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    final baseStyle = ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? PSizes.s12),
        ),
      ),
      elevation: WidgetStateProperty.all(0),
      minimumSize: WidgetStateProperty.all(
        isFullWidth ? const Size(double.infinity, 0) : null,
      ),
    );

    switch (variant) {
      case ButtonVariant.primary:
        return baseStyle.copyWith(
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
        );

      case ButtonVariant.secondary:
        return baseStyle.copyWith(
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
        );

      case ButtonVariant.outline:
        return baseStyle.copyWith(
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
        );

      case ButtonVariant.text:
        return baseStyle.copyWith(
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
        );
    }
  }

  TextStyle _getTextStyle(BuildContext context) {
    double fontSize;
    FontWeight fontWeight;

    switch (size) {
      case ButtonSize.small:
        fontSize = responsive(context, PSizes.s14);
        fontWeight = FontWeight.w500;
        break;
      case ButtonSize.medium:
        fontSize = responsive(context, PSizes.s16);
        fontWeight = FontWeight.w600;
        break;
      case ButtonSize.large:
        fontSize = responsive(context, PSizes.s18);
        fontWeight = FontWeight.w600;
        break;
    }

    return TextStyle(fontSize: fontSize, fontWeight: fontWeight);
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(vertical: PSizes.s12);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(vertical: PSizes.s16);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(vertical: PSizes.s20);
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
