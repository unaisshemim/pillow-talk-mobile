import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pillowtalk/features/auth/screen/bottom_sheet_auth_flow.dart';

class ForegroundCallToAction extends StatelessWidget {
  const ForegroundCallToAction({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle headline = GoogleFonts.inter(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );

    final double topMargin =
        MediaQuery.of(context).size.height * 0.65; // 65% of screen height
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          topMargin,
          24,
          0,
        ), // Responsive top margin
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('⭐', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 4),
                Text(
                  'Pillow Talk',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // "Delightful Events"
            Text('Dont Break It', style: headline),
            const SizedBox(height: 4),
            // Gradient "Start Here"
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  Color(0xFF6A5BFF),
                  Color(0xFFBB59FF),
                  Color(0xFFFF6EC4),
                  Color(0xFFFF906E),
                ],
              ).createShader(bounds),
              child: Text(
                'Just Fix it',
                style: headline.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: 32),
            // CTA button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                onPressed: () {
                  showAuthBottomSheet(context);
                },
                child: Text(
                  'Get Started',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
