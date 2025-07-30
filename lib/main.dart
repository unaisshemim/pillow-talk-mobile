import 'package:flutter/material.dart';
import 'package:pillowtalk/app.dart';
import 'package:pillowtalk/common/services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notification service
  await PillowTalkNotificationService.initialize();

  runApp(const MainApp());
}
