import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pillowtalk/common/ui/snackBar.dart';
import 'package:pillowtalk/features/auth/provider/auth_provider.dart';
import 'package:pillowtalk/features/auth/utils/valid_otp.dart';
import 'package:pillowtalk/utils/constant/router.dart';
import 'package:flutter/services.dart';

class OtpSheet extends ConsumerStatefulWidget {
  const OtpSheet({
    super.key,
    required this.externalScrollController,
    required this.onDone,
    required this.phoneNumber,
    this.maskedNumber,
    this.onChangeNumber,
  });

  final ScrollController externalScrollController;
  final VoidCallback onDone;
  final String phoneNumber;
  final String? maskedNumber;
  final VoidCallback? onChangeNumber;

  @override
  ConsumerState<OtpSheet> createState() => _OtpSheetState();
}

class _OtpSheetState extends ConsumerState<OtpSheet> {
  static const _otpLen = 4;
  late final List<TextEditingController> _otpCtrls = List.generate(
    _otpLen,
    (_) => TextEditingController(),
  );
  late final List<FocusNode> _nodes = List.generate(
    _otpLen,
    (_) => FocusNode(),
  );

  bool _verifying = false;
  // resend
  int _resendCountdown = 30;
  Timer? _timer;
  bool _resending = false;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _otpCtrls) c.dispose();
    for (final n in _nodes) n.dispose();
    super.dispose();
  }

  // Helpers ---------------------------------------------------
  String get _code => _otpCtrls.map((c) => c.text).join();

  void _startResendCountdown() {
    _timer?.cancel();
    setState(() => _resendCountdown = 30);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          t.cancel();
        }
      });
    });
  }

  Future<void> _verify() async {
    if (!isValidOtp(_code)) {
      PSnackBar.showError(context, message: 'Enter a 4‑digit code');
      return;
    }

    setState(() => _verifying = true);
    try {
      final ok = await ref
          .read(authNotifierProvider.notifier)
          .verifyOtp(widget.phoneNumber, _code);
      final isNewUser = ref
          .read(authNotifierProvider)
          .maybeWhen(
            data: (session) => session?.isNewUser ?? false,
            orElse: () => false,
          );

      if (!mounted) return;
      setState(() => _verifying = false);

      if (ok) {
        PSnackBar.showSuccess(context, message: 'Phone verified!');
        await Future.delayed(const Duration(milliseconds: 600));
        if (mounted) {
          if (isNewUser) {
            context.go(PRouter.profileOnboarding.path);
          } else {
            context.go(PRouter.home.path);
          }
        }
      } else {
        PSnackBar.showError(context, message: 'Invalid code');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _verifying = false);
        PSnackBar.showError(context, message: 'Verification failed');
      }
    }
  }

  Future<void> _resend() async {
    if (_resendCountdown > 0 || _resending) return;
    setState(() => _resending = true);
    try {
      await ref.read(authNotifierProvider.notifier).sendOtp(widget.phoneNumber);
      for (final c in _otpCtrls) c.clear();
      _nodes.first.requestFocus();
      _startResendCountdown();
      PSnackBar.showSuccess(context, message: 'Code resent');
    } catch (e) {
      PSnackBar.showError(context, message: 'Failed to resend');
    } finally {
      if (mounted) setState(() => _resending = false);
    }
  }

  void _maybeSubmit() {
    if (_code.length == _otpLen && !_code.contains(RegExp(r'\D'))) {
      _verify();
    }
  }

  // Paste into any box → distribute forward
  void _handlePaste(int startIndex, String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '').split('');
    if (digits.isEmpty) return;

    for (int i = 0; i < digits.length && (startIndex + i) < _otpLen; i++) {
      _otpCtrls[startIndex + i].text = digits[i];
    }
    final next = (startIndex + digits.length - 1).clamp(0, _otpLen - 1);
    if (next < _otpLen - 1) {
      _nodes[next + 1].requestFocus();
    } else {
      _nodes[next].unfocus();
      _maybeSubmit();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Palette stubs – swap with context.pColor.* in your theme
    const primary = Colors.black;
    const neutral90 = Color(0xFF222222);
    const neutral70 = Color(0xFF6B7280);
    const neutral60 = Color(0xFF9CA3AF);
    const neutral30 = Color(0xFFE5E7EB);
    const neutral20 = Color(0xFFF3F4F6);

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        controller: widget.externalScrollController,
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ---------- header row ----------
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  onPressed:
                      widget.onChangeNumber ??
                      () => Navigator.of(context).maybePop(),
                ),
                const SizedBox(width: 8),
                Text(
                  'Verify Code',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: neutral90,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ---------- tile ----------
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primary.withOpacity(.08), primary.withOpacity(.02)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.sms_outlined, size: 34, color: primary),
            ),
            const SizedBox(height: 16),

            // ---------- title ----------
            Text(
              'Enter the 4‑digit code',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: neutral90,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            if (widget.maskedNumber != null)
              Text(
                'Sent to ${widget.maskedNumber}',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: neutral70),
                textAlign: TextAlign.center,
              ),

            const SizedBox(height: 24),

            // ---------- OTP boxes ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_otpLen, (index) {
                return _OtpBox(
                  controller: _otpCtrls[index],
                  focusNode: _nodes[index],
                  decoration: _otpDecoration(
                    focusedColor: primary,
                    enabledColor: neutral30,
                  ),
                  onChanged: (val) {
                    if (val.length > 1) {
                      _handlePaste(index, val);
                      return;
                    }
                    if (val.isNotEmpty && index < _otpLen - 1) {
                      _nodes[index + 1].requestFocus();
                    } else if (val.isEmpty && index > 0) {
                      _nodes[index - 1].requestFocus();
                    }
                    _maybeSubmit();
                  },
                  onBackspaceEmpty: () {
                    if (_otpCtrls[index].text.isEmpty && index > 0) {
                      _nodes[index - 1].requestFocus();
                      _otpCtrls[index - 1].clear();
                    }
                  },
                );
              }),
            ),
            const SizedBox(height: 20),

            // ---------- verify button ----------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _verifying ? null : _verify,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 0,
                ),
                child: _verifying
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(
                        'Verify',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
              ),
            ),
            const SizedBox(height: 14),

            // ---------- resend ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't receive it? ",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: neutral70),
                ),
                if (_resendCountdown > 0)
                  Text(
                    'Resend in ${_resendCountdown}s',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: neutral60,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                else
                  TextButton(
                    onPressed: _resending ? null : _resend,
                    child: _resending
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text(
                            'Resend',
                            style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
              ],
            ),
            const SizedBox(height: 10),

            // ---------- change number ----------
            TextButton.icon(
              onPressed:
                  widget.onChangeNumber ??
                  () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.edit_outlined, size: 18, color: neutral70),
              label: Text(
                'Change phone number',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: neutral70,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ---------- security notice ----------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: neutral20,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.shield_outlined, size: 18, color: neutral70),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'For your security, this code expires in 10 minutes.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: neutral70,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----- decoration helper -----
  InputDecoration _otpDecoration({
    required Color focusedColor,
    required Color enabledColor,
  }) {
    return InputDecoration(
      counterText: '',
      filled: true,
      fillColor: Colors.black.withOpacity(0.03),
      contentPadding: EdgeInsets.zero,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: enabledColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: enabledColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: focusedColor, width: 2),
      ),
    );
  }
}

// =============================================================
//  _OtpBox – single digit input
// =============================================================
class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onBackspaceEmpty,
    required this.decoration,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onBackspaceEmpty;
  final InputDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 60,
      child: KeyboardListener(
        focusNode: FocusNode(canRequestFocus: false),
        onKeyEvent: (e) {
          if (e is! KeyUpEvent &&
              e.logicalKey == LogicalKeyboardKey.backspace &&
              controller.text.isEmpty) {
            onBackspaceEmpty();
          }
        },
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          autofillHints: const [AutofillHints.oneTimeCode],
          textInputAction: TextInputAction.next,
          showCursor: true,
          cursorWidth: 2,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
          decoration: decoration,
          onChanged: onChanged,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        ),
      ),
    );
  }
}
