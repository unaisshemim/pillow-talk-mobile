import 'package:flutter/material.dart';
import 'package:pillowtalk/common/ui/app_bar_title.dart';
import 'package:pillowtalk/common/ui/screen_container.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/features/chat/screen/ai_voice_chat_screen.dart';

class ChatConversationScreen extends StatefulWidget {
  final String? chatId;
  final Map<String, dynamic>? extraData;

  const ChatConversationScreen({super.key, this.chatId, this.extraData});

  @override
  State<ChatConversationScreen> createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PScreenContainer(
        backgroundColor: context.pColor.neutral.n10,
        appBar: PAppBarTitle(
          title: _getTruncatedTitle(),
          isBackButtonNeeded: true,
          trailingAction: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Mood indicator for conversation tone
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: context.pColor.success.base.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.sentiment_very_satisfied,
                      size: 16,
                      color: context.pColor.success.base,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Positive',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.pColor.success.base,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(
                  Icons.analytics_outlined,
                  color: context.pColor.neutral.n70,
                ),
                onPressed: () => _showChatAnalytics(),
              ),
              IconButton(
                icon: Icon(Icons.more_vert, color: context.pColor.neutral.n70),
                onPressed: () {
                  // More options
                },
              ),
            ],
          ),
        ),
        child: Column(
          children: [
            // Chat topic header (auto-inserted)
            if (widget.extraData?['topic'] != null)
              Container(
                margin: const EdgeInsets.all(PSizes.s16),
                padding: const EdgeInsets.all(PSizes.s12),
                decoration: BoxDecoration(
                  color: context.pColor.primary.base.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(PSizes.s8),
                  border: Border.all(
                    color: context.pColor.primary.base.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.topic,
                      color: context.pColor.primary.base,
                      size: 20,
                    ),
                    const SizedBox(width: PSizes.s8),
                    Expanded(
                      child: Text(
                        'Topic: ${widget.extraData?['topic'] ?? ''}',
                        style: TextStyle(
                          fontSize: responsive(context, PSizes.s14),
                          fontWeight: FontWeight.w500,
                          color: context.pColor.primary.base,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Messages
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(PSizes.s16),
                children: [
                  _buildDateHeader('Today'),
                  _buildAnimatedChatBubble(
                    'Hey! How was your meeting today?',
                    false,
                    DateTime.now().subtract(const Duration(minutes: 30)),
                  ),
                  _buildAnimatedChatBubble(
                    'It went really well! The client loved our proposal 🎉',
                    true,
                    DateTime.now().subtract(const Duration(minutes: 25)),
                  ),
                  _buildAnimatedChatBubble(
                    'That\'s amazing! I\'m so proud of you ❤️',
                    false,
                    DateTime.now().subtract(const Duration(minutes: 20)),
                  ),
                  _buildVoiceMessage(
                    true,
                    '0:15',
                    DateTime.now().subtract(const Duration(minutes: 15)),
                  ),
                  _buildAnimatedChatBubble(
                    'Your voice message made my day! Can\'t wait to celebrate with you tonight',
                    false,
                    DateTime.now().subtract(const Duration(minutes: 10)),
                  ),
                ],
              ),
            ),

            // Enhanced Input Area
            Container(
              padding: const EdgeInsets.all(PSizes.s16),
              decoration: BoxDecoration(
                color: context.pColor.neutral.n10,
                border: Border(
                  top: BorderSide(color: context.pColor.neutral.n30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.pColor.neutral.n30.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // AI Voice Chat button
                  GestureDetector(
                    onTap: () => _navigateToAIVoiceChat(),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            context.pColor.primary.base,
                            context.pColor.secondary.base,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: context.pColor.primary.base.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.smart_toy_outlined,
                        color: context.pColor.neutral.n10,
                        size: 20,
                      ),
                    ),
                  ),

                  const SizedBox(width: PSizes.s12),

                  // Enhanced text input
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
                            width: 2,
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
                      maxLines: 3,
                      minLines: 1,
                      textInputAction: TextInputAction.newline,
                      onChanged: (text) {
                        // Could add typing indicators here
                      },
                    ),
                  ),

                  const SizedBox(width: PSizes.s8),

                  // Animated send button
                  GestureDetector(
                    onTap: () {
                      _sendMessage();
                      // Add send animation here
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            context.pColor.primary.base,
                            context.pColor.secondary.base,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: context.pColor.primary.base.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
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
      ),
    );
  }

  Widget _buildAnimatedChatBubble(
    String message,
    bool isMe,
    DateTime timestamp,
  ) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 300),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(isMe ? (1 - value) * 50 : (1 - value) * -50, 0),
          child: Opacity(
            opacity: value,
            child: _buildChatBubble(message, isMe, timestamp),
          ),
        );
      },
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

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      // Send message logic
      _messageController.clear();
    }
  }

  String _formatMessageTime(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  String _getTruncatedTitle() {
    final title = widget.extraData?['topic'] ?? 'Chat';
    if (title.length <= 8) {
      return title;
    }
    return '${title.substring(0, 8)}...';
  }

  // Navigation method for AI Voice Chat
  void _navigateToAIVoiceChat() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AIVoiceChatScreen(
          chatId: widget.chatId,
          topic: widget.extraData?['topic'],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
