import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillowtalk/common/ui/input/phone_input_field.dart';
import 'package:pillowtalk/common/ui/snackBar.dart';
import 'package:pillowtalk/features/auth/provider/auth_provider.dart';
import 'package:pillowtalk/features/auth/utils/phone_mask.dart';
import 'package:pillowtalk/features/auth/widget/auth_header.dart';

class AuthPhoneSheet extends ConsumerStatefulWidget {
  const AuthPhoneSheet({
    super.key,
    required this.externalScrollController,
    required this.onOtpSent,
  });

  final ScrollController externalScrollController;
  final void Function(String phone, String masked) onOtpSent;

  @override
  ConsumerState<AuthPhoneSheet> createState() => _AuthPhoneSheetState();
}

class _AuthPhoneSheetState extends ConsumerState<AuthPhoneSheet> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Hard‑coded to India here – replace with picker if needed.
  final CountryCode _selectedCountryCode = const CountryCode(
    name: 'India',
    code: 'IN',
    dialCode: '+91',
  );

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendOTP() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final fullPhone =
        '${_selectedCountryCode.dialCode}${_phoneController.text}';
    try {
      await ref.read(authNotifierProvider.notifier).sendOtp(fullPhone);

      // If provider sets an error state we read it here
      final providerState = ref.read(authNotifierProvider);
      if (providerState.hasError) {
        if (mounted)
          PSnackBar.showError(context, message: 'Failed to send OTP');
        return;
      }

      // Mask e.g. +91 •••• 1234
      final masked = maskPhone(
        _selectedCountryCode.dialCode,
        _phoneController.text,
      );

      widget.onOtpSent(fullPhone, masked);
    } catch (e) {
      if (mounted) {
        PSnackBar.showError(context, message: 'Failed to send OTP');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        controller: widget.externalScrollController,
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- header / logo ----
              const AuthHeader(),
              const SizedBox(height: 24),

              Text(
                'Enter your phone number',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Text(
                'We\'ll send you a verification code',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
              ),
              const SizedBox(height: 20),

              PhoneInputField(controller: _phoneController),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _sendOTP,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          'Send Verification Code',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                ),
              ),

              const SizedBox(height: 16),
              Center(
                child: Text(
                  'By continuing, you agree to our Terms of Service and Privacy Policy',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black54,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
