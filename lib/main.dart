import 'package:flutter/material.dart';
import 'package:pillow_talk/app.dart';
import 'package:pillow_talk/common/services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notification service
  await PillowTalkNotificationService.initialize();

  runApp(const MainApp());
}
