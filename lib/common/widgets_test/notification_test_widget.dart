import 'package:flutter/material.dart';
import 'package:pillow_talk/common/services/notification_service.dart';
import 'package:pillow_talk/utils/theme/theme_extension.dart';
import 'package:pillow_talk/utils/constant/sizes.dart';

/// Widget to test different notification types in Pillow Talk app
class NotificationTestWidget extends StatelessWidget {
  const NotificationTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(PSizes.s16),
      padding: const EdgeInsets.all(PSizes.s16),
      decoration: BoxDecoration(
        color: context.pColor.neutral.n20,
        borderRadius: BorderRadius.circular(PSizes.s12),
        border: Border.all(
          color: context.pColor.primary.base.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.notifications_active,
                color: context.pColor.primary.base,
                size: 20,
              ),
              const SizedBox(width: PSizes.s8),
              Text(
                'Notification Testing',
                style: TextStyle(
                  fontSize: PSizes.s16,
                  fontWeight: FontWeight.bold,
                  color: context.pColor.neutral.n90,
                ),
              ),
            ],
          ),
          const SizedBox(height: PSizes.s16),
          
          // Permission Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                await PillowTalkNotificationService.requestNotificationPermissions(context);
              },
              icon: const Icon(Icons.security, size: 18),
              label: const Text('Request Permissions'),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.pColor.primary.base,
                foregroundColor: context.pColor.neutral.n10,
                padding: const EdgeInsets.symmetric(vertical: PSizes.s12),
              ),
            ),
          ),
          
          const SizedBox(height: PSizes.s12),
          
          // Test Buttons Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.5,
            mainAxisSpacing: PSizes.s8,
            crossAxisSpacing: PSizes.s8,
            children: [
              _buildTestButton(
                context,
                'Love Note',
                Icons.favorite,
                () => PillowTalkNotificationService.sendLoveNote(
                  title: 'Sweet Reminder',
                  message: 'You are amazing and loved! 💕',
                  partnerName: 'Your Partner',
                ),
              ),
              _buildTestButton(
                context,
                'Chat Message',
                Icons.chat_bubble,
                () => PillowTalkNotificationService.sendChatMessage(
                  senderName: 'Sarah',
                  message: 'Hey babe, how was your day? 😊',
                ),
              ),
              _buildTestButton(
                context,
                'Reminder',
                Icons.alarm,
                () => PillowTalkNotificationService.sendRelationshipReminder(
                  title: 'Date Night',
                  message: 'Don\'t forget about your dinner date tonight!',
                  activityType: 'date',
                ),
              ),
              _buildTestButton(
                context,
                'Milestone',
                Icons.celebration,
                () => PillowTalkNotificationService.sendMilestone(
                  title: 'Relationship Milestone',
                  message: 'Congratulations! You\'ve been together for 6 months! 🎉',
                ),
              ),
              _buildTestButton(
                context,
                'Mood Check',
                Icons.emoji_emotions,
                () => PillowTalkNotificationService.sendMoodCheckIn(),
              ),
              _buildTestButton(
                context,
                'Cancel All',
                Icons.clear_all,
                () => PillowTalkNotificationService.cancelAllNotifications(),
              ),
            ],
          ),
          
          const SizedBox(height: PSizes.s12),
          
          // Schedule Daily Love Notes
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () async {
                // Schedule daily love notes at 9 AM
                await PillowTalkNotificationService.scheduleDailyLoveNotes(
                  hour: 9,
                  minute: 0,
                );
                
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Daily love notes scheduled for 9:00 AM!'),
                      backgroundColor: context.pColor.success.base,
                    ),
                  );
                }
              },
              icon: const Icon(Icons.schedule, size: 18),
              label: const Text('Schedule Daily Love Notes'),
              style: OutlinedButton.styleFrom(
                foregroundColor: context.pColor.primary.base,
                side: BorderSide(color: context.pColor.primary.base),
                padding: const EdgeInsets.symmetric(vertical: PSizes.s12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Material(
      color: context.pColor.neutral.n10,
      borderRadius: BorderRadius.circular(PSizes.s8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(PSizes.s8),
        child: Container(
          padding: const EdgeInsets.all(PSizes.s8),
          decoration: BoxDecoration(
            border: Border.all(
              color: context.pColor.neutral.n30,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(PSizes.s8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: context.pColor.primary.base,
              ),
              const SizedBox(height: PSizes.s4),
              Text(
                label,
                style: TextStyle(
                  fontSize: PSizes.s12,
                  fontWeight: FontWeight.w500,
                  color: context.pColor.neutral.n80,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
