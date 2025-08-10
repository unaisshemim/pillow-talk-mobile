import 'package:flutter/material.dart';
import 'package:pillowtalk/common/widget/cards/card.dart';
import 'package:pillowtalk/common/widget/cards/mood_card.dart';
import 'package:pillowtalk/common/widget/cards/quick_action_card.dart';
import 'package:pillowtalk/common/widget/cards/activtiy_card.dart';
import 'package:pillowtalk/common/widget/cards/progress_card.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';

class CardTest extends StatelessWidget {
  const CardTest({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(PSizes.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            _buildSectionTitle(context, 'Basic Card (PCard)'),
            const SizedBox(height: PSizes.s12),

            // Basic PCard Examples
            PCard(
              child: Text(
                'Basic Card with Default Styling',
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s16),
                  color: context.pColor.neutral.n80,
                ),
              ),
            ),

            const SizedBox(height: PSizes.s12),

            PCard(
              backgroundColor: context.pColor.primary.base.withOpacity(0.1),
              border: Border.all(color: context.pColor.primary.base),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Custom Styled Card',
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s16),
                      fontWeight: FontWeight.bold,
                      color: context.pColor.primary.base,
                    ),
                  ),
                  const SizedBox(height: PSizes.s8),
                  Text(
                    'This card has custom background color and border',
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s14),
                      color: context.pColor.neutral.n70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: PSizes.s12),

            PCard(
              backgroundColor: context.pColor.success.base.withOpacity(0.1),
              borderRadius: BorderRadius.circular(PSizes.s20),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tappable Card Clicked!')),
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.touch_app,
                    color: context.pColor.success.base,
                    size: PSizes.s24,
                  ),
                  const SizedBox(width: PSizes.s12),
                  Expanded(
                    child: Text(
                      'Tappable Card with Custom Border Radius',
                      style: TextStyle(
                        fontSize: responsive(context, PSizes.s16),
                        color: context.pColor.success.base,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: PSizes.s24),

            // Mood Cards Section
            _buildSectionTitle(context, 'Mood Cards'),
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
                    title: 'Partner Mood',
                    emoji: '💭',
                    mood: 'Thoughtful',
                    color: context.pColor.secondary.base,
                  ),
                ),
              ],
            ),

            const SizedBox(height: PSizes.s12),

            Row(
              children: [
                Expanded(
                  child: MoodCard(
                    title: 'Today',
                    emoji: '🚀',
                    mood: 'Excited',
                    color: context.pColor.primary.base,
                  ),
                ),
                const SizedBox(width: PSizes.s12),
                Expanded(
                  child: MoodCard(
                    title: 'Energy',
                    emoji: '😴',
                    mood: 'Tired',
                    color: context.pColor.error.base,
                  ),
                ),
              ],
            ),

            const SizedBox(height: PSizes.s24),

            // Quick Action Cards Section
            _buildSectionTitle(context, 'Quick Action Cards'),
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
                  label: 'Love',
                  color: context.pColor.error.base,
                ),
                QuickActionCard(
                  icon: Icons.psychology_outlined,
                  label: 'Mind',
                  color: context.pColor.secondary.base,
                ),
                QuickActionCard(
                  icon: Icons.insights_outlined,
                  label: 'Stats',
                  color: context.pColor.success.base,
                ),
              ],
            ),

            const SizedBox(height: PSizes.s16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                QuickActionCard(
                  icon: Icons.music_note,
                  label: 'Music',
                  color: context.pColor.primary.base,
                ),
                QuickActionCard(
                  icon: Icons.camera_alt,
                  label: 'Photo',
                  color: context.pColor.secondary.base,
                ),
                QuickActionCard(
                  icon: Icons.book_outlined,
                  label: 'Journal',
                  color: context.pColor.success.base,
                ),
                QuickActionCard(
                  icon: Icons.settings,
                  label: 'Settings',
                  color: context.pColor.neutral.n60,
                ),
              ],
            ),

            const SizedBox(height: PSizes.s24),

            // Activity Cards Section
            _buildSectionTitle(context, 'Activity Cards'),
            const SizedBox(height: PSizes.s12),

            ActivityCard(
              title: 'Morning Meditation',
              description: 'Start your day with mindfulness and peace',
              icon: Icons.self_improvement,
              color: context.pColor.primary.base,
              duration: '10 min',
            ),

            const SizedBox(height: PSizes.s12),

            ActivityCard(
              title: 'Couple Exercise',
              description: 'Strengthen your bond through shared activities',
              icon: Icons.fitness_center,
              color: context.pColor.success.base,
              duration: '30 min',
            ),

            const SizedBox(height: PSizes.s12),

            ActivityCard(
              title: 'Gratitude Practice',
              description: 'Share three things you\'re grateful for today',
              icon: Icons.auto_awesome,
              color: context.pColor.secondary.base,
              duration: '5 min',
            ),

            const SizedBox(height: PSizes.s12),

            ActivityCard(
              title: 'Communication Check',
              description: 'Practice active listening with your partner',
              icon: Icons.hearing,
              color: context.pColor.error.base,
              duration: '15 min',
            ),

            const SizedBox(height: PSizes.s24),

            // Progress Cards Section
            _buildSectionTitle(context, 'Progress Cards'),
            const SizedBox(height: PSizes.s12),

            ProgressCard(
              title: 'Relationship Score',
              progressValue: 0.85,
              percentageText: '85%',
              description:
                  'Great job! You\'ve completed 12 activities this week.',
            ),

            const SizedBox(height: PSizes.s12),

            ProgressCard(
              title: 'Weekly Goals',
              progressValue: 0.60,
              percentageText: '60%',
              description: 'Keep going! You\'re more than halfway there.',
            ),

            const SizedBox(height: PSizes.s12),

            ProgressCard(
              title: 'Communication Skills',
              progressValue: 0.92,
              percentageText: '92%',
              description: 'Excellent progress in your communication journey!',
            ),

            const SizedBox(height: PSizes.s12),

            ProgressCard(
              title: 'Daily Check-ins',
              progressValue: 0.40,
              percentageText: '40%',
              description: 'Try to be more consistent with daily check-ins.',
            ),

            const SizedBox(height: PSizes.s24),

            // Mixed Card Layout Example
            _buildSectionTitle(context, 'Mixed Layout Example'),
            const SizedBox(height: PSizes.s12),

            PCard(
              backgroundColor: context.pColor.neutral.n20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dashboard Overview',
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s18),
                      fontWeight: FontWeight.bold,
                      color: context.pColor.neutral.n80,
                    ),
                  ),
                  const SizedBox(height: PSizes.s16),

                  Row(
                    children: [
                      Expanded(
                        child: MoodCard(
                          title: 'Status',
                          emoji: '✨',
                          mood: 'Great',
                          color: context.pColor.primary.base,
                        ),
                      ),
                      const SizedBox(width: PSizes.s12),
                      Expanded(
                        child: MoodCard(
                          title: 'Energy',
                          emoji: '⚡',
                          mood: 'High',
                          color: context.pColor.success.base,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: PSizes.s16),

                  ProgressCard(
                    title: 'Overall Progress',
                    progressValue: 0.75,
                    percentageText: '75%',
                    description:
                        'You\'re doing amazing! Keep up the great work.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: PSizes.s24),
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
