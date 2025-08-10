import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillowtalk/app.dart';
import 'package:pillowtalk/common/services/hive_service.dart';
import 'package:pillowtalk/common/services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notification service
  await PillowTalkNotificationService.initialize();
  final hiveService = HiveService();
  await hiveService.init();
  runApp(ProviderScope(child: MainApp()));
}
