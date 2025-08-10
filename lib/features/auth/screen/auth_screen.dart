import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pillowtalk/features/auth/widget/auth_header.dart';
import 'package:pillowtalk/features/auth/widget/phonenumber_form.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late String _selectedCountryCode = '+1';

  final List<Map<String, String>> _countryCodes = [
    {'code': '+1', 'country': 'US/CA'},
    {'code': '+44', 'country': 'UK'},
    {'code': '+91', 'country': 'IN'},
    {'code': '+86', 'country': 'CN'},
    {'code': '+81', 'country': 'JP'},
    {'code': '+49', 'country': 'DE'},
    {'code': '+33', 'country': 'FR'},
    {'code': '+39', 'country': 'IT'},
    {'code': '+34', 'country': 'ES'},
    {'code': '+61', 'country': 'AU'},
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pColor.neutral.n10,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(PSizes.s24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: PSizes.s48),

                // Logo and Header
                AuthHeader(),

                const SizedBox(height: PSizes.s48),

                // Phone Number Section
                Text(
                  'Enter your phone number',
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s24),
                    fontWeight: FontWeight.bold,
                    color: context.pColor.neutral.n90,
                  ),
                ),
                const SizedBox(height: PSizes.s8),
                Text(
                  'We\'ll send you a verification code to confirm your number',
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s16),
                    color: context.pColor.neutral.n60,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: PSizes.s32),

                // Phone Input Field
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: context.pColor.neutral.n30,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(PSizes.s12),
                  ),
                  child: PhoneNumberForm(
                    controller: _phoneController,
                    selectedCode: _selectedCountryCode,
                    countryCodes: _countryCodes,
                    onCountryChanged: (value) {
                      setState(() {
                        _selectedCountryCode = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: PSizes.s32),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _sendOTP,
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
                            'Send Verification Code',
                            style: TextStyle(
                              fontSize: responsive(context, PSizes.s16),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: PSizes.s24),

                // Terms and Privacy
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: responsive(context, PSizes.s14),
                        color: context.pColor.neutral.n60,
                        height: 1.4,
                      ),
                      children: [
                        const TextSpan(
                          text: 'By continuing, you agree to our ',
                        ),
                        TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(
                            color: context.pColor.primary.base,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: context.pColor.primary.base,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: PSizes.s48),

                // Help Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(PSizes.s20),
                  decoration: BoxDecoration(
                    color: context.pColor.neutral.n20,
                    borderRadius: BorderRadius.circular(PSizes.s12),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.help_outline,
                        size: 24,
                        color: context.pColor.neutral.n60,
                      ),
                      const SizedBox(height: PSizes.s8),
                      Text(
                        'Need Help?',
                        style: TextStyle(
                          fontSize: responsive(context, PSizes.s16),
                          fontWeight: FontWeight.w600,
                          color: context.pColor.neutral.n80,
                        ),
                      ),
                      const SizedBox(height: PSizes.s4),
                      Text(
                        'Contact our support team if you\'re having trouble signing in',
                        style: TextStyle(
                          fontSize: responsive(context, PSizes.s14),
                          color: context.pColor.neutral.n60,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sendOTP() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    final fullPhoneNumber = '$_selectedCountryCode${_phoneController.text}';

    // Navigate to OTP screen
    if (mounted) {
      context.push(
        '/otp',
        extra: {
          'phoneNumber': fullPhoneNumber,
          'maskedNumber': _getMaskedNumber(),
        },
      );
    }
  }

  String _getMaskedNumber() {
    final phone = _phoneController.text;
    if (phone.length <= 4) return phone;

    final visible = phone.substring(phone.length - 4);
    final masked = '*' * (phone.length - 4);
    return '$_selectedCountryCode $masked$visible';
  }
}
