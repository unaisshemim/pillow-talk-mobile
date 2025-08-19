import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pillowtalk/common/ui/snackBar.dart';
import 'package:pillowtalk/features/auth/model/auth/auth_model.dart';
import 'package:pillowtalk/features/auth/provider/auth_provider.dart';
import 'package:pillowtalk/features/auth/utils/valid_otp.dart';
import 'package:pillowtalk/utils/constant/router.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';

import 'dart:async';

import 'package:pillowtalk/utils/theme/theme_extension.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  final String maskedNumber;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.maskedNumber,
  });

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  bool _isLoading = false;
  bool _isResending = false;
  int _resendCountdown = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _startResendCountdown() {
    setState(() {
      _resendCountdown = 30;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void _verifyOTP() async {
    final otp = _otpControllers.map((controller) => controller.text).join();

    if (!isValidOtp(otp)) {
      _showSnackBar(
        'Please enter a valid 4-digit verification code',
        isError: true,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Call the verifyOtp method from AuthNotifier
      final isVerified = await ref
          .read(authNotifierProvider.notifier)
          .verifyOtp(widget.phoneNumber, otp);
      final isNewUser = ref
          .read(authNotifierProvider)
          .maybeWhen(
            data: (session) => session?.isNewUser ?? false,
            orElse: () => false,
          );

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        if (isVerified) {
          _showSnackBar('Phone number verified successfully!', isError: false);

          // Navigate to home after successful verification
          await Future.delayed(const Duration(seconds: 1));
          if (mounted) {
            if (isNewUser) {
              context.go(PRouter.profileOnboarding.path);
            } else {
              context.go(PRouter.home.path);
            }
          }
        } else {
          _showSnackBar(
            'Invalid verification code. Please try again.',
            isError: true,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showSnackBar('Verification failed: ${e.toString()}', isError: true);
      }
    }
  }

  void _resendOTP() async {
    setState(() {
      _isResending = true;
    });

    try {
      // Call the sendOtp method from AuthNotifier to resend OTP
      await ref.read(authNotifierProvider.notifier).sendOtp(widget.phoneNumber);

      if (mounted) {
        setState(() {
          _isResending = false;
        });

        _showSnackBar('Verification code sent!', isError: false);
        _startResendCountdown();

        // Clear existing OTP inputs
        for (var controller in _otpControllers) {
          controller.clear();
        }
        _focusNodes[0].requestFocus();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isResending = false;
        });
        _showSnackBar('Failed to resend code: ${e.toString()}', isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to auth state changes
    ref.listen<AsyncValue<SendOtpResponse?>>(authNotifierProvider, (
      previous,
      next,
    ) {
      next.whenOrNull(
        error: (error, stackTrace) {
          if (mounted) {
            _showSnackBar('Wrong Otp ', isError: true);
          }
        },
      );
    });

    return Scaffold(
      backgroundColor: context.pColor.neutral.n10,
      appBar: AppBar(
        backgroundColor: context.pColor.neutral.n10,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.pColor.neutral.n80),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Verify Phone',
          style: TextStyle(
            color: context.pColor.neutral.n90,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(PSizes.s24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: PSizes.s32),

              // Header Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.pColor.primary.base.withOpacity(0.1),
                      context.pColor.secondary.base.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(PSizes.s20),
                ),
                child: Icon(
                  Icons.sms_outlined,
                  size: 40,
                  color: context.pColor.primary.base,
                ),
              ),

              const SizedBox(height: PSizes.s32),

              // Title and Description
              Text(
                'Enter verification code',
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s24),
                  fontWeight: FontWeight.bold,
                  color: context.pColor.neutral.n90,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: PSizes.s12),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s16),
                    color: context.pColor.neutral.n60,
                    height: 1.5,
                  ),
                  children: [
                    const TextSpan(text: 'We sent a 4-digit code to\n'),
                    TextSpan(
                      text: widget.maskedNumber,
                      style: TextStyle(
                        color: context.pColor.neutral.n90,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: PSizes.s48),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 48,
                    height: 56,
                    child: TextFormField(
                      onTapOutside: (PointerDownEvent event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1),
                      ],
                      style: TextStyle(
                        fontSize: responsive(context, PSizes.s20),
                        fontWeight: FontWeight.bold,
                        color: context.pColor.neutral.n90,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(PSizes.s12),
                          borderSide: BorderSide(
                            color: context.pColor.neutral.n30,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(PSizes.s12),
                          borderSide: BorderSide(
                            color: context.pColor.primary.base,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(PSizes.s12),
                          borderSide: BorderSide(
                            color: context.pColor.neutral.n30,
                            width: 1.5,
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          _focusNodes[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }

                        // Auto-verify when all fields are filled
                        if (index == 3 && value.isNotEmpty) {
                          _verifyOTP();
                        }
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: PSizes.s48),

              // Verify Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _verifyOTP,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.pColor.primary.base,
                    foregroundColor: context.pColor.neutral.n10,
                    padding: const EdgeInsets.symmetric(vertical: PSizes.s16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(PSizes.s12),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              context.pColor.neutral.n10,
                            ),
                          ),
                        )
                      : Text(
                          'Verify Code',
                          style: TextStyle(
                            fontSize: responsive(context, PSizes.s16),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: PSizes.s24),

              // Resend Code Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn\'t receive the code? ',
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s14),
                      color: context.pColor.neutral.n60,
                    ),
                  ),
                  if (_resendCountdown > 0)
                    Text(
                      'Resend in ${_resendCountdown}s',
                      style: TextStyle(
                        fontSize: responsive(context, PSizes.s14),
                        color: context.pColor.neutral.n50,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: _isResending ? null : _resendOTP,
                      child: _isResending
                          ? SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  context.pColor.primary.base,
                                ),
                              ),
                            )
                          : Text(
                              'Resend',
                              style: TextStyle(
                                fontSize: responsive(context, PSizes.s14),
                                color: context.pColor.primary.base,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                ],
              ),

              const SizedBox(height: PSizes.s32),

              // Change Number Option
              TextButton.icon(
                onPressed: () => context.pop(),
                icon: Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: context.pColor.neutral.n60,
                ),
                label: Text(
                  'Change phone number',
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s14),
                    color: context.pColor.neutral.n60,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: PSizes.s48),

              // Security Notice
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(PSizes.s16),
                decoration: BoxDecoration(
                  color: context.pColor.neutral.n20,
                  borderRadius: BorderRadius.circular(PSizes.s12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.security_outlined,
                      size: 20,
                      color: context.pColor.neutral.n60,
                    ),
                    const SizedBox(width: PSizes.s12),
                    Expanded(
                      child: Text(
                        'For your security, this code will expire in 10 minutes',
                        style: TextStyle(
                          fontSize: responsive(context, PSizes.s12),
                          color: context.pColor.neutral.n70,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message, {required bool isError}) {
    PSnackBar.show(
      context,
      message: message,
      type: isError ? SnackBarType.error : SnackBarType.success,
    );
  }
}
