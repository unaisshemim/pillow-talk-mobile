import 'dart:async';
import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

/// Notification Service for Pillow Talk - Couple Wellbeing App
class PillowTalkNotificationService {
  static ReceivedAction? initialAction;
  static ReceivePort? receivePort;

  /// Initialize notification service
  static Future<void> initialize() async {
    await _initializeLocalNotifications();
    await _initializeIsolateReceivePort();
  }

  /// Initialize local notifications with couple-themed channels
  static Future<void> _initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
      null, // App icon will be used
      [
        // Love Notes Channel - Sweet daily reminders
        NotificationChannel(
          channelKey: 'love_notes',
          channelName: 'Love Notes',
          channelDescription: 'Sweet daily reminders and love notes',
          playSound: true,
          importance: NotificationImportance.Default,
          defaultColor: const Color(0xFFFBA63A), // Your primary color
          ledColor: const Color(0xFFFBA63A),
          channelShowBadge: true,
          onlyAlertOnce: false,
          criticalAlerts: false,
        ),

        // Relationship Reminders Channel
        NotificationChannel(
          channelKey: 'relationship_reminders',
          channelName: 'Relationship Reminders',
          channelDescription: 'Activity reminders and relationship goals',
          playSound: true,
          importance: NotificationImportance.High,
          defaultColor: const Color(0xFF6EA7D3), // Your secondary color
          ledColor: const Color(0xFF6EA7D3),
          channelShowBadge: true,
          onlyAlertOnce: false,
        ),

        // Chat Messages Channel
        NotificationChannel(
          channelKey: 'chat_messages',
          channelName: 'Chat Messages',
          channelDescription: 'New messages from your partner',
          playSound: true,
          importance: NotificationImportance.High,
          defaultColor: const Color(0xFFFBA63A),
          ledColor: const Color(0xFFFBA63A),
          channelShowBadge: true,
          onlyAlertOnce: false,
          criticalAlerts: true,
        ),

        // Milestones & Achievements Channel
        NotificationChannel(
          channelKey: 'milestones',
          channelName: 'Milestones & Achievements',
          channelDescription: 'Celebrate your relationship milestones',
          playSound: true,
          importance: NotificationImportance.High,
          defaultColor: const Color(0xFF009530), // Your success color
          ledColor: const Color(0xFF009530),
          channelShowBadge: true,
          onlyAlertOnce: false,
        ),

        // Mood Check-ins Channel
        NotificationChannel(
          channelKey: 'mood_checkins',
          channelName: 'Mood Check-ins',
          channelDescription: 'Daily mood tracking reminders',
          playSound: true,
          importance: NotificationImportance.Default,
          defaultColor: const Color(0xFF6EA7D3),
          ledColor: const Color(0xFF6EA7D3),
          channelShowBadge: false,
          onlyAlertOnce: true,
        ),
      ],
      debug: true,
    );

    // Get initial notification action
    initialAction = await AwesomeNotifications().getInitialNotificationAction(
      removeFromActionEvents: false,
    );
  }

  /// Initialize isolate receive port for background notifications
  static Future<void> _initializeIsolateReceivePort() async {
    receivePort = ReceivePort('Notification action port in main isolate')
      ..listen(
        (silentData) => _onActionReceivedImplementationMethod(silentData),
      );

    IsolateNameServer.registerPortWithName(
      receivePort!.sendPort,
      'pillow_talk_notification_port',
    );
  }

  /// Start listening to notification events
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: _onActionReceivedMethod,
      onNotificationCreatedMethod: _onNotificationCreatedMethod,
      onNotificationDisplayedMethod: _onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: _onDismissActionReceivedMethod,
    );
  }

  /// Handle notification action received
  @pragma('vm:entry-point')
  static Future<void> _onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
      log('Silent notification action: ${receivedAction.buttonKeyInput}');
      await _executeSilentAction(receivedAction);
    } else {
      if (receivePort == null) {
        log('onActionReceivedMethod called in parallel isolate.');
        SendPort? sendPort = IsolateNameServer.lookupPortByName(
          'pillow_talk_notification_port',
        );
        if (sendPort != null) {
          log('Redirecting to main isolate process.');
          sendPort.send(receivedAction);
          return;
        }
      }
      return _onActionReceivedImplementationMethod(receivedAction);
    }
  }

  /// Implementation method for action received
  static Future<void> _onActionReceivedImplementationMethod(
    ReceivedAction receivedAction,
  ) async {
    // Handle different notification actions based on channel and action key
    switch (receivedAction.channelKey) {
      case 'chat_messages':
        // Navigate to chat screen
        // MyApp.navigatorKey.currentState?.pushNamed('/chat');
        break;
      case 'love_notes':
        // Navigate to home or show love note details
        // MyApp.navigatorKey.currentState?.pushNamed('/home');
        break;
      case 'relationship_reminders':
        // Navigate to specific reminder/activity
        // MyApp.navigatorKey.currentState?.pushNamed('/partner');
        break;
      case 'milestones':
        // Navigate to achievements/milestones
        // MyApp.navigatorKey.currentState?.pushNamed('/profile');
        break;
      case 'mood_checkins':
        // Navigate to mood tracking
        // MyApp.navigatorKey.currentState?.pushNamed('/home');
        break;
    }
  }

  /// Handle notification created
  @pragma('vm:entry-point')
  static Future<void> _onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    log('Notification created: ${receivedNotification.title}');
  }

  /// Handle notification displayed
  @pragma('vm:entry-point')
  static Future<void> _onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    log('Notification displayed: ${receivedNotification.title}');
  }

  /// Handle notification dismissed
  @pragma('vm:entry-point')
  static Future<void> _onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    log('Notification dismissed: ${receivedAction.title}');
  }

  /// Execute silent actions
  static Future<void> _executeSilentAction(
    ReceivedAction receivedAction,
  ) async {
    // Handle silent actions like quick replies, mood updates, etc.
    log('Executing silent action: ${receivedAction.buttonKeyPressed}');
  }

  /// Request notification permissions with custom dialog
  static Future<bool> requestNotificationPermissions(
    BuildContext context,
  ) async {
    // Check if notifications are already allowed
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (isAllowed) return true;

    // Check system permission
    PermissionStatus permission = await Permission.notification.status;

    if (permission.isDenied) {
      // Show custom permission dialog
      if (context.mounted) {
        bool userWantsToEnable = await _showPermissionDialog(context);
        if (!userWantsToEnable) return false;
      }

      // Request permission
      permission = await Permission.notification.request();
      if (permission.isGranted) {
        isAllowed = await AwesomeNotifications()
            .requestPermissionToSendNotifications();
      }
    }

    return isAllowed;
  }

  /// Show custom permission dialog
  static Future<bool> _showPermissionDialog(BuildContext context) async {
    bool userAuthorized = false;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBA63A).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Color(0xFFFBA63A),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Stay Connected',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Allow Pillow Talk to send you notifications for:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              _buildPermissionFeature(
                Icons.favorite,
                'Love notes and sweet reminders',
              ),
              _buildPermissionFeature(
                Icons.chat_bubble,
                'New messages from your partner',
              ),
              _buildPermissionFeature(
                Icons.emoji_emotions,
                'Daily mood check-in reminders',
              ),
              _buildPermissionFeature(
                Icons.celebration,
                'Relationship milestones and achievements',
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF6EA7D3).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.security, color: Color(0xFF6EA7D3), size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'We respect your privacy. You can change these settings anytime.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6EA7D3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'Not Now',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                userAuthorized = true;
                Navigator.of(dialogContext).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFBA63A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Allow Notifications',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );

    return userAuthorized;
  }

  /// Build permission feature row
  static Widget _buildPermissionFeature(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFFFBA63A)),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  /// Send love note notification
  static Future<void> sendLoveNote({
    required String title,
    required String message,
    String? partnerName,
  }) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'love_notes',
        title: '💕 $title',
        body: partnerName != null ? '$partnerName, $message' : message,
        notificationLayout: NotificationLayout.Default,
        payload: {'type': 'love_note', 'partner': partnerName ?? ''},
        // Remove problematic icon references
        // icon: 'resource://drawable/ic_notification',
        // largeIcon: 'asset://assets/logo/icon.png',
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'VIEW',
          label: 'View',
          actionType: ActionType.Default,
        ),
        NotificationActionButton(
          key: 'REPLY',
          label: 'Send Love Back',
          actionType: ActionType.Default,
        ),
      ],
    );
  }

  /// Send chat message notification
  static Future<void> sendChatMessage({
    required String senderName,
    required String message,
    String? avatarUrl,
  }) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'chat_messages',
        title: senderName,
        body: message,
        notificationLayout: NotificationLayout.Messaging,
        payload: {'type': 'chat_message', 'sender': senderName},
        // Remove problematic icon references
        // icon: 'resource://drawable/ic_notification',
        // largeIcon: avatarUrl ?? 'asset://assets/logo/icon.png',
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'REPLY',
          label: 'Reply',
          requireInputText: true,
          actionType: ActionType.SilentAction,
        ),
        NotificationActionButton(
          key: 'VIEW',
          label: 'View Chat',
          actionType: ActionType.Default,
        ),
      ],
    );
  }

  /// Send relationship reminder
  static Future<void> sendRelationshipReminder({
    required String title,
    required String message,
    String? activityType,
  }) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'relationship_reminders',
        title: '🎯 $title',
        body: message,
        notificationLayout: NotificationLayout.Default,
        payload: {'type': 'reminder', 'activity_type': activityType ?? ''},
        // Remove problematic icon reference
        // icon: 'resource://drawable/ic_notification',
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'COMPLETE',
          label: 'Mark Done',
          actionType: ActionType.SilentAction,
        ),
        NotificationActionButton(
          key: 'VIEW',
          label: 'View Details',
          actionType: ActionType.Default,
        ),
      ],
    );
  }

  /// Send milestone notification
  static Future<void> sendMilestone({
    required String title,
    required String message,
    String? imageUrl,
  }) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'milestones',
        title: '🎉 $title',
        body: message,
        notificationLayout: imageUrl != null
            ? NotificationLayout.BigPicture
            : NotificationLayout.Default,
        bigPicture: imageUrl,
        payload: {'type': 'milestone'},
        // Remove problematic icon reference
        // icon: 'resource://drawable/ic_notification',
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'CELEBRATE',
          label: 'Celebrate!',
          actionType: ActionType.Default,
        ),
        NotificationActionButton(
          key: 'SHARE',
          label: 'Share',
          actionType: ActionType.Default,
        ),
      ],
    );
  }

  /// Send mood check-in reminder
  static Future<void> sendMoodCheckIn() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) return;

    final List<String> moodMessages = [
      'How are you feeling today? Let\'s check in!',
      'Time for your daily mood check-in 😊',
      'How\'s your heart today? Share your mood!',
      'Quick mood check - how are things going?',
      'Your feelings matter. How are you today?',
    ];

    final randomMessage =
        moodMessages[DateTime.now().millisecond % moodMessages.length];

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'mood_checkins',
        title: '💭 Daily Mood Check-in',
        body: randomMessage,
        notificationLayout: NotificationLayout.Default,
        payload: {'type': 'mood_checkin'},
        // Remove problematic icon reference
        // icon: 'resource://drawable/ic_notification',
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'HAPPY',
          label: '😊 Happy',
          actionType: ActionType.SilentAction,
        ),
        NotificationActionButton(
          key: 'NEUTRAL',
          label: '😐 Okay',
          actionType: ActionType.SilentAction,
        ),
        NotificationActionButton(
          key: 'SAD',
          label: '😢 Sad',
          actionType: ActionType.SilentAction,
        ),
      ],
    );
  }

  /// Schedule daily love notes
  static Future<void> scheduleDailyLoveNotes({
    required int hour,
    required int minute,
  }) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) return;

    final List<String> loveMessages = [
      'Just a reminder that you are loved and appreciated! 💕',
      'Thinking of you and sending love your way! 🌟',
      'You make every day brighter! ☀️',
      'Grateful to have you in my life! 🙏',
      'You are amazing just as you are! ✨',
      'Sending you a virtual hug! 🤗',
      'Hope your day is as wonderful as you are! 🌈',
    ];

    for (int i = 0; i < 7; i++) {
      final message = loveMessages[i % loveMessages.length];

      await AwesomeNotifications().createNotification(
        schedule: NotificationCalendar(
          hour: hour,
          minute: minute,
          second: 0,
          repeats: true,
        ),
        content: NotificationContent(
          id: 1000 + i,
          channelKey: 'love_notes',
          title: '💕 Daily Love Note',
          body: message,
          notificationLayout: NotificationLayout.Default,
          payload: {'type': 'daily_love_note', 'day': i.toString()},
        ),
      );
    }
  }

  /// Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }

  /// Cancel notifications by channel
  static Future<void> cancelNotificationsByChannel(String channelKey) async {
    await AwesomeNotifications().cancelNotificationsByChannelKey(channelKey);
  }

  /// Reset badge counter
  static Future<void> resetBadgeCounter() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  /// Check if notifications are enabled
  static Future<bool> areNotificationsEnabled() async {
    return await AwesomeNotifications().isNotificationAllowed();
  }

  /// Get notification settings
  static Future<List<NotificationPermission>> getNotificationSettings() async {
    return await AwesomeNotifications().checkPermissionList();
  }
}
