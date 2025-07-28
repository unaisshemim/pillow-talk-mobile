import 'package:flutter/material.dart';
import 'package:pillow_talk/utils/theme/theme_extension.dart';
import 'package:pillow_talk/utils/constant/sizes.dart';
import 'package:pillow_talk/utils/helpers/responsive_size.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pColor.neutral.n10,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            color: context.pColor.neutral.n10,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: context.pColor.primary.base,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.mark_email_read_outlined,
              color: context.pColor.neutral.n10,
            ),
            onPressed: () {
              // Mark all as read
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(PSizes.s16),
        children: [
          // Today Section
          _buildSectionHeader(context, 'Today'),
          const SizedBox(height: PSizes.s12),

          _buildNotificationCard(
            context,
            'Your partner sent you a love note 💕',
            'Sarah: "Thank you for making me coffee this morning. You\'re the best! ❤️"',
            Icons.favorite,
            context.pColor.error.base,
            '2 minutes ago',
            isUnread: true,
          ),

          const SizedBox(height: PSizes.s8),

          _buildNotificationCard(
            context,
            'Daily Check-in Reminder',
            'Don\'t forget to share how you\'re feeling today with your partner.',
            Icons.psychology_outlined,
            context.pColor.secondary.base,
            '1 hour ago',
            isUnread: true,
          ),

          const SizedBox(height: PSizes.s8),

          _buildNotificationCard(
            context,
            'New Activity Available',
            'Try the "5 Love Languages Quiz" together to discover your communication styles.',
            Icons.auto_awesome,
            context.pColor.primary.base,
            '3 hours ago',
            isUnread: false,
          ),

          const SizedBox(height: PSizes.s24),

          // Yesterday Section
          _buildSectionHeader(context, 'Yesterday'),
          const SizedBox(height: PSizes.s12),

          _buildNotificationCard(
            context,
            'Weekly Progress Update',
            'Congratulations! You completed 85% of your relationship goals this week.',
            Icons.insights_outlined,
            context.pColor.success.base,
            'Yesterday, 8:30 PM',
            isUnread: false,
          ),

          const SizedBox(height: PSizes.s8),

          _buildNotificationCard(
            context,
            'Gratitude Exercise Completed',
            'John completed the gratitude exercise. Check out what he\'s thankful for!',
            Icons.celebration_outlined,
            context.pColor.secondary.base,
            'Yesterday, 6:15 PM',
            isUnread: false,
          ),

          const SizedBox(height: PSizes.s8),

          _buildNotificationCard(
            context,
            'Chat Message',
            'John: "Looking forward to our date night tomorrow! 🌟"',
            Icons.chat_bubble_outline,
            context.pColor.primary.base,
            'Yesterday, 2:20 PM',
            isUnread: false,
          ),

          const SizedBox(height: PSizes.s24),

          // This Week Section
          _buildSectionHeader(context, 'This Week'),
          const SizedBox(height: PSizes.s12),

          _buildNotificationCard(
            context,
            'Mindfulness Session Reminder',
            'Time for your weekly mindfulness session together. Perfect for Sunday morning!',
            Icons.self_improvement,
            context.pColor.success.base,
            '3 days ago',
            isUnread: false,
          ),

          const SizedBox(height: PSizes.s8),

          _buildNotificationCard(
            context,
            'Relationship Tip',
            'Tip of the week: Practice active listening by putting away devices during conversations.',
            Icons.lightbulb_outline,
            context.pColor.secondary.base,
            '5 days ago',
            isUnread: false,
          ),

          const SizedBox(height: PSizes.s8),

          _buildNotificationCard(
            context,
            'Anniversary Reminder',
            'Your 2-year anniversary is coming up in 2 weeks! Plan something special.',
            Icons.calendar_today_outlined,
            context.pColor.error.base,
            '6 days ago',
            isUnread: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: responsive(context, PSizes.s18),
        fontWeight: FontWeight.bold,
        color: context.pColor.neutral.n80,
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context,
    String title,
    String message,
    IconData icon,
    Color iconColor,
    String timestamp, {
    bool isUnread = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(PSizes.s16),
      decoration: BoxDecoration(
        color:
            isUnread ? context.pColor.primary.p10 : context.pColor.neutral.n10,
        borderRadius: BorderRadius.circular(PSizes.s12),
        border: Border.all(
          color: isUnread
              ? context.pColor.primary.p30
              : context.pColor.neutral.n30,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(PSizes.s12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: PSizes.s24,
            ),
          ),

          const SizedBox(width: PSizes.s16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: responsive(context, PSizes.s16),
                          fontWeight: FontWeight.w600,
                          color: context.pColor.neutral.n80,
                        ),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: context.pColor.primary.base,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: PSizes.s4),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s14),
                    color: context.pColor.neutral.n60,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: PSizes.s8),
                Text(
                  timestamp,
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s12),
                    color: context.pColor.neutral.n50,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
