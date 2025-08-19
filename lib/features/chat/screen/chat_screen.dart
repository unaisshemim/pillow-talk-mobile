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

  void _showChatAnalytics(ChatSession session) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildChatAnalyticsModal(session),
    );
  }

  Widget _buildChatAnalyticsModal(ChatSession session) {
    final sentimentColor = _getSentimentColor(session.sentiment);

    // Mock analytics data - in real app, this would come from your backend
    final analytics = _generateAnalyticsData(session);

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
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: sentimentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(PSizes.s10),
                  ),
                  child: Icon(
                    Icons.analytics_outlined,
                    color: sentimentColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: PSizes.s12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Analytics',
                        style: TextStyle(
                          fontSize: responsive(context, PSizes.s20),
                          fontWeight: FontWeight.bold,
                          color: context.pColor.neutral.n80,
                        ),
                      ),
                      Text(
                        session.topic,
                        style: TextStyle(
                          fontSize: responsive(context, PSizes.s14),
                          color: context.pColor.neutral.n60,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: PSizes.s20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary Card
                  _buildAnalyticsSummaryCard(session, analytics),

                  const SizedBox(height: PSizes.s20),

                  // Emotion Analysis
                  _buildEmotionAnalysisSection(analytics),

                  const SizedBox(height: PSizes.s20),

                  // Communication Insights
                  _buildCommunicationInsights(analytics),

                  const SizedBox(height: PSizes.s20),

                  // Conversation Health
                  _buildConversationHealth(analytics),

                  const SizedBox(height: PSizes.s20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsSummaryCard(
    ChatSession session,
    Map<String, dynamic> analytics,
  ) {
    final sentimentColor = _getSentimentColor(session.sentiment);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(PSizes.s20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            sentimentColor.withOpacity(0.1),
            sentimentColor.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(PSizes.s16),
        border: Border.all(color: sentimentColor.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(PSizes.s8),
                decoration: BoxDecoration(
                  color: sentimentColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(PSizes.s8),
                ),
                child: Icon(
                  _getSentimentIcon(session.sentiment),
                  color: sentimentColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: PSizes.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Overall Sentiment',
                      style: TextStyle(
                        fontSize: responsive(context, PSizes.s14),
                        color: context.pColor.neutral.n60,
                      ),
                    ),
                    Text(
                      session.sentiment.toUpperCase(),
                      style: TextStyle(
                        fontSize: responsive(context, PSizes.s18),
                        fontWeight: FontWeight.bold,
                        color: sentimentColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${analytics['sentimentScore']}%',
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s24),
                  fontWeight: FontWeight.bold,
                  color: sentimentColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: PSizes.s16),

          Text(
            session.summary,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s14),
              color: context.pColor.neutral.n70,
              height: 1.4,
            ),
          ),

          const SizedBox(height: PSizes.s16),

          Row(
            children: [
              Expanded(
                child: _buildQuickStat(
                  'Messages',
                  '${session.messageCount}',
                  Icons.chat_bubble_outline,
                  context.pColor.primary.base,
                ),
              ),
              Expanded(
                child: _buildQuickStat(
                  'Duration',
                  analytics['duration'],
                  Icons.access_time,
                  context.pColor.secondary.base,
                ),
              ),
              Expanded(
                child: _buildQuickStat(
                  'Engagement',
                  '${analytics['engagementScore']}%',
                  Icons.trending_up,
                  context.pColor.success.base,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: PSizes.s4),
        Text(
          value,
          style: TextStyle(
            fontSize: responsive(context, PSizes.s16),
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

  Widget _buildEmotionAnalysisSection(Map<String, dynamic> analytics) {
    final emotions = analytics['emotions'] as List<Map<String, dynamic>>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Emotion Analysis',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s18),
            fontWeight: FontWeight.bold,
            color: context.pColor.neutral.n80,
          ),
        ),
        const SizedBox(height: PSizes.s12),

        ...emotions.map((emotion) => _buildEmotionItem(emotion)),
      ],
    );
  }

  Widget _buildEmotionItem(Map<String, dynamic> emotion) {
    final percentage = emotion['percentage'] as int;
    final color = emotion['color'] as Color;

    return Container(
      margin: const EdgeInsets.only(bottom: PSizes.s12),
      padding: const EdgeInsets.all(PSizes.s16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(PSizes.s12),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          Text(emotion['emoji'], style: const TextStyle(fontSize: 24)),
          const SizedBox(width: PSizes.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      emotion['name'],
                      style: TextStyle(
                        fontSize: responsive(context, PSizes.s16),
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                    Text(
                      '$percentage%',
                      style: TextStyle(
                        fontSize: responsive(context, PSizes.s14),
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: PSizes.s8),
                LinearProgressIndicator(
                  value: percentage / 100,
                  backgroundColor: color.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunicationInsights(Map<String, dynamic> analytics) {
    final insights = analytics['insights'] as List<Map<String, dynamic>>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Communication Insights',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s18),
            fontWeight: FontWeight.bold,
            color: context.pColor.neutral.n80,
          ),
        ),
        const SizedBox(height: PSizes.s12),

        ...insights.map((insight) => _buildInsightItem(insight)),
      ],
    );
  }

  Widget _buildInsightItem(Map<String, dynamic> insight) {
    return Container(
      margin: const EdgeInsets.only(bottom: PSizes.s12),
      padding: const EdgeInsets.all(PSizes.s16),
      decoration: BoxDecoration(
        color: context.pColor.neutral.n20,
        borderRadius: BorderRadius.circular(PSizes.s12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: insight['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(PSizes.s10),
            ),
            child: Icon(insight['icon'], color: insight['color'], size: 20),
          ),
          const SizedBox(width: PSizes.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  insight['title'],
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s16),
                    fontWeight: FontWeight.w600,
                    color: context.pColor.neutral.n80,
                  ),
                ),
                const SizedBox(height: PSizes.s4),
                Text(
                  insight['description'],
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
    );
  }

  Widget _buildConversationHealth(Map<String, dynamic> analytics) {
    final healthScore = analytics['healthScore'] as int;
    final healthColor = healthScore >= 80
        ? context.pColor.success.base
        : healthScore >= 60
        ? context.pColor.secondary.base
        : context.pColor.error.base;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Conversation Health',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s18),
            fontWeight: FontWeight.bold,
            color: context.pColor.neutral.n80,
          ),
        ),
        const SizedBox(height: PSizes.s12),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(PSizes.s20),
          decoration: BoxDecoration(
            color: healthColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(PSizes.s16),
            border: Border.all(color: healthColor.withOpacity(0.2), width: 1),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      value: healthScore / 100,
                      strokeWidth: 8,
                      backgroundColor: healthColor.withOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(healthColor),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '$healthScore%',
                        style: TextStyle(
                          fontSize: responsive(context, PSizes.s24),
                          fontWeight: FontWeight.bold,
                          color: healthColor,
                        ),
                      ),
                      Text(
                        'Health Score',
                        style: TextStyle(
                          fontSize: responsive(context, PSizes.s12),
                          color: context.pColor.neutral.n60,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: PSizes.s16),

              Text(
                _getHealthMessage(healthScore),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s14),
                  color: context.pColor.neutral.n70,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> _generateAnalyticsData(ChatSession session) {
    // Mock data - in real app, this would come from your backend
    return {
      'sentimentScore': _getSentimentScore(session.sentiment),
      'duration': _getRandomDuration(),
      'engagementScore': _getRandomRange(75, 95),
      'healthScore': _getRandomRange(65, 90),
      'emotions': [
        {
          'name': 'Joy',
          'emoji': '😊',
          'percentage': _getRandomRange(30, 50),
          'color': context.pColor.success.base,
        },
        {
          'name': 'Love',
          'emoji': '❤️',
          'percentage': _getRandomRange(20, 40),
          'color': context.pColor.primary.base,
        },
        {
          'name': 'Gratitude',
          'emoji': '🙏',
          'percentage': _getRandomRange(15, 25),
          'color': context.pColor.secondary.base,
        },
        {
          'name': 'Excitement',
          'emoji': '🎉',
          'percentage': _getRandomRange(10, 20),
          'color': context.pColor.error.base,
        },
      ],
      'insights': [
        {
          'title': 'Active Listening',
          'description':
              'Both partners showed great listening skills with thoughtful responses',
          'icon': Icons.hearing,
          'color': context.pColor.success.base,
        },
        {
          'title': 'Emotional Support',
          'description':
              'Strong emotional support demonstrated throughout the conversation',
          'icon': Icons.favorite,
          'color': context.pColor.primary.base,
        },
        {
          'title': 'Future Planning',
          'description':
              'Good alignment on future goals and shared aspirations',
          'icon': Icons.trending_up,
          'color': context.pColor.secondary.base,
        },
      ],
    };
  }

  int _getSentimentScore(String sentiment) {
    switch (sentiment) {
      case 'positive':
        return _getRandomRange(80, 95);
      case 'excited':
        return _getRandomRange(85, 95);
      case 'constructive':
        return _getRandomRange(70, 85);
      case 'grateful':
        return _getRandomRange(85, 95);
      default:
        return _getRandomRange(60, 80);
    }
  }

  String _getRandomDuration() {
    final durations = ['15min', '23min', '31min', '18min', '26min'];
    return durations[DateTime.now().millisecond % durations.length];
  }

  int _getRandomRange(int min, int max) {
    return min + (DateTime.now().millisecond % (max - min + 1));
  }

  String _getHealthMessage(int healthScore) {
    if (healthScore >= 80) {
      return 'Excellent! Your conversation shows strong emotional connection and healthy communication patterns.';
    } else if (healthScore >= 60) {
      return 'Good progress! There are opportunities to deepen emotional connection and improve communication flow.';
    } else {
      return 'Consider focusing on active listening and emotional support to strengthen your connection.';
    }
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
        trailing: IconButton(
          icon: Icon(
            Icons.analytics_outlined,
            color: context.pColor.primary.base,
          ),
          onPressed: () => _showChatAnalytics(session),
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
