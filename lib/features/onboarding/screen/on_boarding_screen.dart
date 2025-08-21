import 'package:flutter/material.dart';
import 'package:pillowtalk/features/onboarding/widget/action.dart';
import 'package:pillowtalk/features/onboarding/widget/background.dart';
import 'package:pillowtalk/features/onboarding/widget/orbit.dart';

class PillowTalkOnBoardingScreen extends StatelessWidget {
  const PillowTalkOnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ------- Gradient background -------
          const Background(),

          // ------- Orbits + floating icons -------
          const Orbits(),

          // ------- Heading & CTA button -------
          const ForegroundCallToAction(),
        ],
      ),
    );
  }
}
