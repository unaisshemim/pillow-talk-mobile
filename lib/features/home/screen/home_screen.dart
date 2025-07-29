import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pillow_talk/utils/constant/router.dart';
import 'package:pillow_talk/utils/theme/theme_extension.dart';
import 'package:pillow_talk/utils/constant/sizes.dart';
import 'package:pillow_talk/utils/helpers/responsive_size.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pColor.neutral.n10,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.pColor.primary.base,
              ),
              child: Icon(
                Icons.favorite,
                size: 20,
                color: context.pColor.neutral.n10,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Pillow Talk',
              style: TextStyle(
                color: context.pColor.neutral.n10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: context.pColor.primary.base,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: context.pColor.neutral.n10,
            ),
            onPressed: () {
              context.pushNamed(PRouter.notification.name);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                  child: _buildMoodCard(
                    context,
                    'Your Mood',
                    '😊',
                    'Happy',
                    context.pColor.success.base,
                  ),
                ),
                const SizedBox(width: PSizes.s12),
                Expanded(
                  child: _buildMoodCard(
                    context,
                    'Partner\'s Mood',
                    '💭',
                    'Thoughtful',
                    context.pColor.secondary.base,
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
                _buildQuickAction(
                  context,
                  Icons.chat_bubble_outline,
                  'Chat',
                  context.pColor.primary.base,
                ),
                _buildQuickAction(
                  context,
                  Icons.favorite_outline,
                  'Send Love',
                  context.pColor.error.base,
                ),
                _buildQuickAction(
                  context,
                  Icons.psychology_outlined,
                  'Exercises',
                  context.pColor.secondary.base,
                ),
                _buildQuickAction(
                  context,
                  Icons.insights_outlined,
                  'Insights',
                  context.pColor.success.base,
                ),
              ],
            ),

            const SizedBox(height: PSizes.s24),

            // Today's Activities
            _buildSectionTitle(context, 'Today\'s Activities'),
            const SizedBox(height: PSizes.s12),
            _buildActivityCard(
              context,
              'Gratitude Exercise',
              'Share 3 things you\'re grateful for today',
              Icons.auto_awesome,
              context.pColor.primary.base,
              '10 min',
            ),
            const SizedBox(height: PSizes.s12),
            _buildActivityCard(
              context,
              'Communication Exercise',
              'Practice active listening with your partner',
              Icons.hearing,
              context.pColor.secondary.base,
              '15 min',
            ),
            const SizedBox(height: PSizes.s12),
            _buildActivityCard(
              context,
              'Mindful Moment',
              'Take a moment to breathe together',
              Icons.self_improvement,
              context.pColor.success.base,
              '5 min',
            ),

            const SizedBox(height: PSizes.s24),

            // Relationship Progress
            _buildSectionTitle(context, 'Your Progress'),
            const SizedBox(height: PSizes.s12),
            Container(
              padding: const EdgeInsets.all(PSizes.s16),
              decoration: BoxDecoration(
                color: context.pColor.neutral.n10,
                borderRadius: BorderRadius.circular(PSizes.s12),
                border: Border.all(color: context.pColor.neutral.n30),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Connection Score',
                        style: TextStyle(
                          fontSize: responsive(context, PSizes.s16),
                          fontWeight: FontWeight.w600,
                          color: context.pColor.neutral.n80,
                        ),
                      ),
                      Text(
                        '85%',
                        style: TextStyle(
                          fontSize: responsive(context, PSizes.s16),
                          fontWeight: FontWeight.bold,
                          color: context.pColor.primary.base,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: PSizes.s8),
                  LinearProgressIndicator(
                    value: 0.85,
                    backgroundColor: context.pColor.neutral.n30,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      context.pColor.primary.base,
                    ),
                  ),
                  const SizedBox(height: PSizes.s8),
                  Text(
                    'Great job! You\'ve completed 12 activities this week.',
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s14),
                      color: context.pColor.neutral.n60,
                    ),
                  ),
                ],
              ),
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

  Widget _buildMoodCard(BuildContext context, String title, String emoji,
      String mood, Color color) {
    return Container(
      padding: const EdgeInsets.all(PSizes.s16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(PSizes.s12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            emoji,
            style: TextStyle(fontSize: responsive(context, PSizes.s24)),
          ),
          const SizedBox(height: PSizes.s8),
          Text(
            title,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s12),
              color: context.pColor.neutral.n60,
            ),
          ),
          Text(
            mood,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s14),
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(
      BuildContext context, IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(PSizes.s16),
          ),
          child: Icon(
            icon,
            color: color,
            size: PSizes.s24,
          ),
        ),
        const SizedBox(height: PSizes.s8),
        Text(
          label,
          style: TextStyle(
            fontSize: responsive(context, PSizes.s12),
            color: context.pColor.neutral.n70,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityCard(BuildContext context, String title,
      String description, IconData icon, Color color, String duration) {
    return Container(
      padding: const EdgeInsets.all(PSizes.s16),
      decoration: BoxDecoration(
        color: context.pColor.neutral.n10,
        borderRadius: BorderRadius.circular(PSizes.s12),
        border: Border.all(color: context.pColor.neutral.n30),
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
            child: Icon(
              icon,
              color: color,
              size: PSizes.s24,
            ),
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
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: PSizes.s8,
              vertical: PSizes.s4,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(PSizes.s8),
            ),
            child: Text(
              duration,
              style: TextStyle(
                fontSize: responsive(context, PSizes.s12),
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
