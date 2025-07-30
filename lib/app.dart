import 'package:flutter/material.dart';
import 'package:pillowtalk/common/services/notification_service.dart';
import 'package:pillowtalk/router.dart';
import 'package:pillowtalk/utils/theme/theme.dart';

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
