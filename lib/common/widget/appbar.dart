import 'package:flutter/material.dart';
import 'package:pillow_talk/utils/constant/sizes.dart';
import 'package:pillow_talk/utils/theme/theme_extension.dart';

class PAppBar extends StatelessWidget {
  const PAppBar({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: context.pColor.secondary.s10,
          border: Border(
              bottom:
                  BorderSide(color: context.pColor.secondary.s40, width: 1))),
      child: child == null
          ? null
          : Padding(
              padding: const EdgeInsets.fromLTRB(
                PSizes.s16,
                PSizes.s16,
                PSizes.s16,
                PSizes.s8,
              ),
              child: child),
    );
  }
}
