import 'package:flutter/material.dart';
import 'package:pillowtalk/common/ui/app_bar_title.dart';
import 'package:pillowtalk/common/ui/screen_container.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen>
    with TickerProviderStateMixin {
  late AnimationController _streakController;
  late Animation<double> _streakAnimation;

  // Sample data - in real app this would come from backend
  final int currentStreak = 12;
  final int longestStreak = 28;
  final int completedToday = 3;
  final int totalTodayTasks = 5;

  // Sample assigned tasks data - in real app this would come from backend
  final List<AssignedTask> assignedTasks = [
    AssignedTask(
      id: '1',
      title: 'Morning Gratitude Check-in',
      description: 'Share 3 things you\'re grateful for with your partner',
      category: 'Gratitude',
      categoryColor: const Color(0xFFEC4899),
      categoryIcon: Icons.favorite_outline,
      duration: 10,
      priority: 'High',
      isCompleted: true,
      completedAt: DateTime.now().subtract(const Duration(hours: 2)),
      dueTime: const TimeOfDay(hour: 9, minute: 0),
    ),
    AssignedTask(
      id: '2',
      title: 'Active Listening Practice',
      description: 'Practice listening without interrupting for 10 minutes',
      category: 'Communication',
      categoryColor: const Color(0xFF6366F1),
      categoryIcon: Icons.chat_bubble_outline,
      duration: 15,
      priority: 'High',
      isCompleted: true,
      completedAt: DateTime.now().subtract(const Duration(hours: 5)),
      dueTime: const TimeOfDay(hour: 12, minute: 0),
    ),
    AssignedTask(
      id: '3',
      title: 'Breathing Exercise Together',
      description: 'Synchronize your breathing for 5 minutes',
      category: 'Mindfulness',
      categoryColor: const Color(0xFF10B981),
      categoryIcon: Icons.self_improvement,
      duration: 5,
      priority: 'Medium',
      isCompleted: true,
      completedAt: DateTime.now().subtract(const Duration(hours: 1)),
      dueTime: const TimeOfDay(hour: 15, minute: 30),
    ),
    AssignedTask(
      id: '4',
      title: 'Evening Reflection',
      description: 'Share your day\'s highlights and challenges',
      category: 'Communication',
      categoryColor: const Color(0xFF6366F1),
      categoryIcon: Icons.chat_bubble_outline,
      duration: 20,
      priority: 'High',
      isCompleted: false,
      dueTime: const TimeOfDay(hour: 19, minute: 0),
    ),
    AssignedTask(
      id: '5',
      title: 'Appreciation Expression',
      description:
          'Tell your partner one thing you appreciate about them today',
      category: 'Gratitude',
      categoryColor: const Color(0xFFEC4899),
      categoryIcon: Icons.favorite_outline,
      duration: 10,
      priority: 'Medium',
      isCompleted: false,
      dueTime: const TimeOfDay(hour: 20, minute: 30),
    ),
    AssignedTask(
      id: '6',
      title: 'Physical Connection',
      description: 'Spend 10 minutes in mindful physical connection',
      category: 'Intimacy',
      categoryColor: const Color(0xFFF59E0B),
      categoryIcon: Icons.psychology_outlined,
      duration: 10,
      priority: 'Medium',
      isCompleted: false,
      dueTime: const TimeOfDay(hour: 21, minute: 0),
    ),
    AssignedTask(
      id: '7',
      title: 'Bedtime Gratitude',
      description: 'Share what made you smile today before sleep',
      category: 'Gratitude',
      categoryColor: const Color(0xFFEC4899),
      categoryIcon: Icons.favorite_outline,
      duration: 5,
      priority: 'Low',
      isCompleted: false,
      dueTime: const TimeOfDay(hour: 22, minute: 30),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _streakController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _streakAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _streakController, curve: Curves.easeOutBack),
    );

    // Start animation after a brief delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _streakController.forward();
      }
    });
  }

  @override
  void dispose() {
    _streakController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PScreenContainer(
      backgroundColor: context.pColor.neutral.n10,
      appBar: PAppBarTitle(
        title: 'Exercises',
        leadingIcon: Icons.psychology_outlined,
        isBackButtonNeeded: true,
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          // Add refresh logic
          await Future.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // Streak Header
            SliverToBoxAdapter(child: _buildStreakHeader()),

            // Sticky Today's Progress
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyProgressDelegate(
                child: Container(
                  color: context.pColor.neutral.n10,
                  padding: const EdgeInsets.only(
                    top: PSizes.s16,
                    bottom: PSizes.s16,
                  ),
                  child: _buildTodayProgress(),
                ),
              ),
            ),

            // Assigned Tasks Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                child: Row(
                  children: [
                    Text(
                      'Today\'s Assigned Tasks',
                      style: TextStyle(
                        fontSize: responsive(context, PSizes.s20),
                        fontWeight: FontWeight.bold,
                        color: context.pColor.neutral.n80,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: PSizes.s12,
                        vertical: PSizes.s4,
                      ),
                      decoration: BoxDecoration(
                        color: context.pColor.primary.base.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(PSizes.s12),
                      ),
                      child: Text(
                        '${assignedTasks.where((task) => task.isCompleted).length}/${assignedTasks.length}',
                        style: TextStyle(
                          fontSize: responsive(context, PSizes.s12),
                          color: context.pColor.primary.base,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Assigned Tasks List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: PSizes.s16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return _buildTaskCard(assignedTasks[index]);
                }, childCount: assignedTasks.length),
              ),
            ),

            // Bottom spacing
            const SliverToBoxAdapter(child: SizedBox(height: PSizes.s24)),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakHeader() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(PSizes.s24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.pColor.primary.base, context.pColor.secondary.base],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(PSizes.s20),
        boxShadow: [
          BoxShadow(
            color: context.pColor.primary.base.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Keep it up! 🔥',
                      style: TextStyle(
                        fontSize: responsive(context, PSizes.s20),
                        fontWeight: FontWeight.bold,
                        color: context.pColor.neutral.n10,
                      ),
                    ),
                    const SizedBox(height: PSizes.s8),
                    Text(
                      'You\'re building amazing habits together',
                      style: TextStyle(
                        fontSize: responsive(context, PSizes.s14),
                        color: context.pColor.neutral.n10.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedBuilder(
                animation: _streakAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 0.8 + (_streakAnimation.value * 0.2),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: context.pColor.neutral.n10.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${(_streakAnimation.value * currentStreak).round()}',
                            style: TextStyle(
                              fontSize: responsive(context, PSizes.s24),
                              fontWeight: FontWeight.bold,
                              color: context.pColor.neutral.n10,
                            ),
                          ),
                          Text(
                            'days',
                            style: TextStyle(
                              fontSize: responsive(context, PSizes.s12),
                              color: context.pColor.neutral.n10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: PSizes.s20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStreakStat(
                context,
                'Current Streak',
                '$currentStreak days',
                Icons.local_fire_department,
              ),
              _buildStreakStat(
                context,
                'Longest Streak',
                '$longestStreak days',
                Icons.emoji_events,
              ),
              _buildStreakStat(
                context,
                'Completed',
                '${assignedTasks.where((task) => task.isCompleted).length}',
                Icons.check_circle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStreakStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, color: context.pColor.neutral.n10, size: 24),
        const SizedBox(height: PSizes.s4),
        Text(
          value,
          style: TextStyle(
            fontSize: responsive(context, PSizes.s16),
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
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTodayProgress() {
    final progressPercentage = completedToday / totalTodayTasks;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(PSizes.s20),
      decoration: BoxDecoration(
        color: context.pColor.neutral.n20,
        borderRadius: BorderRadius.circular(PSizes.s16),
        border: Border.all(color: context.pColor.neutral.n30, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today\'s Progress',
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s18),
                  fontWeight: FontWeight.bold,
                  color: context.pColor.neutral.n80,
                ),
              ),
              Text(
                '$completedToday/$totalTodayTasks',
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s16),
                  fontWeight: FontWeight.w600,
                  color: context.pColor.primary.base,
                ),
              ),
            ],
          ),
          const SizedBox(height: PSizes.s12),
          ClipRRect(
            borderRadius: BorderRadius.circular(PSizes.s8),
            child: LinearProgressIndicator(
              value: progressPercentage,
              backgroundColor: context.pColor.neutral.n30,
              valueColor: AlwaysStoppedAnimation<Color>(
                context.pColor.primary.base,
              ),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: PSizes.s8),
          Text(
            progressPercentage >= 1.0
                ? 'Amazing! You\'ve completed all today\'s exercises! 🎉'
                : 'Keep going! ${totalTodayTasks - completedToday} more to complete today',
            style: TextStyle(
              fontSize: responsive(context, PSizes.s14),
              color: context.pColor.neutral.n60,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(AssignedTask task) {
    return Card(
      margin: const EdgeInsets.only(bottom: PSizes.s12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PSizes.s16),
      ),
      child: InkWell(
        onTap: () => _showTaskDetails(task),
        borderRadius: BorderRadius.circular(PSizes.s16),
        child: Padding(
          padding: const EdgeInsets.all(PSizes.s16),
          child: Row(
            children: [
              // Checkbox
              GestureDetector(
                onTap: () => _toggleTaskCompletion(task),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: task.isCompleted
                        ? task.categoryColor
                        : Colors.transparent,
                    border: Border.all(
                      color: task.isCompleted
                          ? task.categoryColor
                          : context.pColor.neutral.n40,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(PSizes.s8),
                  ),
                  child: task.isCompleted
                      ? Icon(
                          Icons.check,
                          color: context.pColor.neutral.n10,
                          size: 16,
                        )
                      : null,
                ),
              ),

              const SizedBox(width: PSizes.s16),

              // Task Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            task.title,
                            style: TextStyle(
                              fontSize: responsive(context, PSizes.s16),
                              fontWeight: FontWeight.w600,
                              color: task.isCompleted
                                  ? context.pColor.neutral.n60
                                  : context.pColor.neutral.n80,
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ),
                        _buildPriorityBadge(task.priority),
                      ],
                    ),
                    const SizedBox(height: PSizes.s4),
                    Text(
                      task.description,
                      style: TextStyle(
                        fontSize: responsive(context, PSizes.s14),
                        color: context.pColor.neutral.n60,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: PSizes.s8),
                    Row(
                      children: [
                        // Category
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: PSizes.s8,
                            vertical: PSizes.s2,
                          ),
                          decoration: BoxDecoration(
                            color: task.categoryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(PSizes.s8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                task.categoryIcon,
                                size: 12,
                                color: task.categoryColor,
                              ),
                              const SizedBox(width: PSizes.s4),
                              Text(
                                task.category,
                                style: TextStyle(
                                  fontSize: responsive(context, PSizes.s10),
                                  color: task.categoryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: PSizes.s8),
                        // Duration
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: context.pColor.neutral.n50,
                        ),
                        const SizedBox(width: PSizes.s4),
                        Text(
                          '${task.duration} min',
                          style: TextStyle(
                            fontSize: responsive(context, PSizes.s12),
                            color: context.pColor.neutral.n50,
                          ),
                        ),
                        const Spacer(),
                        // Due Time
                        if (!task.isCompleted) ...[
                          Icon(
                            Icons.schedule,
                            size: 14,
                            color: context.pColor.neutral.n50,
                          ),
                          const SizedBox(width: PSizes.s4),
                          Text(
                            _formatTime(task.dueTime),
                            style: TextStyle(
                              fontSize: responsive(context, PSizes.s12),
                              color: context.pColor.neutral.n50,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ] else if (task.completedAt != null) ...[
                          Text(
                            'Completed ${_formatCompletedTime(task.completedAt!)}',
                            style: TextStyle(
                              fontSize: responsive(context, PSizes.s12),
                              color: task.categoryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    Color badgeColor;
    switch (priority.toLowerCase()) {
      case 'high':
        badgeColor = context.pColor.error.base;
        break;
      case 'medium':
        badgeColor = context.pColor.secondary.base;
        break;
      case 'low':
        badgeColor = context.pColor.success.base;
        break;
      default:
        badgeColor = context.pColor.neutral.n50;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: PSizes.s8,
        vertical: PSizes.s2,
      ),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(PSizes.s8),
        border: Border.all(color: badgeColor.withOpacity(0.3), width: 1),
      ),
      child: Text(
        priority,
        style: TextStyle(
          fontSize: responsive(context, PSizes.s10),
          color: badgeColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _toggleTaskCompletion(AssignedTask task) {
    setState(() {
      // In real app, you would update the backend here
      final taskIndex = assignedTasks.indexWhere((t) => t.id == task.id);
      if (taskIndex != -1) {
        assignedTasks[taskIndex] = AssignedTask(
          id: task.id,
          title: task.title,
          description: task.description,
          category: task.category,
          categoryColor: task.categoryColor,
          categoryIcon: task.categoryIcon,
          duration: task.duration,
          priority: task.priority,
          isCompleted: !task.isCompleted,
          completedAt: !task.isCompleted ? DateTime.now() : null,
          dueTime: task.dueTime,
        );
      }
    });
  }

  void _showTaskDetails(AssignedTask task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildTaskDetailsModal(task),
    );
  }

  Widget _buildTaskDetailsModal(AssignedTask task) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: context.pColor.neutral.n10,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(PSizes.s20),
        ),
      ),
      child: Column(
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
            padding: const EdgeInsets.all(PSizes.s20),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: task.categoryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(PSizes.s10),
                  ),
                  child: Icon(
                    task.categoryIcon,
                    color: task.categoryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: PSizes.s12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                          fontSize: responsive(context, PSizes.s18),
                          fontWeight: FontWeight.bold,
                          color: context.pColor.neutral.n80,
                        ),
                      ),
                      Text(
                        task.category,
                        style: TextStyle(
                          fontSize: responsive(context, PSizes.s14),
                          color: task.categoryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: context.pColor.neutral.n60),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: PSizes.s20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s16),
                      fontWeight: FontWeight.bold,
                      color: context.pColor.neutral.n80,
                    ),
                  ),
                  const SizedBox(height: PSizes.s8),
                  Text(
                    task.description,
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s14),
                      color: context.pColor.neutral.n60,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: PSizes.s24),

                  // Task Details
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailItem(
                          'Duration',
                          '${task.duration} minutes',
                          Icons.access_time,
                          context.pColor.primary.base,
                        ),
                      ),
                      Expanded(
                        child: _buildDetailItem(
                          'Priority',
                          task.priority,
                          Icons.flag,
                          _getPriorityColor(task.priority),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: PSizes.s16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailItem(
                          'Due Time',
                          _formatTime(task.dueTime),
                          Icons.schedule,
                          context.pColor.secondary.base,
                        ),
                      ),
                      Expanded(
                        child: _buildDetailItem(
                          'Status',
                          task.isCompleted ? 'Completed' : 'Pending',
                          task.isCompleted ? Icons.check_circle : Icons.pending,
                          task.isCompleted
                              ? context.pColor.success.base
                              : context.pColor.neutral.n60,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Action Button
          Container(
            padding: const EdgeInsets.all(PSizes.s20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _toggleTaskCompletion(task);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: task.isCompleted
                      ? context.pColor.neutral.n40
                      : task.categoryColor,
                  foregroundColor: context.pColor.neutral.n10,
                  padding: const EdgeInsets.symmetric(vertical: PSizes.s16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(PSizes.s12),
                  ),
                ),
                child: Text(
                  task.isCompleted ? 'Mark as Pending' : 'Mark as Completed',
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: PSizes.s8),
        Text(
          value,
          style: TextStyle(
            fontSize: responsive(context, PSizes.s14),
            fontWeight: FontWeight.bold,
            color: context.pColor.neutral.n80,
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
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return context.pColor.error.base;
      case 'medium':
        return context.pColor.secondary.base;
      case 'low':
        return context.pColor.success.base;
      default:
        return context.pColor.neutral.n50;
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _formatCompletedTime(DateTime completedAt) {
    final now = DateTime.now();
    final difference = now.difference(completedAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inMinutes}m ago';
    }
  }

  void _showHistoryModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildHistoryModal(),
    );
  }

  Widget _buildHistoryModal() {
    // Mock history data
    final historyData = [
      {
        'date': 'Today',
        'completed': 3,
        'total': 7,
        'tasks': [
          'Morning Gratitude Check-in',
          'Active Listening Practice',
          'Breathing Exercise Together',
        ],
      },
      {
        'date': 'Yesterday',
        'completed': 6,
        'total': 6,
        'tasks': [
          'Morning Gratitude Check-in',
          'Active Listening Practice',
          'Breathing Exercise Together',
          'Evening Reflection',
          'Appreciation Expression',
          'Physical Connection',
        ],
      },
      {
        'date': '2 days ago',
        'completed': 4,
        'total': 5,
        'tasks': [
          'Morning Gratitude Check-in',
          'Active Listening Practice',
          'Evening Reflection',
          'Bedtime Gratitude',
        ],
      },
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: context.pColor.neutral.n10,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(PSizes.s20),
        ),
      ),
      child: Column(
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
            padding: const EdgeInsets.all(PSizes.s20),
            child: Row(
              children: [
                Text(
                  'Task History',
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s20),
                    fontWeight: FontWeight.bold,
                    color: context.pColor.neutral.n80,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: context.pColor.neutral.n60),
                ),
              ],
            ),
          ),

          // History List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: PSizes.s20),
              itemCount: historyData.length,
              itemBuilder: (context, index) {
                final day = historyData[index];
                return _buildHistoryItem(day);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> day) {
    final completed = day['completed'] as int;
    final total = day['total'] as int;
    final tasks = day['tasks'] as List<String>;
    final progressPercentage = completed / total;

    return Container(
      margin: const EdgeInsets.only(bottom: PSizes.s16),
      padding: const EdgeInsets.all(PSizes.s16),
      decoration: BoxDecoration(
        color: context.pColor.neutral.n20,
        borderRadius: BorderRadius.circular(PSizes.s12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                day['date'] as String,
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s16),
                  fontWeight: FontWeight.bold,
                  color: context.pColor.neutral.n80,
                ),
              ),
              Text(
                '$completed/$total',
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s14),
                  fontWeight: FontWeight.w600,
                  color: context.pColor.primary.base,
                ),
              ),
            ],
          ),
          const SizedBox(height: PSizes.s8),
          ClipRRect(
            borderRadius: BorderRadius.circular(PSizes.s4),
            child: LinearProgressIndicator(
              value: progressPercentage,
              backgroundColor: context.pColor.neutral.n30,
              valueColor: AlwaysStoppedAnimation<Color>(
                context.pColor.primary.base,
              ),
              minHeight: 4,
            ),
          ),
          const SizedBox(height: PSizes.s12),
          Wrap(
            spacing: PSizes.s8,
            runSpacing: PSizes.s4,
            children: tasks.map((task) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: PSizes.s8,
                  vertical: PSizes.s4,
                ),
                decoration: BoxDecoration(
                  color: context.pColor.success.base.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(PSizes.s8),
                  border: Border.all(
                    color: context.pColor.success.base.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  task,
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s10),
                    color: context.pColor.success.base,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// Custom delegate for sticky progress header
class _StickyProgressDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyProgressDelegate({required this.child});

  @override
  double get minExtent => 150.0; // Minimum height when sticky (progress card + padding)

  @override
  double get maxExtent => 150.0; // Maximum height

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

// Data Models
class AssignedTask {
  final String id;
  final String title;
  final String description;
  final String category;
  final Color categoryColor;
  final IconData categoryIcon;
  final int duration; // in minutes
  final String priority;
  final bool isCompleted;
  final DateTime? completedAt;
  final TimeOfDay dueTime;

  AssignedTask({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.categoryColor,
    required this.categoryIcon,
    required this.duration,
    required this.priority,
    required this.isCompleted,
    this.completedAt,
    required this.dueTime,
  });
}
