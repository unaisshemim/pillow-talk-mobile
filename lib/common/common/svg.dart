import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SVG extends StatelessWidget {
  final String url;
  final double? size;
  final Color? color;
  final bool isNetwork;

  const SVG(
      {super.key,
      required this.url,
      this.size,
      this.color,
      this.isNetwork = false});

  @override
  Widget build(BuildContext context) {
    if (isNetwork) {
      return SvgPicture.network(
        url,
        width: size,
        height: size,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      );
    } else {
      return SvgPicture.asset(
        url,
        width: size,
        height: size,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      );
    }
  }
}
