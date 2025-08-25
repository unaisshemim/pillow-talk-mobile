import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pillowtalk/common/ui/svg.dart';
import 'package:pillowtalk/utils/constant/images.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';

class Orbits extends StatefulWidget {
  const Orbits({super.key});

  @override
  State<Orbits> createState() => _OrbitsState();
}

class _OrbitsState extends State<Orbits> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double offset = 0.0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 35))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              offset += 2 * pi; // shift forward one revolution
              _controller.forward(from: 0);
            }
          })
          ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Size size = constraints.biggest;
        final Offset center = Offset(size.width / 2, size.height * .39);
        const double innerRadius = 80;
        const double outerRadius = 190;

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final double rotation = _controller.value * 2 * pi;
            return Stack(
              children: [
                // Orbit rings
                Positioned.fill(
                  child: CustomPaint(
                    painter: _OrbitPainter(
                      center: center,
                      innerRadius: innerRadius,
                      outerRadius: outerRadius,
                    ),
                  ),
                ),
                Positioned(
                  left: center.dx - innerRadius,
                  top: center.dy - innerRadius,
                  child: Container(
                    width: innerRadius * 2,
                    height: innerRadius * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // subtle white-to-transparent radial fade
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withOpacity(0.85), // brighter core glow
                          Colors.white.withOpacity(0.35), // softer edge fade
                          Colors.white.withOpacity(0.0), // fully transparent
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                    ),
                  ),
                ),
                // Central sparkle/icon
                _placed(
                  center,
                  0,
                  child: Container(
                    width: 40,
                    height: 40,

                    alignment: Alignment.center,
                    child: SVG(url: PImages.pillowtalk, size: PSizes.s40),
                  ),
                ),

                // Inner‑ring elements (3 images only)
                _placedOnRing(
                  center,
                  innerRadius,
                  -pi / 3.1 - rotation * 1.2,
                  child: icon(PImages.couple),
                ),
                _placedOnRing(
                  center,
                  innerRadius,
                  0.0 - rotation * 1.2,
                  child: icon(PImages.woman),
                ),
                _placedOnRing(
                  center,
                  innerRadius,
                  pi / 3.1 - rotation * .7,
                  child: icon(PImages.head),
                ),

                // Outer‑ring elements (remaining images)
                _placedOnRing(
                  center,
                  outerRadius,
                  -pi / 2 + rotation,
                  child: _avatar(PImages.ticket),
                ),
                _placedOnRing(
                  center,
                  outerRadius,
                  -pi / 6 + rotation,
                  child: _avatar(PImages.calender),
                ),
                _placedOnRing(
                  center,
                  outerRadius,
                  pi / 8 + rotation,
                  child: _avatar(PImages.gift),
                ),
                _placedOnRing(
                  center,
                  outerRadius,
                  pi / 2.5 + rotation,
                  child: _avatar(PImages.sun),
                ),
                _placedOnRing(
                  center,
                  outerRadius,
                  pi / 1.5 + rotation,
                  child: _avatar(PImages.location),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Helper — exact‑coordinate placement
  Widget _placed(Offset origin, double radius, {required Widget child}) {
    return Positioned(
      left: origin.dx - 20, // Half of typical widget width
      top: origin.dy - 20, // Half of typical widget height
      child: child,
    );
  }

  // Helper — converts polar to Cartesian for a ring element
  Widget _placedOnRing(
    Offset center,
    double radius,
    double angle, {
    required Widget child,
  }) {
    final double dx =
        center.dx + radius * cos(angle) - 28; // Half of typical widget width
    final double dy =
        center.dy + radius * sin(angle) - 28; // Half of typical widget height
    return Positioned(left: dx, top: dy, child: child);
  }

  // Avatar circle widget
  Widget _avatar(String imagePath) => Container(
    width: 56,
    height: 56,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          blurRadius: 6,
          color: Colors.black.withOpacity(.1),
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Center(child: Image.asset(imagePath, fit: BoxFit.cover)),
  );

  // 3‑D style icon widget
  Widget icon(String imagePath) => Container(
    width: 80,
    height: 80,
    alignment: Alignment.center,
    child: Image.asset(imagePath, fit: BoxFit.cover),
  );
}

class _OrbitPainter extends CustomPainter {
  const _OrbitPainter({
    required this.center,
    required this.innerRadius,
    required this.outerRadius,
  });

  final Offset center;
  final double innerRadius;
  final double outerRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white.withOpacity(.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawCircle(center, innerRadius, paint);
    canvas.drawCircle(center, outerRadius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
