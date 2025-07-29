import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pillow_talk/common/widget/bottom_tab_bar.dart';
import 'package:pillow_talk/features/chat/screen/chat_screen.dart';
import 'package:pillow_talk/features/dev/screen/dev_screen.dart';
import 'package:pillow_talk/features/home/screen/home_screen.dart';
import 'package:pillow_talk/features/partner/screen/partner_screen.dart';
import 'package:pillow_talk/features/profile/screen/profile_screen.dart';

class PMainLayout extends StatefulWidget {
  const PMainLayout({super.key});

  @override
  State<PMainLayout> createState() => _PMainLayoutState();
}

class _PMainLayoutState extends State<PMainLayout> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = const [
      HomeScreen(),
      ChatScreen(),
      PartnerScreen(),
      ProfileScreen(),
      DevScreen()
    ];
  }

  void _onTap(int newIndex) {
    if (newIndex == _currentIndex) return;

    HapticFeedback.lightImpact();
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomTabBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
