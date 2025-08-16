import 'package:flutter/material.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:pillowtalk/common/ui/phone_input_field.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

/// Example screen demonstrating different usage patterns of PhoneInputField
class PhoneInputExampleScreen extends StatefulWidget {
  const PhoneInputExampleScreen({super.key});

  @override
  State<PhoneInputExampleScreen> createState() =>
      _PhoneInputExampleScreenState();
}

class _PhoneInputExampleScreenState extends State<PhoneInputExampleScreen> {
  final _basicController = TextEditingController();
  final _customController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _basicController.dispose();
    _customController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pColor.neutral.n10,
      appBar: AppBar(
        title: Text(
          'Phone Input Examples',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s18),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: context.pColor.primary.base,
        foregroundColor: context.pColor.neutral.n10,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(PSizes.s20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Usage
              _buildSectionTitle('Basic Usage'),
              const SizedBox(height: PSizes.s12),
              PhoneInputField(
                controller: _basicController,
                hintText: 'Enter phone number',
                onCountryCodeChanged: (countryCode) {
                  debugPrint('Selected country: ${countryCode.name}');
                  debugPrint('Dial code: ${countryCode.dialCode}');
                },
              ),

              const SizedBox(height: PSizes.s32),

              // Custom Initial Country
              _buildSectionTitle('With Initial Country (US)'),
              const SizedBox(height: PSizes.s12),
              PhoneInputField(
                controller: _customController,
                initialCountryCode: const CountryCode(
                  name: 'United States',
                  code: 'US',
                  dialCode: '+1',
                ),
                hintText: 'US phone number',
                onCountryCodeChanged: (countryCode) {
                  debugPrint('Country changed to: ${countryCode.name}');
                },
              ),

              const SizedBox(height: PSizes.s32),

              // With Favorites
              _buildSectionTitle('With Favorite Countries'),
              const SizedBox(height: PSizes.s12),
              PhoneInputField(
                controller: TextEditingController(),
                favorites: ['IN', 'US', 'GB', 'CA', 'AU'],
                hintText: 'Phone with favorites',
                onCountryCodeChanged: (countryCode) {
                  debugPrint('Favorite selected: ${countryCode.name}');
                },
              ),

              const SizedBox(height: PSizes.s32),

              // Filtered Countries
              _buildSectionTitle('Filtered Countries (Only English-speaking)'),
              const SizedBox(height: PSizes.s12),
              PhoneInputField(
                controller: TextEditingController(),
                filteredCountries: ['US', 'GB', 'CA', 'AU', 'NZ', 'IE'],
                hintText: 'English-speaking countries only',
                onCountryCodeChanged: (countryCode) {
                  debugPrint('Filtered country: ${countryCode.name}');
                },
              ),

              const SizedBox(height: PSizes.s32),

              // Custom Validation
              _buildSectionTitle('Custom Validation'),
              const SizedBox(height: PSizes.s12),
              PhoneInputField(
                controller: TextEditingController(),
                hintText: 'Exactly 10 digits required',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  }
                  if (value.length != 10) {
                    return 'Phone number must be exactly 10 digits';
                  }
                  return null;
                },
                onCountryCodeChanged: (countryCode) {
                  debugPrint('Custom validation country: ${countryCode.name}');
                },
              ),

              const SizedBox(height: PSizes.s32),

              // Disabled State
              _buildSectionTitle('Disabled State'),
              const SizedBox(height: PSizes.s12),
              PhoneInputField(
                controller: TextEditingController()..text = '1234567890',
                enabled: false,
                hintText: 'Disabled input',
              ),

              const SizedBox(height: PSizes.s32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _showResults();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.pColor.primary.base,
                        foregroundColor: context.pColor.neutral.n10,
                        padding: const EdgeInsets.symmetric(
                          vertical: PSizes.s16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(PSizes.s12),
                        ),
                      ),
                      child: Text(
                        'Validate & Show Results',
                        style: TextStyle(
                          fontSize: responsive(context, PSizes.s16),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: PSizes.s12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _clearAll,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: context.pColor.primary.base),
                        foregroundColor: context.pColor.primary.base,
                        padding: const EdgeInsets.symmetric(
                          vertical: PSizes.s16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(PSizes.s12),
                        ),
                      ),
                      child: Text(
                        'Clear All',
                        style: TextStyle(
                          fontSize: responsive(context, PSizes.s16),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: responsive(context, PSizes.s18),
        fontWeight: FontWeight.bold,
        color: context.pColor.neutral.n90,
      ),
    );
  }

  void _showResults() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Phone Input Results',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s18),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Basic Input: ${_basicController.text}'),
            Text('Custom Input: ${_customController.text}'),
            const SizedBox(height: PSizes.s8),
            Text(
              'Note: In a real implementation, you would access the '
              'full phone number and country code using the widget\'s '
              'getter methods.',
              style: TextStyle(
                fontSize: responsive(context, PSizes.s12),
                color: context.pColor.neutral.n60,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _clearAll() {
    setState(() {
      _basicController.clear();
      _customController.clear();
    });
  }
}
