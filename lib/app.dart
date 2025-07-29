import 'package:flutter/material.dart';
import 'package:pillow_talk/router.dart';
import 'package:pillow_talk/utils/theme/theme.dart';
import 'package:pillow_talk/common/services/notification_service.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  // Global navigator key for navigation from notifications
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    // Start listening to notification events
    PillowTalkNotificationService.startListeningNotificationEvents();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pillow Talk',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
