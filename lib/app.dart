import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillowtalk/common/services/notification_service.dart';
import 'package:pillowtalk/router.dart';
import 'package:pillowtalk/utils/theme/theme.dart';

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  // Global navigator key for navigation from notifications
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();
    // Start listening to notification events
    PillowTalkNotificationService.startListeningNotificationEvents();
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      title: 'Pillow Talk',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: goRouter,
    );
  }
}
