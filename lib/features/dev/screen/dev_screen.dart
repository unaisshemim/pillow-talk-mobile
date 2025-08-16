import 'package:flutter/material.dart';
import 'package:pillowtalk/common/ui/app_bar_title.dart';
import 'package:pillowtalk/common/ui/screen_container.dart';
import 'package:pillowtalk/common/ui/bottom_sheet.dart';
import 'package:pillowtalk/features/dev/widget/button_test.dart';
import 'package:pillowtalk/features/dev/widget/input_test.dart';
import 'package:pillowtalk/features/dev/widget/notification_test_widget.dart';
import 'package:pillowtalk/features/dev/widget/snackbar_test.dart';
import 'package:pillowtalk/features/dev/widget/card_test.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';

class DevScreen extends StatelessWidget {
  const DevScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PScreenContainer(
      backgroundColor: context.pColor.neutral.n20,
      appBar: PAppBarTitle(title: 'Developer Tools', isBackButtonNeeded: false),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(PSizes.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(PSizes.s20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    context.pColor.primary.base,
                    context.pColor.secondary.base,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(PSizes.s16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Developer Tools 🛠️',
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s24),
                      fontWeight: FontWeight.bold,
                      color: context.pColor.neutral.n10,
                    ),
                  ),
                  const SizedBox(height: PSizes.s8),
                  Text(
                    'Test and showcase all app components',
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s16),
                      color: context.pColor.neutral.n10.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: PSizes.s24),

            // Development Tools Grid
            _buildToolCard(
              context,
              'App Information',
              'View app details and environment info',
              Icons.info_outline,
              context.pColor.primary.base,
              () => _showAppInfoModal(context),
            ),

            const SizedBox(height: PSizes.s16),

            _buildToolCard(
              context,
              'Notification Testing',
              'Test push notifications and alerts',
              Icons.notifications_outlined,
              context.pColor.secondary.base,
              () => _showNotificationModal(context),
            ),

            const SizedBox(height: PSizes.s16),

            _buildToolCard(
              context,
              'Button Showcase',
              'View all button variants and styles',
              Icons.touch_app_outlined,
              context.pColor.success.base,
              () => _showButtonModal(context),
            ),

            const SizedBox(height: PSizes.s16),

            _buildToolCard(
              context,
              'Input Showcase',
              'Test input fields and forms',
              Icons.edit_outlined,
              context.pColor.secondary.base,
              () => _showInputModal(context),
            ),

            const SizedBox(height: PSizes.s16),

            _buildToolCard(
              context,
              'Card Showcase',
              'View all card variants and styles',
              Icons.credit_card_outlined,
              context.pColor.success.base,
              () => _showCardModal(context),
            ),

            const SizedBox(height: PSizes.s16),

            _buildToolCard(
              context,
              'SnackBar Testing',
              'Test different snackbar styles',
              Icons.message_outlined,
              context.pColor.error.base,
              () => _showSnackBarModal(context),
            ),

            const SizedBox(height: PSizes.s24),
          ],
        ),
      ),
    );
  }

  Widget _buildToolCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(PSizes.s16),
        decoration: BoxDecoration(
          color: context.pColor.neutral.n10,
          borderRadius: BorderRadius.circular(PSizes.s12),
          border: Border.all(color: context.pColor.neutral.n30),
          boxShadow: [
            BoxShadow(
              color: context.pColor.neutral.n30.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(PSizes.s12),
              ),
              child: Icon(icon, color: color, size: PSizes.s24),
            ),
            const SizedBox(width: PSizes.s16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s16),
                      fontWeight: FontWeight.w600,
                      color: context.pColor.neutral.n80,
                    ),
                  ),
                  const SizedBox(height: PSizes.s4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s14),
                      color: context.pColor.neutral.n60,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: context.pColor.neutral.n50,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showAppInfoModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(PSizes.s16)),
      ),
      builder: (context) => PBottomSheet(
        title: 'App Information',
        child: Column(
          children: [
            _buildInfoRow('App Name', 'Pillow Talk'),
            _buildInfoRow('Version', '1.0.0'),
            _buildInfoRow('Build', 'Development'),
            _buildInfoRow('Flutter Version', '3.5.1'),
            _buildInfoRow('Environment', 'Debug'),
            _buildInfoRow('Platform', 'Mobile'),
            _buildInfoRow(
              'Build Date',
              DateTime.now().toString().split(' ')[0],
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(PSizes.s16)),
      ),
      builder: (context) => const PBottomSheet(
        title: 'Notification Testing',
        initialSize: 0.7,
        child: NotificationTestWidget(),
      ),
    );
  }

  void _showButtonModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(PSizes.s16)),
      ),
      builder: (context) => const PBottomSheet(
        title: 'Button Showcase',
        initialSize: 0.8,
        child: ButtonTest(),
      ),
    );
  }

  void _showInputModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(PSizes.s16)),
      ),
      builder: (context) => const PBottomSheet(
        title: 'Input Showcase',
        initialSize: 0.8,
        child: InputTest(),
      ),
    );
  }

  void _showCardModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(PSizes.s16)),
      ),
      builder: (context) => const PBottomSheet(
        title: 'Card Showcase',
        initialSize: 0.9,
        maxSize: 0.95,
        child: CardTest(),
      ),
    );
  }

  void _showSnackBarModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(PSizes.s16)),
      ),
      builder: (context) => const PBottomSheet(
        title: 'SnackBar Testing',
        initialSize: 0.7,
        child: SnackBarTest(),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Builder(
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: PSizes.s8),
        child: Container(
          padding: const EdgeInsets.all(PSizes.s12),
          decoration: BoxDecoration(
            color: context.pColor.neutral.n20,
            borderRadius: BorderRadius.circular(PSizes.s8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s14),
                  color: context.pColor.neutral.n60,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s14),
                  fontWeight: FontWeight.w500,
                  color: context.pColor.neutral.n80,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
