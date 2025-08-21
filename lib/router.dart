import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pillowtalk/common/layout/main_layout.dart';
import 'package:pillowtalk/features/auth/provider/auth_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:pillowtalk/features/chat/screen/chat_conversation_screen.dart';
import 'package:pillowtalk/features/chat/screen/chat_screen.dart';
import 'package:pillowtalk/features/dev/screen/dev_screen.dart';
import 'package:pillowtalk/features/exercises/screen/exercises_screen.dart';
import 'package:pillowtalk/features/insights/screen/insights_screen.dart';
import 'package:pillowtalk/features/home/screen/home_screen.dart';
import 'package:pillowtalk/features/notification/screen/notification_screen.dart';
import 'package:pillowtalk/features/onboarding/screen/on_boarding_screen.dart';

import 'package:pillowtalk/features/partner/screen/partner_screen.dart';
import 'package:pillowtalk/features/profile/screen/edit_profile_screen.dart';
import 'package:pillowtalk/features/profile/screen/profile_screen.dart';
import 'package:pillowtalk/features/profile/screen/profile_onboarding_screen.dart';
import 'package:pillowtalk/features/profile/screen/settings_screen.dart';
import 'package:pillowtalk/utils/constant/router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: PRouter.onBoarding.path,
    routes: [
      GoRoute(
        name: PRouter.onBoarding.name,
        path: PRouter.onBoarding.path,
        builder: (context, state) => const PillowTalkOnBoardingScreen(),
      ),
      GoRoute(
        name: PRouter.notification.name,
        path: PRouter.notification.path,
        builder: (context, state) => const NotificationScreen(),
      ),

      GoRoute(
        name: PRouter.profileOnboarding.name,
        path: PRouter.profileOnboarding.path,
        builder: (context, state) => const ProfileOnboardingScreen(),
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
      //settings
      GoRoute(
        name: PRouter.setting.name,
        path: PRouter.setting.path,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        name: PRouter.profileEdit.name,
        path: PRouter.profileEdit.path,
        builder: (context, state) => const EditProfileScreen(),
      ),

      //chat
      GoRoute(
        name: PRouter.chatConversation.name,
        path: PRouter.chatConversation.path,
        builder: (context, state) {
          final chatId = state.pathParameters['id'];
          final extraData = state.extra as Map<String, dynamic>?;
          return ChatConversationScreen(chatId: chatId, extraData: extraData);
        },
      ),
      GoRoute(
        name: PRouter.exercises.name,
        path: PRouter.exercises.path,
        builder: (context, state) => const ExercisesScreen(),
      ),
      GoRoute(
        name: PRouter.insights.name,
        path: PRouter.insights.path,
        builder: (context, state) => const InsightsScreen(),
      ),
    ],
    redirect: (context, state) async {
      final auth = ref.read(authNotifierProvider.notifier);
      final authed = await auth.isValidTokenAuthenticated();

      final goingToOnboarding =
          state.matchedLocation == PRouter.onBoarding.path;

      // 3️⃣ Logged-in flow
      if (goingToOnboarding) {
        if (authed) {
          FlutterNativeSplash.remove();
          return PRouter.home.path;
        }
      }

      return null;
    },
  );
});
