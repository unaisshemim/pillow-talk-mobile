import 'package:flutter/material.dart';
import 'package:pillowtalk/utils/constant/colors.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';

/// Enumeration for different types of alert dialogs
enum PAlertType { info, success, warning, error, confirmation }

/// Reusable Alert Dialog Widget
class PAlertDialog extends StatelessWidget {
  const PAlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.type = PAlertType.info,
    this.confirmLabel,
    this.cancelLabel,
    this.onConfirm,
    this.onCancel,
    this.showCancelButton = false,
    this.isDestructive = false,
    this.customIcon,
  });

  final String title;
  final String message;
  final PAlertType type;
  final String? confirmLabel;
  final String? cancelLabel;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool showCancelButton;
  final bool isDestructive;
  final Widget? customIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PSizes.s16),
      ),
      contentPadding: const EdgeInsets.fromLTRB(
        PSizes.s24,
        PSizes.s20,
        PSizes.s24,
        PSizes.s24,
      ),
      actionsPadding: const EdgeInsets.fromLTRB(
        PSizes.s24,
        0,
        PSizes.s24,
        PSizes.s24,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon section
          if (customIcon != null || type != PAlertType.info)
            Container(
              margin: const EdgeInsets.only(bottom: PSizes.s16),
              child: customIcon ?? _getTypeIcon(context, type),
            ),

          // Title section
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: PColors.light.neutral.n100,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: PSizes.s12),

          // Message section
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: PColors.light.neutral.n70,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: _buildActions(context),
    );
  }

  /// Get predefined icon based on alert type
  Widget _getTypeIcon(BuildContext context, PAlertType type) {
    late IconData iconData;
    late Color iconColor;

    switch (type) {
      case PAlertType.info:
        iconData = Icons.info_outline;
        iconColor = PColors.light.primary.base;
        break;
      case PAlertType.success:
        iconData = Icons.check_circle_outline;
        iconColor = PColors.light.success.base;
        break;
      case PAlertType.warning:
        iconData = Icons.warning_amber_outlined;
        iconColor =
            PColors.light.primary.p70; // Using amber/orange from primary
        break;
      case PAlertType.error:
        iconData = Icons.error_outline;
        iconColor = PColors.light.error.base;
        break;
      case PAlertType.confirmation:
        iconData = Icons.help_outline;
        iconColor = PColors.light.primary.base;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(PSizes.s12),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, size: PSizes.s32, color: iconColor),
    );
  }

  /// Build action buttons
  List<Widget> _buildActions(BuildContext context) {
    final actions = <Widget>[];

    // Cancel button
    if (showCancelButton) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
            onCancel?.call();
          },
          child: Text(cancelLabel ?? 'Cancel'),
        ),
      );
    }

    // Confirm button
    actions.add(
      isDestructive
          ? TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                onConfirm?.call();
              },
              style: TextButton.styleFrom(
                foregroundColor: PColors.light.error.base,
              ),
              child: Text(confirmLabel ?? 'OK'),
            )
          : FilledButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                onConfirm?.call();
              },
              child: Text(confirmLabel ?? 'OK'),
            ),
    );

    return actions;
  }
}

/// Utility class for showing different types of alert dialogs
class PAlertDialogUtils {
  PAlertDialogUtils._();

  /// Show a basic info dialog
  static Future<bool?> showInfo(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmLabel,
    VoidCallback? onConfirm,
    bool barrierDismissible = true,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => PAlertDialog(
        title: title,
        message: message,
        type: PAlertType.info,
        confirmLabel: confirmLabel,
        onConfirm: onConfirm,
      ),
    );
  }

  /// Show a success dialog
  static Future<bool?> showSuccess(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmLabel,
    VoidCallback? onConfirm,
    bool barrierDismissible = true,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => PAlertDialog(
        title: title,
        message: message,
        type: PAlertType.success,
        confirmLabel: confirmLabel,
        onConfirm: onConfirm,
      ),
    );
  }

  /// Show a warning dialog
  static Future<bool?> showWarning(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmLabel,
    String? cancelLabel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => PAlertDialog(
        title: title,
        message: message,
        type: PAlertType.warning,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        onConfirm: onConfirm,
        onCancel: onCancel,
        showCancelButton: true,
      ),
    );
  }

  /// Show an error dialog
  static Future<bool?> showError(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmLabel,
    VoidCallback? onConfirm,
    bool barrierDismissible = true,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => PAlertDialog(
        title: title,
        message: message,
        type: PAlertType.error,
        confirmLabel: confirmLabel,
        onConfirm: onConfirm,
      ),
    );
  }

  /// Show a confirmation dialog
  static Future<bool?> showConfirmation(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmLabel,
    String? cancelLabel,
    bool isDestructive = false,
    bool barrierDismissible = true,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => PAlertDialog(
        title: title,
        message: message,
        type: PAlertType.confirmation,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        showCancelButton: true,
        isDestructive: isDestructive,
      ),
    );
  }

  /// Show a custom dialog
  static Future<bool?> showCustom(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmLabel,
    String? cancelLabel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool showCancelButton = false,
    bool isDestructive = false,
    Widget? customIcon,
    bool barrierDismissible = true,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => PAlertDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        onConfirm: onConfirm,
        onCancel: onCancel,
        showCancelButton: showCancelButton,
        isDestructive: isDestructive,
        customIcon: customIcon,
      ),
    );
  }
}
