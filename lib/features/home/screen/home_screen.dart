import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pillowtalk/common/ui/app_bar_title.dart';
import 'package:pillowtalk/common/ui/screen_container.dart';
import 'package:pillowtalk/common/ui/cards/mood_card.dart';
import 'package:pillowtalk/common/ui/cards/quick_action_card.dart';
import 'package:pillowtalk/common/ui/cards/activtiy_card.dart';
import 'package:pillowtalk/common/ui/snackBar.dart';

import 'package:pillowtalk/features/profile/provider/profile_provider.dart';
import 'package:pillowtalk/utils/constant/router.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/common/ui/cards/progress_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String userName = "";
  String selectedMood = "Happy";
  String selectedMoodEmoji = "😊";
  Color selectedMoodColor = Colors.green;

  // Temporary state for modal selection
  String tempSelectedMood = "Happy";
  String tempSelectedMoodEmoji = "😊";
  Color tempSelectedMoodColor = Colors.green;

  @override
  void initState() {
    super.initState();
    Future.microtask(_loadProfileIntoControllers);
  }

  Future<void> _loadProfileIntoControllers() async {
    final profile = await ref
        .read(profileNotifierProvider.notifier)
        .getUserProfile();

    if (!mounted || profile == null) return;
    setState(() {
      userName = (profile.name?.isNotEmpty ?? false)
          ? '${profile.name![0].toUpperCase()}${profile.name!.substring(1)}'
          : '';
    });
  }

  void _showMoodSelectionModal() {
    // Initialize temporary state with current selection
    setState(() {
      tempSelectedMood = selectedMood;
      tempSelectedMoodEmoji = selectedMoodEmoji;
      tempSelectedMoodColor = selectedMoodColor;
    });

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildMoodSelectionBottomSheet(),
    );
  }

  Widget _buildMoodSelectionBottomSheet() {
    final moods = [
      {'title': 'Happy', 'icon': '😊', 'color': context.pColor.success.base},
      {
        'title': 'Thoughtful',
        'icon': '🤔',
        'color': context.pColor.secondary.base,
      },
      {'title': 'Excited', 'icon': '🤩', 'color': context.pColor.primary.base},
      {'title': 'Calm', 'icon': '😌', 'color': context.pColor.neutral.n60},
    ];

    return StatefulBuilder(
      builder: (context, setModalState) {
        return Container(
          decoration: BoxDecoration(
            color: context.pColor.neutral.n10,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(PSizes.s20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: PSizes.s12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.pColor.neutral.n40,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  PSizes.s20,
                  PSizes.s20,
                  PSizes.s20,
                  PSizes.s16,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Daily Check-in',
                          style: TextStyle(
                            fontSize: responsive(context, PSizes.s20),
                            fontWeight: FontWeight.bold,
                            color: context.pColor.neutral.n80,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.close,
                            color: context.pColor.neutral.n60,
                            size: PSizes.s20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: PSizes.s8),
                    Text(
                      'How are you feeling today? Swipe to explore moods →',
                      style: TextStyle(
                        fontSize: responsive(context, PSizes.s14),
                        color: context.pColor.neutral.n60,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Horizontally Scrollable Mood Cards
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: PSizes.s20),
                  itemCount: moods.length,
                  itemBuilder: (context, index) {
                    final mood = moods[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index < moods.length - 1 ? PSizes.s16 : 0,
                      ),
                      child: _buildHorizontalMoodCard(
                        mood['title'] as String,
                        mood['icon'] as String,
                        mood['color'] as Color,
                        setModalState, // Pass the modal setState
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: PSizes.s20),

              // Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: PSizes.s20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Apply the temporary selection to the actual state
                      setState(() {
                        selectedMood = tempSelectedMood;
                        selectedMoodEmoji = tempSelectedMoodEmoji;
                        selectedMoodColor = tempSelectedMoodColor;
                      });

                      Navigator.pop(context);
                      // You can add additional logic here like saving to backend
                      PSnackBar.showSuccess(
                        context,
                        message: 'Mood updated to $tempSelectedMood! 🎉',
                        duration: const Duration(seconds: 2),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tempSelectedMoodColor,
                      foregroundColor: context.pColor.neutral.n10,
                      padding: const EdgeInsets.symmetric(vertical: PSizes.s16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(PSizes.s12),
                      ),
                      elevation: 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tempSelectedMoodEmoji,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: PSizes.s8),
                        Text(
                          'Set $tempSelectedMood Mood',
                          style: TextStyle(
                            fontSize: responsive(context, PSizes.s16),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom padding
              const SizedBox(height: PSizes.s24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHorizontalMoodCard(
    String title,
    String icon,

    Color color,
    StateSetter setModalState,
  ) {
    final isSelected = tempSelectedMood == title;

    return GestureDetector(
      onTap: () {
        print('Tapping mood: $title'); // Debug print
        setModalState(() {
          tempSelectedMood = title;
          tempSelectedMoodEmoji = icon;
          tempSelectedMoodColor = color;
        });
        print('Updated tempSelectedMood to: $tempSelectedMood'); // Debug print
        // Only update temporary state, not the actual home state
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 140,
        padding: const EdgeInsets.all(PSizes.s16),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withOpacity(0.1)
              : context.pColor.neutral.n20,
          borderRadius: BorderRadius.circular(PSizes.s16),
          border: Border.all(
            color: isSelected ? color : context.pColor.neutral.n30,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Emoji Circle
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: isSelected
                    ? color.withOpacity(0.2)
                    : context.pColor.neutral.n30,
                borderRadius: BorderRadius.circular(35),
              ),
              child: Center(
                child: Text(icon, style: const TextStyle(fontSize: 36)),
              ),
            ),

            const SizedBox(height: PSizes.s12),

            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: responsive(context, PSizes.s16),
                fontWeight: FontWeight.bold,
                color: isSelected ? color : context.pColor.neutral.n80,
              ),
              textAlign: TextAlign.center,
            ),

            // Description
          ],
        ),
      ),
    );
  }

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
                    'Hello $userName... ',
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
                  child: GestureDetector(
                    onTap: _showMoodSelectionModal,
                    child: MoodCard(
                      title: 'Your Mood',
                      emoji: selectedMoodEmoji,
                      mood: selectedMood,
                      color: selectedMoodColor,
                    ),
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
                  onTap: () => context.pushNamed(PRouter.chat.name),
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
                  onTap: () => context.pushNamed(PRouter.exercises.name),
                ),
                QuickActionCard(
                  icon: Icons.insights_outlined,
                  label: 'Insights',
                  color: context.pColor.success.base,
                  onTap: () => context.pushNamed(PRouter.insights.name),
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

  /// Helper for section headers
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
