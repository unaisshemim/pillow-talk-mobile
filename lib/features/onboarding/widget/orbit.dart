import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Orbits extends StatefulWidget {
  const Orbits();

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
                    child: const Text('✨', style: TextStyle(fontSize: 32)),
                  ),
                ),

                // Outer‑ring elements (angles in radians)
                _placedOnRing(
                  center,
                  outerRadius,
                  -pi / 3 + rotation,
                  child: _avatar('👨‍💼'),
                ),
                _placedOnRing(
                  center,
                  outerRadius,
                  -pi / 12 + rotation,
                  child: icon('📍'),
                ),
                _placedOnRing(
                  center,
                  outerRadius,
                  pi / 5 + rotation,
                  child: _avatar('👩‍🎨'),
                ),
                _placedOnRing(
                  center,
                  outerRadius,
                  pi / 2.7 + rotation,
                  child: _avatar('🧑‍💻'),
                ),

                // Inner‑ring elements
                _placedOnRing(
                  center,
                  innerRadius,
                  -pi / 2.2 - rotation * 1.2,
                  child: icon('🎫'),
                ),
                _placedOnRing(
                  center,
                  innerRadius,
                  -pi / 6 - rotation * 1.2,
                  child: icon('📅'),
                ),
                _placedOnRing(
                  center,
                  innerRadius,
                  pi / 8 - rotation * 1.2,
                  child: icon('🎉'),
                ),
                _placedOnRing(
                  center,
                  innerRadius,
                  pi / 2.5 - rotation * 1.2,
                  child: icon('🌍'),
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
  Widget _avatar(String emoji) => Container(
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
    child: Center(child: Text(emoji, style: const TextStyle(fontSize: 32))),
  );

  // 3‑D style icon widget
  Widget icon(String emoji) => Container(
    width: 50,
    height: 50,
    alignment: Alignment.center,
    child: Text(emoji, style: const TextStyle(fontSize: 36)),
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
