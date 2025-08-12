import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

enum SnackBarType { success, error, warning, info }

enum SnackBarPosition { top, bottom }

class PSnackBar {
  static OverlayEntry? _currentOverlay;
  static bool _isShowing = false;

  /// Show a custom snackbar with animations, haptic feedback, and sound
  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.info,
    SnackBarPosition position = SnackBarPosition.bottom,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
    VoidCallback? onDismiss,
    bool enableHaptic = true,
    bool enableSound = true,
    Widget? customIcon,
    double? elevation,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
  }) {
    // Dismiss any existing snackbar
    dismiss();

    // Use addPostFrameCallback to ensure safe overlay insertion
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        // Get overlay
        final overlay = Overlay.of(context);

        // Trigger haptic feedback
        if (enableHaptic) {
          _triggerHaptic(type);
        }

        // Trigger system sound
        if (enableSound) {
          _triggerSound(type);
        }

        // Create overlay entry
        _currentOverlay = OverlayEntry(
          builder: (context) => _SnackBarWidget(
            message: message,
            type: type,
            position: position,
            duration: duration,
            actionLabel: actionLabel,
            onAction: onAction,
            onDismiss: () {
              dismiss();
              onDismiss?.call();
            },
            customIcon: customIcon,
            elevation: elevation,
            margin: margin,
            borderRadius: borderRadius,
          ),
        );

        // Add to overlay safely
        overlay.insert(_currentOverlay!);
        _isShowing = true;
      } catch (e) {
        // Handle any overlay-related errors gracefully
        debugPrint('PSnackBar: Failed to show snackbar - $e');
      }
    });
  }

  /// Show success snackbar
  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
    SnackBarPosition position = SnackBarPosition.bottom,
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.success,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
      position: position,
    );
  }

  /// Show error snackbar
  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 5),
    String? actionLabel,
    VoidCallback? onAction,
    SnackBarPosition position = SnackBarPosition.bottom,
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.error,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
      position: position,
    );
  }

  /// Show warning snackbar
  static void showWarning(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
    SnackBarPosition position = SnackBarPosition.bottom,
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.warning,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
      position: position,
    );
  }

  /// Show info snackbar
  static void showInfo(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
    SnackBarPosition position = SnackBarPosition.bottom,
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.info,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
      position: position,
    );
  }

  /// Dismiss current snackbar
  static void dismiss() {
    if (_isShowing && _currentOverlay != null) {
      _currentOverlay!.remove();
      _currentOverlay = null;
      _isShowing = false;
    }
  }

  /// Trigger haptic feedback based on snackbar type
  static void _triggerHaptic(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        HapticFeedback.lightImpact();
        break;
      case SnackBarType.error:
        HapticFeedback.heavyImpact();
        break;
      case SnackBarType.warning:
        HapticFeedback.mediumImpact();
        break;
      case SnackBarType.info:
        HapticFeedback.selectionClick();
        break;
    }
  }

  /// Trigger system sound based on snackbar type
  static void _triggerSound(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        SystemSound.play(SystemSoundType.click);
        break;
      case SnackBarType.error:
        SystemSound.play(SystemSoundType.alert);
        break;
      case SnackBarType.warning:
        SystemSound.play(SystemSoundType.click);
        break;
      case SnackBarType.info:
        SystemSound.play(SystemSoundType.click);
        break;
    }
  }
}

class _SnackBarWidget extends StatefulWidget {
  final String message;
  final SnackBarType type;
  final SnackBarPosition position;
  final Duration duration;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback onDismiss;
  final Widget? customIcon;
  final double? elevation;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;

  const _SnackBarWidget({
    required this.message,
    required this.type,
    required this.position,
    required this.duration,
    required this.onDismiss,
    this.actionLabel,
    this.onAction,
    this.customIcon,
    this.elevation,
    this.margin,
    this.borderRadius,
  });

  @override
  State<_SnackBarWidget> createState() => _SnackBarWidgetState();
}

