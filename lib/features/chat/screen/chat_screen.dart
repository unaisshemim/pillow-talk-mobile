import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pillowtalk/common/ui/app_bar_title.dart';
import 'package:pillowtalk/common/ui/screen_container.dart';
import 'package:pillowtalk/features/chat/screen/chat_conversation_screen.dart';
import 'package:pillowtalk/utils/constant/router.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _newChatController = TextEditingController();
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  // Sample chat sessions data
  final List<ChatSession> chatSessions = [
    ChatSession(
      id: '1',
      topic: 'Weekend Plans Discussion',
      lastMessage: 'Let\'s plan something special for Saturday!',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      messageCount: 15,
      sentiment: 'positive',
      summary:
          'You both discussed weekend plans and decided to visit the botanical garden together.',
    ),
    ChatSession(
      id: '2',
      topic: 'Communication Improvement',
      lastMessage: 'I understand your point better now',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      messageCount: 23,
      sentiment: 'constructive',
      summary:
          'A productive conversation about improving communication styles and active listening.',
    ),
    ChatSession(
      id: '3',
      topic: 'Future Goals & Dreams',
      lastMessage: 'Our 5-year plan sounds amazing!',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      messageCount: 31,
      sentiment: 'excited',
      summary:
          'You both shared future aspirations and aligned on life goals for the next 5 years.',
    ),
    ChatSession(
      id: '4',
      topic: 'Daily Check-in',
      lastMessage: 'Thank you for listening to my day',
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      messageCount: 8,
      sentiment: 'grateful',
      summary:
          'A supportive daily check-in where you both shared your day\'s highlights and challenges.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildChatListView();
  }

  Widget _buildChatListView() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PScreenContainer(
        backgroundColor: context.pColor.neutral.n10,
        appBar: PAppBarTitle(
          title: 'Conversations',
          trailingAction: IconButton(
            icon: Icon(
              Icons.search_outlined,
              color: context.pColor.neutral.n70,
            ),
            onPressed: () {
              // Search conversations
            },
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            // Add refresh logic with animation
            await Future.delayed(const Duration(seconds: 1));
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Hero Section (scrollable)
              SliverToBoxAdapter(child: _buildHeroSection()),

              // Sticky New Chat Section
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyNewChatDelegate(
                  child: Container(
                    color: context.pColor.neutral.n10,
                    padding: const EdgeInsets.only(
                      top: PSizes.s16,
                      bottom: PSizes.s16,
                    ),
                    child: _buildNewChatSection(),
                  ),
                ),
              ),

              // Recent Conversations Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  child: Row(
                    children: [
                      Text(
                        'Recent Conversations',
                        style: TextStyle(
                          fontSize: responsive(context, PSizes.s18),
                          fontWeight: FontWeight.w600,
                          color: context.pColor.neutral.n80,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // View all conversations
                        },
                        child: Text(
                          'View All',
                          style: TextStyle(
                            color: context.pColor.primary.base,
                            fontSize: responsive(context, PSizes.s14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Chat Sessions List (scrollable)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: PSizes.s16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300 + (index * 100)),
                      curve: Curves.easeOutBack,
                      child: _buildChatSessionCard(chatSessions[index]),
                    );
                  }, childCount: chatSessions.length),
                ),
              ),

              // Bottom spacing
              const SliverToBoxAdapter(child: SizedBox(height: PSizes.s24)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      margin: const EdgeInsets.all(20),
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
        borderRadius: BorderRadius.circular(PSizes.s20),
        border: Border.all(
          color: context.pColor.primary.base.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What do you want to talk about today? ❤️',
                      style: TextStyle(
                        fontSize: responsive(context, PSizes.s20),
                        fontWeight: FontWeight.bold,
                        color: context.pColor.neutral.n80,
                      ),
                    ),
                    const SizedBox(height: PSizes.s8),
                    Text(
                      'Explore meaningful conversations with your partner',
                      style: TextStyle(
                        fontSize: responsive(context, PSizes.s14),
                        color: context.pColor.neutral.n60,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: context.pColor.primary.base.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: context.pColor.primary.base,
                        size: 28,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNewChatSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: _showNewChatModal,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(PSizes.s20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.pColor.primary.base,
                context.pColor.secondary.base,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(PSizes.s16),
            boxShadow: [
              BoxShadow(
                color: context.pColor.primary.base.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: context.pColor.neutral.n10.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  Icons.add_comment_outlined,
                  color: context.pColor.neutral.n10,
                  size: 24,
                ),
              ),
              const SizedBox(width: PSizes.s16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start New Conversation',
                      style: TextStyle(
                        fontSize: responsive(context, PSizes.s18),
                        fontWeight: FontWeight.bold,
                        color: context.pColor.neutral.n10,
                      ),
                    ),
                    const SizedBox(height: PSizes.s2),
                    Flexible(
                      child: Text(
                        'Tap to explore conversation topic',
                        style: TextStyle(
                          fontSize: responsive(context, PSizes.s12),
                          color: context.pColor.neutral.n10.withOpacity(0.8),
                          height: 1.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: context.pColor.neutral.n10,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNewChatModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildNewChatModal(),
    );
  }

  Widget _buildNewChatModal() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
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
                  'Start New Conversation',
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

          // Fixed Custom Topic Input Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: PSizes.s20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input Section
                Text(
                  'Custom Topic',
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s16),
                    fontWeight: FontWeight.w600,
                    color: context.pColor.neutral.n80,
                  ),
                ),
                const SizedBox(height: PSizes.s12),

                TextField(
                  controller: _newChatController,
                  decoration: InputDecoration(
                    hintText: 'What would you like to discuss?',
                    prefixIcon: Icon(
                      Icons.edit_outlined,
                      color: context.pColor.primary.base,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(PSizes.s12),
                      borderSide: BorderSide(color: context.pColor.neutral.n40),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(PSizes.s12),
                      borderSide: BorderSide(
                        color: context.pColor.primary.base,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: PSizes.s16,
                      vertical: PSizes.s14,
                    ),
                  ),
                  maxLines: 3,
                  minLines: 1,
                ),
              ],
            ),
          ),

          const SizedBox(height: PSizes.s20),

          // Scrollable Content (Illustration + Topics)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: PSizes.s20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Illustration section
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          context.pColor.primary.base.withOpacity(0.1),
                          context.pColor.secondary.base.withOpacity(0.1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(PSizes.s16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(PSizes.s16),
                          decoration: BoxDecoration(
                            color: context.pColor.primary.base.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Icon(
                            Icons.chat_bubble_outline,
                            size: 48,
                            color: context.pColor.primary.base,
                          ),
                        ),
                        const SizedBox(height: PSizes.s12),
                        Text(
                          'What\'s on your mind? 💭',
                          style: TextStyle(
                            fontSize: responsive(context, PSizes.s16),
                            fontWeight: FontWeight.w600,
                            color: context.pColor.neutral.n80,
                          ),
                        ),
                        const SizedBox(height: PSizes.s4),
                        Text(
                          'Share thoughts, feelings, or start a meaningful conversation',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: responsive(context, PSizes.s12),
                            color: context.pColor.neutral.n60,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: PSizes.s24),

                  // Suggested Topics Header
                  Text(
                    'Suggested Topics',
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s16),
                      fontWeight: FontWeight.w600,
                      color: context.pColor.neutral.n80,
                    ),
                  ),

                  const SizedBox(height: PSizes.s12),

                  _buildModalSuggestedTopics(),
                  const SizedBox(height: PSizes.s20),
                ],
              ),
            ),
          ),

          // Bottom Action
          Container(
            padding: const EdgeInsets.all(PSizes.s20),
            decoration: BoxDecoration(
              color: context.pColor.neutral.n10,
              border: Border(
                top: BorderSide(color: context.pColor.neutral.n30, width: 1),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_newChatController.text.trim().isNotEmpty) {
                    Navigator.pop(context);
                    _startNewChat(_newChatController.text.trim());
                  }
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
                  'Start Conversation',
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

  Widget _buildModalSuggestedTopics() {
    final topics = [
      {
        'text': 'Daily Check-in',
        'icon': '☀️',
        'color': context.pColor.primary.p50,
        'description': 'Share how your day went',
      },
      {
        'text': 'Date Ideas',
        'icon': '💕',
        'color': context.pColor.primary.base,
        'description': 'Plan something special together',
      },
      {
        'text': 'Future Plans',
        'icon': '🎯',
        'color': context.pColor.secondary.base,
        'description': 'Discuss your goals and dreams',
      },
      {
        'text': 'Gratitude',
        'icon': '🙏',
        'color': context.pColor.success.base,
        'description': 'Share what you\'re thankful for',
      },
      {
        'text': 'Dreams & Goals',
        'icon': '✨',
        'color': context.pColor.secondary.s50,
        'description': 'Talk about aspirations',
      },
      {
        'text': 'Fun & Games',
        'icon': '🎲',
        'color': context.pColor.error.base,
        'description': 'Lighthearted conversation',
      },
    ];

    return Column(
      children: topics
          .map(
            (topic) => _buildTopicCard(
              topic['text'] as String,
              topic['icon'] as String,
              topic['description'] as String,
              topic['color'] as Color,
            ),
          )
          .toList(),
    );
  }

  Widget _buildTopicCard(
    String title,
    String icon,
    String description,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: PSizes.s12),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          _startNewChat(title);
        },
        borderRadius: BorderRadius.circular(PSizes.s12),
        child: Container(
          padding: const EdgeInsets.all(PSizes.s16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(PSizes.s12),
            border: Border.all(color: color.withOpacity(0.2), width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(icon, style: const TextStyle(fontSize: 24)),
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
                        color: color,
                      ),
                    ),
                    const SizedBox(height: PSizes.s4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: responsive(context, PSizes.s12),
                        color: context.pColor.neutral.n60,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: color),
            ],
          ),
        ),
      ),
    );
  }

  void _startNewChat(String topic) {
    if (topic.trim().isEmpty) return;

    // Clear the input
    _newChatController.clear();

    // Navigate to chat conversation screen
    context.pushNamed(
      PRouter.chatConversation.name,
      pathParameters: {'id': DateTime.now().millisecondsSinceEpoch.toString()},
      extra: {'topic': topic.trim()},
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: responsive(context, PSizes.s18),
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

  Widget _buildChatSessionCard(ChatSession session) {
    Color sentimentColor = _getSentimentColor(session.sentiment);

    return Card(
      margin: const EdgeInsets.only(bottom: PSizes.s12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PSizes.s12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(PSizes.s16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: sentimentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(PSizes.s12),
          ),
          child: Icon(
            _getSentimentIcon(session.sentiment),
            color: sentimentColor,
            size: PSizes.s24,
          ),
        ),
        title: Text(
          session.topic,
          style: TextStyle(
            fontSize: responsive(context, PSizes.s16),
            fontWeight: FontWeight.w600,
            color: context.pColor.neutral.n80,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: PSizes.s4),
            Text(
              session.lastMessage,
              style: TextStyle(
                fontSize: responsive(context, PSizes.s14),
                color: context.pColor.neutral.n60,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: PSizes.s8),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: context.pColor.neutral.n50,
                ),
                const SizedBox(width: PSizes.s4),
                Text(
                  _formatTimestamp(session.timestamp),
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s12),
                    color: context.pColor.neutral.n50,
                  ),
                ),
                const Spacer(),
                Text(
                  '${session.messageCount} messages',
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s12),
                    color: sentimentColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(
          Icons.analytics_outlined,
          color: context.pColor.primary.base,
        ),
        onTap: () => context.pushNamed(
          PRouter.chatConversation.name,
          pathParameters: {'id': session.id},
          extra: {'topic': session.topic},
        ),
      ),
    );
  }

  Color _getSentimentColor(String sentiment) {
    switch (sentiment) {
      case 'positive':
        return context.pColor.success.base;
      case 'excited':
        return context.pColor.primary.base;
      case 'constructive':
        return context.pColor.secondary.base;
      case 'grateful':
        return context.pColor.success.base;
      default:
        return context.pColor.neutral.n60;
    }
  }

  IconData _getSentimentIcon(String sentiment) {
    switch (sentiment) {
      case 'positive':
        return Icons.sentiment_very_satisfied;
      case 'excited':
        return Icons.celebration;
      case 'constructive':
        return Icons.psychology;
      case 'grateful':
        return Icons.favorite;
      default:
        return Icons.chat_bubble_outline;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inMinutes}m ago';
    }
  }

  @override
  void dispose() {
    _newChatController.dispose();
    _pulseController.dispose();
    super.dispose();
  }
}

// Custom delegate for sticky header
class _StickyNewChatDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyNewChatDelegate({required this.child});

  @override
  double get minExtent => 136.0; // Minimum height when sticky (120 + 16 top padding)

  @override
  double get maxExtent => 136.0; // Maximum height

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

class ChatSession {
  final String id;
  final String topic;
  final String lastMessage;
  final DateTime timestamp;
  final int messageCount;
  final String sentiment;
  final String summary;

  ChatSession({
    required this.id,
    required this.topic,
    required this.lastMessage,
    required this.timestamp,
    required this.messageCount,
    required this.sentiment,
    required this.summary,
  });
}
