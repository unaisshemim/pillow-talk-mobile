import 'package:flutter/material.dart';
import 'package:pillowtalk/common/ui/snackBar.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

class SnackBarTest extends StatefulWidget {
  const SnackBarTest({super.key});

  @override
  State<SnackBarTest> createState() => _SnackBarTestState();
}

class _SnackBarTestState extends State<SnackBarTest> {
  bool hapticEnabled = true;
  bool soundEnabled = true;
  SnackBarPosition position = SnackBarPosition.bottom;
  Duration duration = const Duration(seconds: 4);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSettings(),
        const SizedBox(height: PSizes.s32),
        _buildBasicTypes(),
        const SizedBox(height: PSizes.s32),
        _buildWithActions(),
        const SizedBox(height: PSizes.s32),
        _buildPositions(),
        const SizedBox(height: PSizes.s32),
        _buildExtensionMethods(),
        const SizedBox(height: PSizes.s32),
        _buildAdvancedExamples(),
      ],
    );
  }

  Widget _buildSettings() {
    return Container(
      padding: const EdgeInsets.all(PSizes.s16),
      decoration: BoxDecoration(
        color: context.pColor.neutral.n10,
        borderRadius: BorderRadius.circular(PSizes.s12),
        border: Border.all(color: context.pColor.neutral.n30, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: TextStyle(
              fontSize: responsive(context, PSizes.s16),
              fontWeight: FontWeight.bold,
              color: context.pColor.neutral.n90,
            ),
          ),
          const SizedBox(height: PSizes.s16),

          // Haptic Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Haptic Feedback',
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s14),
                  color: context.pColor.neutral.n80,
                ),
              ),
              Switch(
                value: hapticEnabled,
                onChanged: (value) => setState(() => hapticEnabled = value),
                activeColor: context.pColor.primary.base,
              ),
            ],
          ),

          // Sound Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sound Effects',
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s14),
                  color: context.pColor.neutral.n80,
                ),
              ),
              Switch(
                value: soundEnabled,
                onChanged: (value) => setState(() => soundEnabled = value),
                activeColor: context.pColor.primary.base,
              ),
            ],
          ),

          // Position Selection
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Position',
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s14),
                  color: context.pColor.neutral.n80,
                ),
              ),
              DropdownButton<SnackBarPosition>(
                value: position,
                onChanged: (value) => setState(() => position = value!),
                items: [
                  DropdownMenuItem(
                    value: SnackBarPosition.top,
                    child: Text('Top'),
                  ),
                  DropdownMenuItem(
                    value: SnackBarPosition.bottom,
                    child: Text('Bottom'),
                  ),
                ],
              ),
            ],
          ),

          // Duration Selection
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Duration',
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s14),
                  color: context.pColor.neutral.n80,
                ),
              ),
              DropdownButton<Duration>(
                value: duration,
                onChanged: (value) => setState(() => duration = value!),
                items: [
                  DropdownMenuItem(
                    value: Duration(seconds: 2),
                    child: Text('2s'),
                  ),
                  DropdownMenuItem(
                    value: Duration(seconds: 4),
                    child: Text('4s'),
                  ),
                  DropdownMenuItem(
                    value: Duration(seconds: 6),
                    child: Text('6s'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBasicTypes() {
    return _buildSection(
      title: 'Basic Types',
      children: [
        _buildTestButton(
          'Success Message',
          'Operation completed successfully!',
          SnackBarType.success,
          context.pColor.secondary.base,
        ),
        _buildTestButton(
          'Error Message',
          'Something went wrong. Please try again.',
          SnackBarType.error,
          context.pColor.primary.base,
        ),
        _buildTestButton(
          'Warning Message',
          'Please check your input and try again.',
          SnackBarType.warning,
          context.pColor.neutral.n70,
        ),
        _buildTestButton(
          'Info Message',
          'Here\'s some helpful information for you.',
          SnackBarType.info,
          context.pColor.primary.base,
        ),
      ],
    );
  }

  Widget _buildWithActions() {
    return _buildSection(
      title: 'With Actions',
      children: [
        _buildActionButton(
          'Success with Retry',
          'File uploaded successfully!',
          SnackBarType.success,
          'VIEW',
          () => _showConfirmation('View action triggered'),
        ),
        _buildActionButton(
          'Error with Retry',
          'Failed to save changes.',
          SnackBarType.error,
          'RETRY',
          () => _showConfirmation('Retry action triggered'),
        ),
        _buildActionButton(
          'Warning with Settings',
          'Storage is almost full.',
          SnackBarType.warning,
          'SETTINGS',
          () => _showConfirmation('Settings action triggered'),
        ),
        _buildActionButton(
          'Info with Learn More',
          'New feature available!',
          SnackBarType.info,
          'LEARN MORE',
          () => _showConfirmation('Learn more action triggered'),
        ),
      ],
    );
  }

  Widget _buildPositions() {
    return _buildSection(
      title: 'Positions',
      children: [
        _buildPositionButton(
          'Top Success',
          SnackBarPosition.top,
          SnackBarType.success,
        ),
        _buildPositionButton(
          'Bottom Error',
          SnackBarPosition.bottom,
          SnackBarType.error,
        ),
      ],
    );
  }

  Widget _buildExtensionMethods() {
    return _buildSection(
      title: 'Extension Methods',
      children: [
        _buildExtensionButton(
          'context.showSuccessSnackBar',
          () => context.showSuccessSnackBar(
            message: 'Using extension method!',
            actionLabel: 'OK',
            onAction: () => _showConfirmation('Extension action'),
          ),
          context.pColor.secondary.base,
        ),
        _buildExtensionButton(
          'context.showErrorSnackBar',
          () => context.showErrorSnackBar(
            message: 'Error using extension!',
            actionLabel: 'RETRY',
            onAction: () => _showConfirmation('Extension retry'),
          ),
          context.pColor.primary.base,
        ),
        _buildExtensionButton(
          'context.showWarningSnackBar',
          () =>
              context.showWarningSnackBar(message: 'Warning using extension!'),
          context.pColor.neutral.n70,
        ),
        _buildExtensionButton(
          'context.showInfoSnackBar',
          () => context.showInfoSnackBar(message: 'Info using extension!'),
          context.pColor.primary.base,
        ),
      ],
    );
  }

  Widget _buildAdvancedExamples() {
    return _buildSection(
      title: 'Advanced Examples',
      children: [
        _buildAdvancedButton(
          'Custom Duration (10s)',
          () => PSnackBar.show(
            context,
            message: 'This snackbar will stay for 10 seconds',
            type: SnackBarType.info,
            duration: Duration(seconds: 10),
            position: position,
            enableHaptic: hapticEnabled,
            enableSound: soundEnabled,
          ),
        ),
        _buildAdvancedButton(
          'No Haptic/Sound',
          () => PSnackBar.show(
            context,
            message: 'Silent snackbar with no feedback',
            type: SnackBarType.info,
            position: position,
            enableHaptic: false,
            enableSound: false,
          ),
        ),
        _buildAdvancedButton(
          'Custom Icon',
          () => PSnackBar.show(
            context,
            message: 'Snackbar with custom icon',
            type: SnackBarType.info,
            position: position,
            enableHaptic: hapticEnabled,
            enableSound: soundEnabled,
            customIcon: Container(
              padding: EdgeInsets.all(PSizes.s4),
              decoration: BoxDecoration(
                color: context.pColor.primary.base.withOpacity(0.2),
                borderRadius: BorderRadius.circular(PSizes.s8),
              ),
              child: Icon(
                Icons.star,
                color: context.pColor.primary.base,
                size: PSizes.s20,
              ),
            ),
          ),
        ),
        _buildAdvancedButton(
          'Long Message',
          () => PSnackBar.show(
            context,
            message:
                'This is a very long message that demonstrates how the snackbar handles extended text content and maintains proper formatting and readability across multiple lines.',
            type: SnackBarType.warning,
            position: position,
            enableHaptic: hapticEnabled,
            enableSound: soundEnabled,
            actionLabel: 'READ MORE',
            onAction: () => _showConfirmation('Read more clicked'),
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(PSizes.s16),
      decoration: BoxDecoration(
        color: context.pColor.neutral.n10,
        borderRadius: BorderRadius.circular(PSizes.s12),
        border: Border.all(color: context.pColor.neutral.n30, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s16),
              fontWeight: FontWeight.bold,
              color: context.pColor.neutral.n90,
            ),
          ),
          const SizedBox(height: PSizes.s16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTestButton(
    String label,
    String message,
    SnackBarType type,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PSizes.s8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => PSnackBar.show(
            context,
            message: message,
            type: type,
            position: position,
            duration: duration,
            enableHaptic: hapticEnabled,
            enableSound: soundEnabled,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: PSizes.s12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(PSizes.s8),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s14),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    String message,
    SnackBarType type,
    String actionLabel,
    VoidCallback onAction,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PSizes.s8),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () => PSnackBar.show(
            context,
            message: message,
            type: type,
            position: position,
            duration: duration,
            enableHaptic: hapticEnabled,
            enableSound: soundEnabled,
            actionLabel: actionLabel,
            onAction: onAction,
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: context.pColor.neutral.n40),
            padding: const EdgeInsets.symmetric(vertical: PSizes.s12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(PSizes.s8),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s14),
              fontWeight: FontWeight.w500,
              color: context.pColor.neutral.n80,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPositionButton(
    String label,
    SnackBarPosition pos,
    SnackBarType type,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PSizes.s8),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () => PSnackBar.show(
            context,
            message:
                'This snackbar appears at the ${pos.toString().split('.').last}',
            type: type,
            position: pos,
            duration: duration,
            enableHaptic: hapticEnabled,
            enableSound: soundEnabled,
          ),
          style: TextButton.styleFrom(
            backgroundColor: context.pColor.neutral.n20,
            padding: const EdgeInsets.symmetric(vertical: PSizes.s12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(PSizes.s8),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s14),
              fontWeight: FontWeight.w500,
              color: context.pColor.neutral.n80,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExtensionButton(
    String label,
    VoidCallback onPressed,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PSizes.s8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color.withOpacity(0.1),
            foregroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: PSizes.s12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(PSizes.s8),
              side: BorderSide(color: color.withOpacity(0.3)),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s14),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAdvancedButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PSizes.s8),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: context.pColor.primary.base),
            padding: const EdgeInsets.symmetric(vertical: PSizes.s12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(PSizes.s8),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s14),
              fontWeight: FontWeight.w500,
              color: context.pColor.primary.base,
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmation(String message) {
    PSnackBar.showInfo(
      context,
      message: message,
      duration: Duration(seconds: 2),
    );
  }
}
