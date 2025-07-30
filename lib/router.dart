// GoRouter configuration
import 'package:go_router/go_router.dart';
import 'package:pillowtalk/common/layout/main_layout.dart';
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

final router = GoRouter(
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
      builder: (context, state, child) {
        // Pass down the `child` widget from the current route
        return const PMainLayout();
      },
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
          path: PRouter.dev.path,
          builder: (context, state) => const DevScreen(),
        ),
      ],
    ),
  ],
  // redirect: (context, state) async {
  //   final bool isGoingToOnBoarding =
  //       state.uri.toString() == PRouter.onBoarding.path;

  //   if (isGoingToOnBoarding) {
  //     final isOnBoardingWatched =
  //         await getIt<HiveService>().get('isOnBoardingAlreadyWatched') ??
  //             false;

  //     if (!isOnBoardingWatched) {
  //       return null; // allow onboarding
  //     }

  //     final isTokenExpired =
  //         await getIt<CognitoService>().isRefreshTokenExpired();

  //     if (isTokenExpired) {
  //       await getIt<CognitoService>().logout();
  //       FlutterNativeSplash.remove();
  //       return PRouter.auth.path;
  //     }

  //     final refreshToken = await getIt<CognitoService>().getRefreshToken();
  //     final response = await getIt<CognitoService>().refreshToken();
  //     final token = response['accessToken'];

  //     if (token == null || token.isEmpty) {
  //       await getIt<CognitoService>().logout();
  //       FlutterNativeSplash.remove();
  //       return PRouter.auth.path;
  //     }

  //     await getIt<CognitoService>().updateTokens(
  //       accessToken: token,
  //       refreshToken: refreshToken ?? '',
  //     );

  //     FlutterNativeSplash.remove();
  //     return PRouter.home.path;
  //   }

  //   return null;
  // }
);
