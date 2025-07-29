import 'package:flutter/material.dart';
import 'package:pillow_talk/features/dev/widget/notification_test_widget.dart';
import 'package:pillow_talk/utils/theme/theme_extension.dart';
import 'package:pillow_talk/utils/constant/sizes.dart';
import 'package:pillow_talk/utils/helpers/responsive_size.dart';

class DevScreen extends StatelessWidget {
  const DevScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pColor.neutral.n20,
      appBar: AppBar(
        title: Text(
          'Developer Tools',
          style: TextStyle(
            color: context.pColor.neutral.n10,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: context.pColor.primary.base,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: context.pColor.neutral.n10,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(PSizes.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Info Section
            _buildInfoSection(
              context,
              'App Information',
              Icons.info_outline,
              [
                _buildInfoRow('App Name', 'Pillow Talk'),
                _buildInfoRow('Version', '1.0.0'),
                _buildInfoRow('Build', 'Development'),
                _buildInfoRow('Flutter Version', '3.5.1'),
                _buildInfoRow('Environment', 'Debug'),
              ],
            ),

            const SizedBox(height: PSizes.s24),

            // Notification Testing Section

            const NotificationTestWidget(),

            // Debug Tools Section

            const SizedBox(height: PSizes.s24),

            // Performance Section
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(
    BuildContext context,
    String title,
    IconData icon,
    List<Widget> infoRows,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: context.pColor.neutral.n10,
        borderRadius: BorderRadius.circular(PSizes.s16),
        boxShadow: [
          BoxShadow(
            color: context.pColor.neutral.n30.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(PSizes.s16),
            decoration: BoxDecoration(
              color: context.pColor.secondary.base.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(PSizes.s16),
                topRight: Radius.circular(PSizes.s16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: context.pColor.secondary.base,
                  size: 20,
                ),
                const SizedBox(width: PSizes.s12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s16),
                    fontWeight: FontWeight.bold,
                    color: context.pColor.neutral.n90,
                  ),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(PSizes.s16),
            child: Column(
              children: infoRows,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: PSizes.s4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: PSizes.s14,
              color: Color(0xFF6B7280),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: PSizes.s14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }
}
