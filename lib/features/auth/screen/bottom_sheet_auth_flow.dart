// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
// =============================================================
//  Auth bottom‑sheet flow (Phone ‑> OTP) with Riverpod
// =============================================================
//  • showAuthBottomSheet() – entry‑point helper
//  • _AuthFlowSheet     – hosts the draggable sheet & PageView
//  • AuthPhoneSheet     – phone‑number page (send OTP)
//  • OtpSheet           – OTP verification page (verify / resend)
//  • _OtpBox            – single OTP input cell widget
// -------------------------------------------------------------
//  Update these imports to match your project structure.
// =============================================================

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pillowtalk/features/auth/screen/otp_sheet.dart';
import 'package:pillowtalk/features/auth/screen/phone_number.dart';

// =============================================================
//  Helper to open the sheet
// =============================================================
Future<void> showAuthBottomSheet(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true, // allow keyboard + custom height
    backgroundColor: Colors.transparent, // custom rounded sheet
    builder: (_) => const _AuthFlowSheet(),
  );
}

// =============================================================
//  _AuthFlowSheet – hosts PageView (Phone → OTP)
// =============================================================
class _AuthFlowSheet extends StatefulWidget {
  const _AuthFlowSheet();

  @override
  State<_AuthFlowSheet> createState() => _AuthFlowSheetState();
}

class _AuthFlowSheetState extends State<_AuthFlowSheet> {
  final PageController _page = PageController();

  // Hold phone / masked to pass to OTP page
  String? _phoneForOtp;
  String? _maskedForOtp;

  void _goToOtp(String phone, String masked) {
    setState(() {
      _phoneForOtp = phone;
      _maskedForOtp = masked;
    });
    _page.animateToPage(
      1,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Respect the keyboard
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: bottomInset),
      child: DraggableScrollableSheet(
        // -------- sizes --------
        initialChildSize: 0.69, // ~55% of screen height
        minChildSize: 0.45,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Color(0x33000000),
                  offset: Offset(0, -6),
                ),
              ],
            ),
            child: Column(
              children: [
                // ---------- drag handle ----------
                const SizedBox(height: 10),
                Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                const SizedBox(height: 10),

                // ---------- PageView (Phone → OTP) ----------
                Expanded(
                  child: PageView(
                    controller: _page,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      AuthPhoneSheet(
                        externalScrollController: scrollController,
                        onOtpSent: _goToOtp,
                      ),
                      OtpSheet(
                        externalScrollController: scrollController,
                        onDone: () => Navigator.of(context).maybePop(),
                        phoneNumber: _phoneForOtp ?? '',
                        maskedNumber: _maskedForOtp,
                        onChangeNumber: () => _page.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOut,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
