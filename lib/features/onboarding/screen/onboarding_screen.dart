import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pillow_talk/features/onboarding/model/onboarding_model.dart';
import 'package:pillow_talk/features/onboarding/widget/onboarding_widget.dart';
import 'package:pillow_talk/utils/constant/router.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingWidget(
        pages: [
          OnboardingPageModel(
            title: 'Welcome to Pillow Talk',
            description:
                'Building stronger relationships through better communication and shared experiences.',
            imageUrl: 'https://i.ibb.co/cJqsPSB/scooter.png',
            bgColor: const Color(0xFFFBA63A), // Your primary color
          ),
          OnboardingPageModel(
            title: 'Connect with Your Partner',
            description:
                'Find and connect with your partner to start your relationship journey together.',
            imageUrl: 'https://i.ibb.co/LvmZypG/storefront-illustration-2.png',
            bgColor: const Color(0xFF6EA7D3), // Your secondary color
          ),
          OnboardingPageModel(
            title: 'Track Your Relationship',
            description:
                'Monitor your mood, set goals, and celebrate milestones in your relationship journey.',
            imageUrl: 'https://i.ibb.co/420D7VP/building.png',
            bgColor: const Color(0xFF009530), // Your success color
          ),
          OnboardingPageModel(
            title: 'Communicate Better',
            description:
                'Share voice messages, get conversation insights, and strengthen your bond through meaningful dialogue.',
            imageUrl: 'https://i.ibb.co/cJqsPSB/scooter.png',
            bgColor: const Color(0xFF6EA7D3), // Your secondary color
          ),
        ],
        onSkip: () => context.go(PRouter.auth.path),
        onFinish: () => context.go(PRouter.auth.path),
      ),
    );
  }
}
