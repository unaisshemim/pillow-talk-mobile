import 'package:flutter/material.dart';
import 'package:pillowtalk/common/ui/app_bar_title.dart';
import 'package:pillowtalk/common/ui/screen_container.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';

class PartnerScreen extends StatefulWidget {
  const PartnerScreen({super.key});

  @override
  State<PartnerScreen> createState() => _PartnerScreenState();
}

class _PartnerScreenState extends State<PartnerScreen> {
  bool isConnected = true; // Set to false to show search/connect UI
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PScreenContainer(
      backgroundColor: context.pColor.neutral.n10,
      appBar: PAppBarTitle(
        title: 'Partner',
        trailingAction: isConnected
            ? IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  color: context.pColor.neutral.n70,
                ),
                onPressed: () {
                  // Partner settings
                },
              )
            : null,
      ),
      child: isConnected ? _buildConnectedView() : _buildSearchView(),
    );
  }

  Widget _buildSearchView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(PSizes.s16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Section
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
                  'Find Your Partner 💕',
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s24),
                    fontWeight: FontWeight.bold,
                    color: context.pColor.neutral.n10,
                  ),
                ),
                const SizedBox(height: PSizes.s8),
                Text(
                  'Search for your partner to start your journey together',
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s16),
                    color: context.pColor.neutral.n10.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: PSizes.s24),

          // Search Input
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Enter partner\'s email or username',
              prefixIcon: Icon(Icons.search, color: context.pColor.neutral.n60),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.qr_code_scanner,
                  color: context.pColor.primary.base,
                ),
                onPressed: () {
                  // QR code scanner
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(PSizes.s12),
                borderSide: BorderSide(color: context.pColor.neutral.n40),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(PSizes.s12),
                borderSide: BorderSide(color: context.pColor.primary.base),
              ),
            ),
          ),

          const SizedBox(height: PSizes.s16),

          // Search Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Search for partner
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.pColor.primary.base,
                foregroundColor: context.pColor.neutral.n10,
                padding: const EdgeInsets.symmetric(vertical: PSizes.s16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(PSizes.s12),
                ),
              ),
              child: Text(
                'Search Partner',
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s16),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: PSizes.s24),

          // Alternative Connection Methods
          Text(
            'Other Ways to Connect',
            style: TextStyle(
              fontSize: responsive(context, PSizes.s18),
              fontWeight: FontWeight.bold,
              color: context.pColor.neutral.n80,
            ),
          ),

          const SizedBox(height: PSizes.s16),

          _buildConnectionOption(
            context,
            Icons.qr_code,
            'Scan QR Code',
            'Scan your partner\'s QR code to connect instantly',
            context.pColor.secondary.base,
          ),

          const SizedBox(height: PSizes.s12),

          _buildConnectionOption(
            context,
            Icons.share,
            'Share Invite Link',
            'Send an invitation link to your partner',
            context.pColor.success.base,
          ),

          const SizedBox(height: PSizes.s12),

          _buildConnectionOption(
            context,
            Icons.phone,
            'Connect via Phone',
            'Use phone number to find your partner',
            context.pColor.error.base,
          ),
        ],
      ),
    );
  }

  Widget _buildConnectedView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(PSizes.s16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Partner Profile Card
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
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/300?img=2',
                  ),
                ),
                const SizedBox(height: PSizes.s16),
                Text(
                  'John Smith',
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s24),
                    fontWeight: FontWeight.bold,
                    color: context.pColor.neutral.n10,
                  ),
                ),
                Text(
                  'Connected 2 years ago',
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s14),
                    color: context.pColor.neutral.n10.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: PSizes.s16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildConnectionStat(context, '85%', 'Connection'),
                    _buildConnectionStat(context, '24', 'Shared Tasks'),
                    _buildConnectionStat(context, '12', 'Goals Met'),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: PSizes.s24),

          // Quick Actions
          Text(
            'Quick Actions',
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
                child: _buildQuickActionCard(
                  context,
                  Icons.chat_bubble_outline,
                  'Send Message',
                  context.pColor.primary.base,
                ),
              ),
              const SizedBox(width: PSizes.s12),
              Expanded(
                child: _buildQuickActionCard(
                  context,
                  Icons.favorite_outline,
                  'Send Love',
                  context.pColor.error.base,
                ),
              ),
            ],
          ),

          const SizedBox(height: PSizes.s24),

          // Shared Tasks
          Text(
            'Shared Tasks',
            style: TextStyle(
              fontSize: responsive(context, PSizes.s18),
              fontWeight: FontWeight.bold,
              color: context.pColor.neutral.n80,
            ),
          ),

          const SizedBox(height: PSizes.s16),

          _buildTaskCard(
            context,
            'Daily Gratitude Exercise',
            'Share 3 things you\'re grateful for',
            '2/7 days completed',
            0.3,
            context.pColor.primary.base,
          ),

          const SizedBox(height: PSizes.s12),

          _buildTaskCard(
            context,
            'Weekly Date Planning',
            'Plan your next romantic date together',
            'Due tomorrow',
            0.8,
            context.pColor.secondary.base,
          ),

          const SizedBox(height: PSizes.s24),

          // Relationship Goals
          Text(
            'Relationship Goals',
            style: TextStyle(
              fontSize: responsive(context, PSizes.s18),
              fontWeight: FontWeight.bold,
              color: context.pColor.neutral.n80,
            ),
          ),

          const SizedBox(height: PSizes.s16),

          _buildGoalCard(
            context,
            'Better Communication',
            'Practice active listening daily',
            '75%',
            0.75,
            context.pColor.success.base,
          ),

          const SizedBox(height: PSizes.s12),

          _buildGoalCard(
            context,
            'Quality Time Together',
            'Spend 2 hours together daily',
            '60%',
            0.6,
            context.pColor.secondary.base,
          ),

          const SizedBox(height: PSizes.s24),

          // Analytics & Understanding
          Text(
            'Analytics & Understanding',
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
                child: _buildAnalyticsCard(
                  context,
                  'Love Language',
                  'Words of Affirmation',
                  Icons.psychology_outlined,
                  context.pColor.primary.base,
                ),
              ),
              const SizedBox(width: PSizes.s12),
              Expanded(
                child: _buildAnalyticsCard(
                  context,
                  'Communication Style',
                  'Direct & Honest',
                  Icons.chat_outlined,
                  context.pColor.secondary.base,
                ),
              ),
            ],
          ),

          const SizedBox(height: PSizes.s12),

          _buildInsightCard(
            context,
            'Weekly Insight',
            'You both have been more affectionate this week! Keep showing appreciation for each other.',
            Icons.lightbulb_outline,
            context.pColor.success.base,
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionOption(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    Color color,
  ) {
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
    );
  }

  Widget _buildConnectionStat(
    BuildContext context,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: responsive(context, PSizes.s20),
            fontWeight: FontWeight.bold,
            color: context.pColor.neutral.n10,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: responsive(context, PSizes.s12),
            color: context.pColor.neutral.n10.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(PSizes.s16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(PSizes.s12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: PSizes.s32),
          const SizedBox(height: PSizes.s8),
          Text(
            title,
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

  Widget _buildTaskCard(
    BuildContext context,
    String title,
    String description,
    String status,
    double progress,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(PSizes.s16),
      decoration: BoxDecoration(
        color: context.pColor.neutral.n10,
        borderRadius: BorderRadius.circular(PSizes.s12),
        border: Border.all(color: context.pColor.neutral.n30),
      ),
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
              Text(
                status,
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s12),
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: PSizes.s8),
          Text(
            description,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s14),
              color: context.pColor.neutral.n60,
            ),
          ),
          const SizedBox(height: PSizes.s12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: context.pColor.neutral.n30,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(
    BuildContext context,
    String title,
    String description,
    String percentage,
    double progress,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(PSizes.s16),
      decoration: BoxDecoration(
        color: context.pColor.neutral.n10,
        borderRadius: BorderRadius.circular(PSizes.s12),
        border: Border.all(color: context.pColor.neutral.n30),
      ),
      child: Row(
        children: [
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
                const SizedBox(height: PSizes.s8),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: context.pColor.neutral.n30,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ],
            ),
          ),
          const SizedBox(width: PSizes.s16),
          Text(
            percentage,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s18),
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(PSizes.s16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(PSizes.s12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: PSizes.s24),
          const SizedBox(height: PSizes.s8),
          Text(
            title,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s12),
              color: context.pColor.neutral.n60,
            ),
          ),
          Text(
            value,
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

  Widget _buildInsightCard(
    BuildContext context,
    String title,
    String insight,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(PSizes.s16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(PSizes.s12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: PSizes.s24),
          const SizedBox(width: PSizes.s16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s14),
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                const SizedBox(height: PSizes.s4),
                Text(
                  insight,
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s14),
                    color: context.pColor.neutral.n70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
