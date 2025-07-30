import 'package:flutter/material.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  bool isVoiceRecording = false;
  String? currentChatId;
  String? currentTopic;

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
  Widget build(BuildContext context) {
    if (currentChatId != null) {
      return _buildChatView();
    }
    return _buildChatListView();
  }

  Widget _buildChatListView() {
    return Scaffold(
      backgroundColor: context.pColor.neutral.n10,
      appBar: AppBar(
        title: Text(
          'Conversations',
          style: TextStyle(
            color: context.pColor.neutral.n10,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: context.pColor.primary.base,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search_outlined,
              color: context.pColor.neutral.n10,
            ),
            onPressed: () {
              // Search conversations
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Stats
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(PSizes.s16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.pColor.primary.base,
                  context.pColor.secondary.base,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Conversation Journey 💬',
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s20),
                    fontWeight: FontWeight.bold,
                    color: context.pColor.neutral.n10,
                  ),
                ),
                const SizedBox(height: PSizes.s8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                      context,
                      '${chatSessions.length}',
                      'Conversations',
                    ),
                    _buildStatItem(context, '77', 'Total Messages'),
                    _buildStatItem(context, '92%', 'Positive Tone'),
                  ],
                ),
              ],
            ),
          ),

          // Chat Sessions List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(PSizes.s16),
              itemCount: chatSessions.length,
              itemBuilder: (context, index) {
                final session = chatSessions[index];
                return _buildChatSessionCard(session);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showNewChatDialog(),
        backgroundColor: context.pColor.primary.base,
        foregroundColor: context.pColor.neutral.n10,
        icon: const Icon(Icons.add_comment_outlined),
        label: const Text('New Chat'),
      ),
    );
  }

  Widget _buildChatView() {
    return Scaffold(
      backgroundColor: context.pColor.neutral.n10,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.pColor.neutral.n10),
          onPressed: () {
            setState(() {
              currentChatId = null;
              currentTopic = null;
            });
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sarah & John',
              style: TextStyle(
                color: context.pColor.neutral.n10,
                fontWeight: FontWeight.bold,
                fontSize: responsive(context, PSizes.s16),
              ),
            ),
            Text(
              currentTopic ?? 'Chat',
              style: TextStyle(
                color: context.pColor.neutral.n10.withOpacity(0.8),
                fontSize: responsive(context, PSizes.s12),
              ),
            ),
          ],
        ),
        backgroundColor: context.pColor.primary.base,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.analytics_outlined,
              color: context.pColor.neutral.n10,
            ),
            onPressed: () => _showChatAnalytics(),
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: context.pColor.neutral.n10),
            onPressed: () {
              // More options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(PSizes.s16),
              children: [
                _buildDateHeader('Today'),
                _buildChatBubble(
                  'Hey! How was your meeting today?',
                  false,
                  DateTime.now().subtract(const Duration(minutes: 30)),
                ),
                _buildChatBubble(
                  'It went really well! The client loved our proposal 🎉',
                  true,
                  DateTime.now().subtract(const Duration(minutes: 25)),
                ),
                _buildChatBubble(
                  'That\'s amazing! I\'m so proud of you ❤️',
                  false,
                  DateTime.now().subtract(const Duration(minutes: 20)),
                ),
                _buildVoiceMessage(
                  true,
                  '0:15',
                  DateTime.now().subtract(const Duration(minutes: 15)),
                ),
                _buildChatBubble(
                  'Your voice message made my day! Can\'t wait to celebrate with you tonight',
                  false,
                  DateTime.now().subtract(const Duration(minutes: 10)),
                ),
              ],
            ),
          ),

          // Input Area
          Container(
            padding: const EdgeInsets.all(PSizes.s16),
            decoration: BoxDecoration(
              color: context.pColor.neutral.n10,
              border: Border(
                top: BorderSide(color: context.pColor.neutral.n30),
              ),
            ),
            child: Row(
              children: [
                // Voice recording button
                GestureDetector(
                  onTapDown: (_) => _startVoiceRecording(),
                  onTapUp: (_) => _stopVoiceRecording(),
                  onTapCancel: () => _cancelVoiceRecording(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isVoiceRecording
                          ? context.pColor.error.base
                          : context.pColor.secondary.base.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      isVoiceRecording ? Icons.stop : Icons.mic,
                      color: isVoiceRecording
                          ? context.pColor.neutral.n10
                          : context.pColor.secondary.base,
                    ),
                  ),
                ),

                const SizedBox(width: PSizes.s12),

                // Text input
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(PSizes.s20),
                        borderSide: BorderSide(
                          color: context.pColor.neutral.n40,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(PSizes.s20),
                        borderSide: BorderSide(
                          color: context.pColor.primary.base,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: PSizes.s16,
                        vertical: PSizes.s12,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.emoji_emotions_outlined,
                          color: context.pColor.neutral.n60,
                        ),
                        onPressed: () {
                          // Show emoji picker
                        },
                      ),
                    ),
                    maxLines: null,
                  ),
                ),

                const SizedBox(width: PSizes.s8),

                // Send button
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: context.pColor.primary.base,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.send,
                      color: context.pColor.neutral.n10,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
        onTap: () => _showSessionSummary(session),
      ),
    );
  }

  Widget _buildDateHeader(String date) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: PSizes.s8),
        padding: const EdgeInsets.symmetric(
          horizontal: PSizes.s12,
          vertical: PSizes.s4,
        ),
        decoration: BoxDecoration(
          color: context.pColor.neutral.n30,
          borderRadius: BorderRadius.circular(PSizes.s12),
        ),
        child: Text(
          date,
          style: TextStyle(
            fontSize: responsive(context, PSizes.s12),
            color: context.pColor.neutral.n70,
          ),
        ),
      ),
    );
  }

  Widget _buildChatBubble(String message, bool isMe, DateTime timestamp) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: PSizes.s4),
        padding: const EdgeInsets.all(PSizes.s12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe
              ? context.pColor.primary.base
              : context.pColor.neutral.n20,
          borderRadius: BorderRadius.circular(PSizes.s16).copyWith(
            bottomRight: isMe ? const Radius.circular(4) : null,
            bottomLeft: !isMe ? const Radius.circular(4) : null,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                fontSize: responsive(context, PSizes.s14),
                color: isMe
                    ? context.pColor.neutral.n10
                    : context.pColor.neutral.n80,
              ),
            ),
            const SizedBox(height: PSizes.s4),
            Text(
              _formatMessageTime(timestamp),
              style: TextStyle(
                fontSize: responsive(context, PSizes.s10),
                color: isMe
                    ? context.pColor.neutral.n10.withOpacity(0.7)
                    : context.pColor.neutral.n50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoiceMessage(bool isMe, String duration, DateTime timestamp) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: PSizes.s4),
        padding: const EdgeInsets.all(PSizes.s12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.6,
        ),
        decoration: BoxDecoration(
          color: isMe
              ? context.pColor.primary.base
              : context.pColor.neutral.n20,
          borderRadius: BorderRadius.circular(PSizes.s16).copyWith(
            bottomRight: isMe ? const Radius.circular(4) : null,
            bottomLeft: !isMe ? const Radius.circular(4) : null,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.play_arrow,
              color: isMe
                  ? context.pColor.neutral.n10
                  : context.pColor.primary.base,
            ),
            const SizedBox(width: PSizes.s8),
            Expanded(
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  color: isMe
                      ? context.pColor.neutral.n10.withOpacity(0.3)
                      : context.pColor.neutral.n40,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
            const SizedBox(width: PSizes.s8),
            Text(
              duration,
              style: TextStyle(
                fontSize: responsive(context, PSizes.s12),
                color: isMe
                    ? context.pColor.neutral.n10
                    : context.pColor.neutral.n60,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNewChatDialog() {
    final TextEditingController topicController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Start New Conversation',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s18),
            fontWeight: FontWeight.bold,
            color: context.pColor.neutral.n80,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What would you like to discuss?',
              style: TextStyle(
                fontSize: responsive(context, PSizes.s14),
                color: context.pColor.neutral.n60,
              ),
            ),
            const SizedBox(height: PSizes.s16),
            TextField(
              controller: topicController,
              decoration: InputDecoration(
                hintText: 'e.g., Weekend plans, Future goals...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(PSizes.s8),
                ),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: PSizes.s16),
            Text(
              'Suggested Topics:',
              style: TextStyle(
                fontSize: responsive(context, PSizes.s12),
                fontWeight: FontWeight.w500,
                color: context.pColor.neutral.n70,
              ),
            ),
            const SizedBox(height: PSizes.s8),
            Wrap(
              spacing: 8,
              children: [
                _buildTopicChip('Daily Check-in'),
                _buildTopicChip('Future Plans'),
                _buildTopicChip('Relationship Goals'),
                _buildTopicChip('Date Ideas'),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.pColor.neutral.n60),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentChatId = 'new';
                currentTopic = topicController.text.isNotEmpty
                    ? topicController.text
                    : 'General Chat';
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.pColor.primary.base,
              foregroundColor: context.pColor.neutral.n10,
            ),
            child: const Text('Start Chat'),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicChip(String topic) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentChatId = 'new';
          currentTopic = topic;
        });
      },
      child: Chip(
        label: Text(
          topic,
          style: TextStyle(
            fontSize: responsive(context, PSizes.s12),
            color: context.pColor.primary.base,
          ),
        ),
        backgroundColor: context.pColor.primary.base.withOpacity(0.1),
        side: BorderSide(color: context.pColor.primary.base.withOpacity(0.3)),
      ),
    );
  }

  void _showSessionSummary(ChatSession session) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(PSizes.s16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(PSizes.s16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.pColor.neutral.n40,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              const SizedBox(height: PSizes.s16),

              // Title
              Text(
                session.topic,
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s20),
                  fontWeight: FontWeight.bold,
                  color: context.pColor.neutral.n80,
                ),
              ),

              const SizedBox(height: PSizes.s16),

              // Analytics Cards
              Row(
                children: [
                  Expanded(
                    child: _buildAnalyticsCard(
                      'Messages',
                      '${session.messageCount}',
                      Icons.chat_outlined,
                      context.pColor.primary.base,
                    ),
                  ),
                  const SizedBox(width: PSizes.s12),
                  Expanded(
                    child: _buildAnalyticsCard(
                      'Sentiment',
                      session.sentiment,
                      Icons.sentiment_satisfied,
                      _getSentimentColor(session.sentiment),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: PSizes.s16),

              // Summary
              Text(
                'Summary',
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s16),
                  fontWeight: FontWeight.w600,
                  color: context.pColor.neutral.n80,
                ),
              ),

              const SizedBox(height: PSizes.s8),

              Text(
                session.summary,
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s14),
                  color: context.pColor.neutral.n60,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: PSizes.s24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          currentChatId = session.id;
                          currentTopic = session.topic;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: context.pColor.primary.base),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(PSizes.s8),
                        ),
                      ),
                      child: Text(
                        'Continue Chat',
                        style: TextStyle(color: context.pColor.primary.base),
                      ),
                    ),
                  ),
                  const SizedBox(width: PSizes.s12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Show detailed analytics
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.pColor.primary.base,
                        foregroundColor: context.pColor.neutral.n10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(PSizes.s8),
                        ),
                      ),
                      child: const Text('View Analytics'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalyticsCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(PSizes.s12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(PSizes.s8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: PSizes.s24),
          const SizedBox(height: PSizes.s4),
          Text(
            value,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s16),
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s12),
              color: context.pColor.neutral.n60,
            ),
          ),
        ],
      ),
    );
  }

  void _showChatAnalytics() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Chat Analytics',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s18),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('📊 This conversation shows positive sentiment'),
            SizedBox(height: PSizes.s8),
            Text('💬 Active discussion with balanced participation'),
            SizedBox(height: PSizes.s8),
            Text('❤️ High emotional connection detected'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _startVoiceRecording() {
    setState(() {
      isVoiceRecording = true;
    });
    // Start voice recording logic
  }

  void _stopVoiceRecording() {
    setState(() {
      isVoiceRecording = false;
    });
    // Stop and send voice message
  }

  void _cancelVoiceRecording() {
    setState(() {
      isVoiceRecording = false;
    });
    // Cancel recording
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      // Send message logic
      _messageController.clear();
    }
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

  String _formatMessageTime(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
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
