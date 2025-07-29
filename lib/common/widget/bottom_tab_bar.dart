import 'package:flutter/widgets.dart';
import 'package:pillow_talk/common/config/env_config.dart';
import 'package:pillow_talk/common/widget/svg.dart';
import 'package:pillow_talk/utils/constant/icons.dart';
import 'package:pillow_talk/utils/helpers/device_utility.dart';
import 'package:pillow_talk/utils/helpers/responsive_size.dart';
import 'package:pillow_talk/utils/theme/theme_extension.dart';
import 'package:pillow_talk/utils/constant/sizes.dart';

class BottomTabBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final dev = EnvConfig.isDev;

  BottomTabBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    print(dev);
    final items = [
      _NavBarItem(
        label: 'Home',
        iconUrl: PIcons.home,
        isActive: currentIndex == 0,
        onTap: () => onTap(0),
      ),
      _NavBarItem(
        label: 'Chat',
        iconUrl: PIcons.chair,
        isActive: currentIndex == 1,
        onTap: () => onTap(1),
      ),
      _NavBarItem(
        label: 'Partner',
        iconUrl: PIcons.notification,
        isActive: currentIndex == 2,
        onTap: () => onTap(2),
      ),
      _NavBarItem(
        label: 'Profile',
        iconUrl: PIcons.profile,
        isActive: currentIndex == 3,
        onTap: () => onTap(3),
      ),
      if (dev)
        _NavBarItem(
          label: 'DEV',
          iconUrl: PIcons.earphone,
          isActive: currentIndex == 4,
          onTap: () => onTap(4),
        ),
    ];

    return SafeArea(
      child: Container(
        width: PDeviceUtils.getScreenWidth(context),
        padding: const EdgeInsets.only(top: PSizes.s10),
        decoration: BoxDecoration(
          color: context.pColor.neutral.n10,
          border: Border(
              top: BorderSide(color: context.pColor.secondary.s40, width: 1)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: items.map((e) => Expanded(child: e)).toList(),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String label;
  final String iconUrl;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.label,
    required this.iconUrl,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(PSizes.s2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: SVG(
                url: iconUrl,
                color: isActive
                    ? context.pColor.primary.base
                    : context.pColor.neutral.n80,
                size: PSizes.s20,
              ),
            ),
            const SizedBox(height: PSizes.s2),
            Text(label,
                style: TextStyle(
                    fontSize: responsive(context, PSizes.s10),
                    color: isActive
                        ? context.pColor.primary.base
                        : context.pColor.neutral.n80)),
          ],
        ),
      ),
    );
  }
}
