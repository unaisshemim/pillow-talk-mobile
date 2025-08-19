import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillowtalk/common/ui/app_bar_title.dart';
import 'package:pillowtalk/common/ui/screen_container.dart';
import 'package:pillowtalk/features/insights/widgets/mood_trend_chart.dart';
import 'package:pillowtalk/features/insights/widgets/activity_chart.dart';
import 'package:pillowtalk/features/insights/widgets/connection_score_widget.dart';
import 'package:pillowtalk/features/insights/widgets/insights_summary_card.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

class InsightsScreen extends ConsumerStatefulWidget {
  const InsightsScreen({super.key});

  @override
  ConsumerState<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends ConsumerState<InsightsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PScreenContainer(
      backgroundColor: context.pColor.neutral.n10,
      appBar: PAppBarTitle(
        title: 'Relationship Insights',
        leadingIcon: Icons.insights,
        isBackButtonNeeded: true,
      ),
      child: Column(
        children: [
          // Custom Tab Bar
          Container(
            margin: const EdgeInsets.all(PSizes.s16),
            decoration: BoxDecoration(
              color: context.pColor.neutral.n20,
              borderRadius: BorderRadius.circular(PSizes.s12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildTabButton(
                    'Your Insights',
                    Icons.person,
                    0,
                    context.pColor.primary.base,
                  ),
                ),
                Expanded(
                  child: _buildTabButton(
                    'Partner Insights',
                    Icons.favorite,
                    1,
                    context.pColor.secondary.base,
                  ),
                ),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildUserInsights(), _buildPartnerInsights()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, IconData icon, int index, Color color) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => _tabController.animateTo(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          vertical: PSizes.s12,
          horizontal: PSizes.s16,
        ),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(PSizes.s10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: PSizes.s16,
              color: isSelected
                  ? context.pColor.neutral.n10
                  : context.pColor.neutral.n60,
            ),
            const SizedBox(width: PSizes.s8),
            Text(
              title,
              style: TextStyle(
                fontSize: responsive(context, PSizes.s14),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? context.pColor.neutral.n10
                    : context.pColor.neutral.n60,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInsights() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: PSizes.s16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards Row
          Row(
            children: [
              Expanded(
                child: InsightsSummaryCard(
                  title: 'Mood Score',
                  value: '8.5',
                  subtitle: 'This Week',
                  color: context.pColor.success.base,
                  icon: Icons.mood,
                  trend: '+12%',
                ),
              ),
              const SizedBox(width: PSizes.s12),
              Expanded(
                child: InsightsSummaryCard(
                  title: 'Activities',
                  value: '12',
                  subtitle: 'Completed',
                  color: context.pColor.primary.base,
                  icon: Icons.check_circle,
                  trend: '+3',
                ),
              ),
            ],
          ),

          const SizedBox(height: PSizes.s20),

          // Connection Score
          _buildSectionTitle('Connection Score'),
          const SizedBox(height: PSizes.s12),
          ConnectionScoreWidget(
            score: 85,
            color: context.pColor.primary.base,
            isUser: true,
          ),

          const SizedBox(height: PSizes.s20),

          // Mood Trends
          _buildSectionTitle('Mood Trends (7 Days)'),
          const SizedBox(height: PSizes.s12),
          MoodTrendChart(isUser: true, color: context.pColor.primary.base),

          const SizedBox(height: PSizes.s20),

          // Activity Breakdown
          _buildSectionTitle('Weekly Activity'),
          const SizedBox(height: PSizes.s12),
          ActivityChart(isUser: true, color: context.pColor.primary.base),

          const SizedBox(height: PSizes.s20),
        ],
      ),
    );
  }

  Widget _buildPartnerInsights() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: PSizes.s16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards Row
          Row(
            children: [
              Expanded(
                child: InsightsSummaryCard(
                  title: 'Mood Score',
                  value: '7.8',
                  subtitle: 'This Week',
                  color: context.pColor.success.base,
                  icon: Icons.mood,
                  trend: '+8%',
                ),
              ),
              const SizedBox(width: PSizes.s12),
              Expanded(
                child: InsightsSummaryCard(
                  title: 'Activities',
                  value: '9',
                  subtitle: 'Completed',
                  color: context.pColor.secondary.base,
                  icon: Icons.check_circle,
                  trend: '+2',
                ),
              ),
            ],
          ),

          const SizedBox(height: PSizes.s20),

          // Connection Score
          _buildSectionTitle('Connection Score'),
          const SizedBox(height: PSizes.s12),
          ConnectionScoreWidget(
            score: 78,
            color: context.pColor.secondary.base,
            isUser: false,
          ),

          const SizedBox(height: PSizes.s20),

          // Mood Trends
          _buildSectionTitle('Mood Trends (7 Days)'),
          const SizedBox(height: PSizes.s12),
          MoodTrendChart(isUser: false, color: context.pColor.secondary.base),

          const SizedBox(height: PSizes.s20),

          // Activity Breakdown
          _buildSectionTitle('Weekly Activity'),
          const SizedBox(height: PSizes.s12),
          ActivityChart(isUser: false, color: context.pColor.secondary.base),

          const SizedBox(height: PSizes.s20),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: responsive(context, PSizes.s18),
        fontWeight: FontWeight.bold,
        color: context.pColor.neutral.n80,
      ),
    );
  }
}
