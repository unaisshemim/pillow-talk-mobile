import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pillowtalk/common/layout/main_layout.dart';
import 'package:pillowtalk/features/auth/provider/auth_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:pillowtalk/features/auth/screen/auth_screen.dart';
import 'package:pillowtalk/features/auth/screen/otp_screen.dart';
import 'package:pillowtalk/features/chat/screen/chat_screen.dart';
import 'package:pillowtalk/features/dev/screen/dev_screen.dart';
import 'package:pillowtalk/features/home/screen/home_screen.dart';
import 'package:pillowtalk/features/notification/screen/notification_screen.dart';
import 'package:pillowtalk/features/onboarding/screen/onboarding_screen.dart';
import 'package:pillowtalk/features/partner/screen/partner_screen.dart';
import 'package:pillowtalk/features/profile/screen/profile_screen.dart';
import 'package:pillowtalk/utils/constant/router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: PRouter.onBoarding.path,
    routes: [
      GoRoute(
        name: PRouter.onBoarding.name,
        path: PRouter.onBoarding.path,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        name: PRouter.notification.name,
        path: PRouter.notification.path,
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        name: PRouter.auth.name,
        path: PRouter.auth.path,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        name: PRouter.otp.name,
        path: PRouter.otp.path,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return OtpScreen(
            phoneNumber: extra?['phoneNumber'] ?? '',
            maskedNumber: extra?['maskedNumber'] ?? '',
          );
        },
      ),
      ShellRoute(
        builder: (context, state, child) => PMainLayout(),
        routes: [
          GoRoute(
            name: PRouter.chat.name,
            path: PRouter.chat.path,
            builder: (context, state) => const ChatScreen(),
          ),
          GoRoute(
            name: PRouter.profile.name,
            path: PRouter.profile.path,
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            name: PRouter.partner.name,
            path: PRouter.partner.path,
            builder: (context, state) => const PartnerScreen(),
          ),
          GoRoute(
            name: PRouter.home.name,
            path: PRouter.home.path,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            name: PRouter.dev.name,
            path: PRouter.dev.path,
            builder: (context, state) => const DevScreen(),
          ),
        ],
      ),
    ],
    redirect: (context, state) async {
      final authState = ref.read(authNotifierProvider.notifier);
      final isAuthenticated = await authState.isAuthenticated();
      final isOnBoardingWatched = await authState.hasWatchedOnboarding();

      final bool isGoingToOnBoarding =
          state.uri.toString() == PRouter.onBoarding.path;

      if (isGoingToOnBoarding) {
        if (!isOnBoardingWatched) {
          return null; // allow onboarding
        }

        if (!isAuthenticated) {
          FlutterNativeSplash.remove();
          return PRouter.auth.path;
        }

        FlutterNativeSplash.remove();
        return PRouter.home.path;
      }

      return null;
    },
  );
});
