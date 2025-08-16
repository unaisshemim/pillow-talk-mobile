import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pillowtalk/common/common/app_bar_title.dart';
import 'package:pillowtalk/common/common/screen_container.dart';
import 'package:pillowtalk/common/common/cards/mood_card.dart';
import 'package:pillowtalk/common/common/cards/quick_action_card.dart';
import 'package:pillowtalk/common/common/cards/activtiy_card.dart';
import 'package:pillowtalk/utils/constant/router.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/common/common/cards/progress_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PScreenContainer(
      backgroundColor: context.pColor.neutral.n10,
      appBar: PAppBarTitle(
        title: 'Pillow Talk',
        leadingIcon: Icons.favorite,
        trailingAction: IconButton(
          icon: Icon(
            Icons.notifications_outlined,
            color: context.pColor.neutral.n70,
          ),
          onPressed: () {
            context.pushNamed(PRouter.notification.name);
          },
        ),
      ),
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
                    'Good Morning, Sarah & John! 💕',
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s24),
                      fontWeight: FontWeight.bold,
                      color: context.pColor.neutral.n10,
                    ),
                  ),
                  const SizedBox(height: PSizes.s8),
                  Text(
                    'How are you feeling as a couple today?',
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s16),
                      color: context.pColor.neutral.n10.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: PSizes.s24),

            // Daily Check-in
            _buildSectionTitle(context, 'Daily Check-in'),
            const SizedBox(height: PSizes.s12),
            Row(
              children: [
                Expanded(
                  child: MoodCard(
                    title: 'Your Mood',
                    emoji: '😊',
                    mood: 'Happy',
                    color: context.pColor.success.base,
                  ),
                ),
                const SizedBox(width: PSizes.s12),
                Expanded(
                  child: MoodCard(
                    title: 'Partner\'s Mood',
                    emoji: '💭',
                    mood: 'Thoughtful',
                    color: context.pColor.secondary.base,
                  ),
                ),
              ],
            ),

            const SizedBox(height: PSizes.s24),

            // Quick Actions
            _buildSectionTitle(context, 'Quick Actions'),
            const SizedBox(height: PSizes.s12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                QuickActionCard(
                  icon: Icons.chat_bubble_outline,
                  label: 'Chat',
                  color: context.pColor.primary.base,
                ),
                QuickActionCard(
                  icon: Icons.favorite_outline,
                  label: 'Send Love',
                  color: context.pColor.error.base,
                ),
                QuickActionCard(
                  icon: Icons.psychology_outlined,
                  label: 'Exercises',
                  color: context.pColor.secondary.base,
                ),
                QuickActionCard(
                  icon: Icons.insights_outlined,
                  label: 'Insights',
                  color: context.pColor.success.base,
                ),
              ],
            ),

            const SizedBox(height: PSizes.s24),

            // Today's Activities
            _buildSectionTitle(context, 'Today\'s Activities'),
            const SizedBox(height: PSizes.s12),
            ActivityCard(
              title: 'Gratitude Exercise',
              description: 'Share 3 things you\'re grateful for today',
              icon: Icons.auto_awesome,
              color: context.pColor.primary.base,
              duration: '10 min',
            ),
            const SizedBox(height: PSizes.s12),
            ActivityCard(
              title: 'Communication Exercise',
              description: 'Practice active listening with your partner',
              icon: Icons.hearing,
              color: context.pColor.secondary.base,
              duration: '15 min',
            ),
            const SizedBox(height: PSizes.s12),
            ActivityCard(
              title: 'Mindful Moment',
              description: 'Take a moment to breathe together',
              icon: Icons.self_improvement,
              color: context.pColor.success.base,
              duration: '5 min',
            ),

            const SizedBox(height: PSizes.s24),

            // Relationship Progress
            _buildSectionTitle(context, 'Your Progress'),
            const SizedBox(height: PSizes.s12),
            ProgressCard(
              title: 'Connection Score',
              progressValue: 0.85,
              percentageText: '85%',
              description:
                  'Great job! You\'ve completed 12 activities this week.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: responsive(context, PSizes.s20),
        fontWeight: FontWeight.bold,
        color: context.pColor.neutral.n80,
      ),
    );
  }
}
