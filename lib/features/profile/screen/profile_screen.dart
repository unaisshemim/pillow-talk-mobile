import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pillowtalk/common/common/screen_container.dart';
import 'package:pillowtalk/common/common/app_bar_title.dart';
import 'package:pillowtalk/utils/constant/router.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String selectedTab = 'Dashboard';

  @override
  Widget build(BuildContext context) {
    return PScreenContainer(
      backgroundColor: context.pColor.neutral.n20,
      appBar: PAppBarTitle(
        title: 'Profile',
        trailingAction: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.settings, color: context.pColor.neutral.n70),
              onPressed: () => {
                context.pushNamed(PRouter.setting.name),
                log("Navigating to Settings"),
              },
            ),
            IconButton(
              icon: Icon(Icons.help_outline, color: context.pColor.neutral.n70),
              onPressed: () => _navigateToHelp(),
            ),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Horizontal Tab Selector
            const SizedBox(height: PSizes.s16),

            // Content based on selected tab
            _buildDashboardContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PSizes.s16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Promotional Card Section
          _buildPromotionalCard(),

          const SizedBox(height: PSizes.s24),

          // Quote Section
          _buildQuoteSection(),

          const SizedBox(height: PSizes.s24),

          // Full-Width Action Button
          _buildUnlockPremiumButton(),

          const SizedBox(height: PSizes.s24),

          // Stats Section
          _buildStatsSection(),

          const SizedBox(height: PSizes.s32),
        ],
      ),
    );
  }

  Widget _buildPromotionalCard() {
    return Container(
      padding: const EdgeInsets.all(PSizes.s16),
      decoration: BoxDecoration(
        color: context.pColor.neutral.n10,
        borderRadius: BorderRadius.circular(PSizes.s12),
        boxShadow: [
          BoxShadow(
            color: context.pColor.neutral.n30.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Strengthen Your Bond',
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s18),
                    fontWeight: FontWeight.bold,
                    color: context.pColor.neutral.n90,
                  ),
                ),
                const SizedBox(height: PSizes.s8),
                Text(
                  'Discover personalized conversation starters and relationship insights to deepen your connection.',
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s14),
                    color: context.pColor.neutral.n60,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: PSizes.s16),
                ElevatedButton(
                  onPressed: () => _navigateToLearnMore(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.pColor.primary.base,
                    foregroundColor: context.pColor.neutral.n10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(PSizes.s8),
                    ),
                  ),
                  child: const Text('Learn More'),
                ),
              ],
            ),
          ),
          const SizedBox(width: PSizes.s16),
          Expanded(
            flex: 1,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: context.pColor.primary.base.withOpacity(0.1),
                borderRadius: BorderRadius.circular(PSizes.s8),
              ),
              child: Icon(
                Icons.favorite,
                size: 40,
                color: context.pColor.primary.base,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(PSizes.s24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.pColor.primary.base.withOpacity(0.1),
            context.pColor.secondary.base.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(PSizes.s12),
      ),
      child: Column(
        children: [
          Icon(
            Icons.format_quote,
            size: 32,
            color: context.pColor.primary.base,
          ),
          const SizedBox(height: PSizes.s16),
          Text(
            '"The best relationships are the ones where you can be yourself and still be loved."',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s16),
              fontStyle: FontStyle.italic,
              color: context.pColor.neutral.n80,
              height: 1.5,
            ),
          ),
          const SizedBox(height: PSizes.s16),
          Text(
            'Dr. Sarah Mitchell',
            style: TextStyle(
              fontSize: responsive(context, PSizes.s14),
              fontWeight: FontWeight.w600,
              color: context.pColor.neutral.n70,
            ),
          ),
          const SizedBox(height: PSizes.s4),
          Text(
            'Today',
            style: TextStyle(
              fontSize: responsive(context, PSizes.s12),
              color: context.pColor.neutral.n60,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnlockPremiumButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.pColor.primary.base, context.pColor.secondary.base],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(PSizes.s12),
      ),
      child: ElevatedButton(
        onPressed: () => _navigateToUnlockPremium(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PSizes.s12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: context.pColor.neutral.n10, size: 24),
            const SizedBox(width: PSizes.s8),
            Text(
              'Unlock Premium',
              style: TextStyle(
                fontSize: responsive(context, PSizes.s16),
                fontWeight: FontWeight.w600,
                color: context.pColor.neutral.n10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Stats',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s20),
            fontWeight: FontWeight.bold,
            color: context.pColor.neutral.n90,
          ),
        ),
        const SizedBox(height: PSizes.s16),
        Row(
          children: [
            Expanded(child: _buildStatCard('156', 'Conversations', Icons.chat)),
            const SizedBox(width: PSizes.s12),
            Expanded(
              child: _buildStatCard('23', 'Goals Met', Icons.check_circle),
            ),
          ],
        ),
        const SizedBox(height: PSizes.s12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard('2 Years', 'Together', Icons.favorite),
            ),
            const SizedBox(width: PSizes.s12),
            Expanded(
              child: _buildStatCard(
                '89%',
                'Happiness',
                Icons.sentiment_very_satisfied,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(PSizes.s16),
      decoration: BoxDecoration(
        color: context.pColor.neutral.n10,
        borderRadius: BorderRadius.circular(PSizes.s12),
        border: Border.all(color: context.pColor.neutral.n30),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: context.pColor.primary.base),
          const SizedBox(height: PSizes.s8),
          Text(
            value,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s18),
              fontWeight: FontWeight.bold,
              color: context.pColor.neutral.n90,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s12),
              color: context.pColor.neutral.n60,
            ),
          ),
        ],
      ),
    );
  }

  // Navigation methods (no logic, just placeholders)

  void _navigateToHelp() {
    // Navigate to help screen
  }

  void _navigateToLearnMore() {
    // Navigate to learn more screen
  }

  void _navigateToUnlockPremium() {
    // Navigate to premium screen
  }
}