class _SnackBarWidgetState extends State<_SnackBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
    _startDismissTimer();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 350),
      reverseDuration: const Duration(milliseconds: 250),
      vsync: this,
    );

    // Slide animation based on position
    final slideBegin = widget.position == SnackBarPosition.top
        ? const Offset(0, -1)
        : const Offset(0, 1);

    _slideAnimation = Tween<Offset>(begin: slideBegin, end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutBack,
            reverseCurve: Curves.easeInBack,
          ),
        );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
  }

  void _startAnimations() {
    _animationController.forward();
  }

  void _startDismissTimer() {
    Future.delayed(widget.duration, () {
      if (mounted) {
        _dismissWithAnimation();
      }
    });
  }

  void _dismissWithAnimation() {
    _animationController.reverse().then((_) {
      widget.onDismiss();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Positioned(
          top: widget.position == SnackBarPosition.top ? PSizes.s48 : null,
          bottom: widget.position == SnackBarPosition.bottom
              ? PSizes.s48
              : null,
          left: PSizes.s16,
          right: PSizes.s16,
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: _buildSnackBarContent(context),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSnackBarContent(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: _getBackgroundColor(context),
        borderRadius: widget.borderRadius ?? BorderRadius.circular(PSizes.s12),
        boxShadow: [
          BoxShadow(
            color: context.pColor.neutral.n90.withOpacity(0.1),
            blurRadius: widget.elevation ?? 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _dismissWithAnimation(),
          borderRadius:
              widget.borderRadius ?? BorderRadius.circular(PSizes.s12),
          child: Padding(
            padding: const EdgeInsets.all(PSizes.s16),
            child: Row(
              children: [
                _buildIcon(context),
                const SizedBox(width: PSizes.s12),
                Expanded(
                  child: Text(
                    widget.message,
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s14),
                      fontWeight: FontWeight.w500,
                      color: _getTextColor(context),
                    ),
                  ),
                ),
                if (widget.actionLabel != null) ...[
                  const SizedBox(width: PSizes.s12),
                  _buildActionButton(context),
                ],
                const SizedBox(width: PSizes.s8),
                _buildCloseButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    if (widget.customIcon != null) {
      return widget.customIcon!;
    }

    IconData iconData;
    switch (widget.type) {
      case SnackBarType.success:
        iconData = Icons.check_circle;
        break;
      case SnackBarType.error:
        iconData = Icons.error;
        break;
      case SnackBarType.warning:
        iconData = Icons.warning;
        break;
      case SnackBarType.info:
        iconData = Icons.info;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(PSizes.s4),
      decoration: BoxDecoration(
        color: _getIconBackgroundColor(context),
        borderRadius: BorderRadius.circular(PSizes.s8),
      ),
      child: Icon(iconData, size: PSizes.s20, color: _getIconColor(context)),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        widget.onAction?.call();
        _dismissWithAnimation();
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: PSizes.s12,
          vertical: PSizes.s4,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        widget.actionLabel!,
        style: TextStyle(
          fontSize: responsive(context, PSizes.s12),
          fontWeight: FontWeight.w600,
          color: _getActionColor(context),
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return InkWell(
      onTap: () => _dismissWithAnimation(),
      borderRadius: BorderRadius.circular(PSizes.s16),
      child: Padding(
        padding: const EdgeInsets.all(PSizes.s4),
        child: Icon(
          Icons.close,
          size: PSizes.s16,
          color: _getTextColor(context).withOpacity(0.7),
        ),
      ),
    );
  }

  // Color methods based on theme
  Color _getBackgroundColor(BuildContext context) {
    switch (widget.type) {
      case SnackBarType.success:
        return context.pColor.secondary.base.withOpacity(0.9);
      case SnackBarType.error:
        return context.pColor.primary.base.withOpacity(0.9);
      case SnackBarType.warning:
        return context.pColor.neutral.n40.withOpacity(0.85);
      case SnackBarType.info:
        return context.pColor.neutral.n10;
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (widget.type) {
      case SnackBarType.success:
        return Colors.white;
      case SnackBarType.error:
        return Colors.white;
      case SnackBarType.warning:
        return context.pColor.neutral.n90;
      case SnackBarType.info:
        return context.pColor.neutral.n90;
    }
  }

  Color _getIconColor(BuildContext context) {
    switch (widget.type) {
      case SnackBarType.success:
        return Colors.white;
      case SnackBarType.error:
        return Colors.white;
      case SnackBarType.warning:
        return context.pColor.neutral.n80;
      case SnackBarType.info:
        return context.pColor.primary.base;
    }
  }

  Color _getIconBackgroundColor(BuildContext context) {
    switch (widget.type) {
      case SnackBarType.success:
        return Colors.white.withOpacity(0.2);
      case SnackBarType.error:
        return Colors.white.withOpacity(0.2);
      case SnackBarType.warning:
        return context.pColor.neutral.n40.withOpacity(0.2);
      case SnackBarType.info:
        return context.pColor.primary.base.withOpacity(0.2);
    }
  }

  Color _getActionColor(BuildContext context) {
    switch (widget.type) {
      case SnackBarType.success:
        return Colors.white;
      case SnackBarType.error:
        return Colors.white;
      case SnackBarType.warning:
        return context.pColor.neutral.n80;
      case SnackBarType.info:
        return context.pColor.primary.base;
    }
  }
}

// Extension to make it easier to use
extension SnackBarExtension on BuildContext {
  void showSnackBar({
    required String message,
    SnackBarType type = SnackBarType.info,
    SnackBarPosition position = SnackBarPosition.bottom,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    PSnackBar.show(
      this,
      message: message,
      type: type,
      position: position,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  void showSuccessSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    PSnackBar.showSuccess(
      this,
      message: message,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  void showErrorSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 5),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    PSnackBar.showError(
      this,
      message: message,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  void showWarningSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    PSnackBar.showWarning(
      this,
      message: message,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  void showInfoSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    PSnackBar.showInfo(
      this,
      message: message,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }
}
