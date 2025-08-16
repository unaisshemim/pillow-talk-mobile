import 'package:flutter/material.dart';
import 'package:pillowtalk/common/common/input/email_input.dart';
import 'package:pillowtalk/common/common/input/input.dart';
import 'package:pillowtalk/common/common/input/password_input.dart';
import 'package:pillowtalk/common/common/input/phone_input.dart';
import 'package:pillowtalk/common/common/input/text_area_input.dart';

import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

class InputTest extends StatefulWidget {
  const InputTest({super.key});

  @override
  State<InputTest> createState() => _InputTestState();
}

class _InputTestState extends State<InputTest> {
  // Controllers for different inputs
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _textAreaController = TextEditingController();
  final TextEditingController _errorController = TextEditingController();
  final TextEditingController _disabledController = TextEditingController(
    text: 'Disabled input',
  );
  final TextEditingController _readOnlyController = TextEditingController(
    text: 'Read-only input',
  );

  // Form validation states
  bool _showEmailError = false;
  bool _showPasswordError = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _searchController.dispose();
    _textAreaController.dispose();
    _errorController.dispose();
    _disabledController.dispose();
    _readOnlyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(PSizes.s16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(context, 'Input Variants'),
          _buildInputVariantsSection(),

          const SizedBox(height: PSizes.s32),
          _buildSectionTitle(context, 'Input Sizes'),
          _buildInputSizesSection(),

          const SizedBox(height: PSizes.s32),
          _buildSectionTitle(context, 'Specialized Input Types'),
          _buildSpecializedInputsSection(),

          const SizedBox(height: PSizes.s32),
          _buildSectionTitle(context, 'Input States'),
          _buildInputStatesSection(),

          const SizedBox(height: PSizes.s32),
          _buildSectionTitle(context, 'Input with Icons & Decorations'),
          _buildDecoratedInputsSection(),

          const SizedBox(height: PSizes.s32),
          _buildSectionTitle(context, 'Validation Examples'),
          _buildValidationSection(),

          const SizedBox(height: PSizes.s32),
          _buildSectionTitle(context, 'Multi-line & Text Areas'),
          _buildTextAreaSection(),

          const SizedBox(height: PSizes.s32),
          _buildSectionTitle(context, 'Interactive Examples'),
          _buildInteractiveSection(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PSizes.s16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: responsive(context, PSizes.s18),
          fontWeight: FontWeight.w600,
          color: context.pColor.neutral.n90,
        ),
      ),
    );
  }

  Widget _buildInputVariantsSection() {
    return Column(
      children: [
        PInput.outlined(
          label: 'Outlined Input',
          hintText: 'This is an outlined input',
          helperText: 'Default variant with border',
          controller: _nameController,
        ),
        const SizedBox(height: PSizes.s16),

        PInput.filled(
          label: 'Filled Input',
          hintText: 'This is a filled input',
          helperText: 'Filled background with underline',
          controller: TextEditingController(),
        ),
        const SizedBox(height: PSizes.s16),

        PInput.underlined(
          label: 'Underlined Input',
          hintText: 'This is an underlined input',
          helperText: 'Simple underline only',
          controller: TextEditingController(),
        ),
      ],
    );
  }

  Widget _buildInputSizesSection() {
    return Column(
      children: [
        PInput.outlined(
          label: 'Small Input',
          hintText: 'Small size input',
          size: InputSize.small,
          controller: TextEditingController(),
        ),
        const SizedBox(height: PSizes.s16),

        PInput.outlined(
          label: 'Medium Input',
          hintText: 'Medium size input (default)',
          size: InputSize.medium,
          controller: TextEditingController(),
        ),
        const SizedBox(height: PSizes.s16),

        PInput.outlined(
          label: 'Large Input',
          hintText: 'Large size input',
          size: InputSize.large,
          controller: TextEditingController(),
        ),
      ],
    );
  }

  Widget _buildSpecializedInputsSection() {
    return Column(
      children: [
        PEmailInput(
          label: 'Email Address',
          controller: _emailController,
          helperText: 'We\'ll never share your email',
          onChanged: (value) {
            setState(() {
              _showEmailError = value.isNotEmpty && !value.contains('@');
            });
          },
          errorText: _showEmailError
              ? 'Please enter a valid email address'
              : null,
        ),
        const SizedBox(height: PSizes.s16),

        PPasswordInput(
          label: 'Password',
          controller: _passwordController,
          helperText: 'Must be at least 8 characters',
          onChanged: (value) {
            setState(() {
              _showPasswordError = value.isNotEmpty && value.length < 8;
            });
          },
          errorText: _showPasswordError
              ? 'Password must be at least 8 characters'
              : null,
        ),
        const SizedBox(height: PSizes.s16),

        PPhoneInput(
          label: 'Phone Number',
          controller: _phoneController,
          helperText: 'Include your country code',
        ),
      ],
    );
  }

  Widget _buildInputStatesSection() {
    return Column(
      children: [
        PInput.outlined(
          label: 'Normal Input',
          hintText: 'This is a normal input',
          controller: TextEditingController(),
        ),
        const SizedBox(height: PSizes.s16),

        PInput.outlined(
          label: 'Disabled Input',
          hintText: 'This input is disabled',
          controller: _disabledController,
          enabled: false,
        ),
        const SizedBox(height: PSizes.s16),

        PInput.outlined(
          label: 'Read-only Input',
          hintText: 'This input is read-only',
          controller: _readOnlyController,
          readOnly: true,
        ),
        const SizedBox(height: PSizes.s16),

        PInput.outlined(
          label: 'Input with Error',
          hintText: 'This input has an error',
          controller: _errorController,
          errorText: 'This field is required',
        ),
      ],
    );
  }

  Widget _buildDecoratedInputsSection() {
    return Column(
      children: [
        PInput.outlined(
          label: 'Search Input',
          hintText: 'Search for something...',
          controller: _searchController,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
            },
          ),
        ),
        const SizedBox(height: PSizes.s16),

        PInput.outlined(
          label: 'Amount Input',
          hintText: '0.00',
          controller: TextEditingController(),
          prefixText: '\$ ',
          suffixText: ' USD',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: PSizes.s16),

        PInput.outlined(
          label: 'Website URL',
          hintText: 'your-website.com',
          controller: TextEditingController(),
          prefixText: 'https://',
          prefixIcon: const Icon(Icons.language),
          keyboardType: TextInputType.url,
        ),
        const SizedBox(height: PSizes.s16),

        PInput.filled(
          label: 'Username',
          hintText: 'Enter username',
          controller: TextEditingController(),
          prefixIcon: const Icon(Icons.person_outline),
          suffixIcon: const Icon(Icons.check_circle, color: Colors.green),
        ),
      ],
    );
  }

  Widget _buildValidationSection() {
    return Column(
      children: [
        PInput.outlined(
          label: 'Required Field',
          hintText: 'This field is required',
          controller: TextEditingController(),
          errorText: 'This field cannot be empty',
        ),
        const SizedBox(height: PSizes.s16),

        PInput.outlined(
          label: 'Confirmation Password',
          hintText: 'Confirm your password',
          controller: TextEditingController(),
          obscureText: true,
          prefixIcon: const Icon(Icons.lock_outline),
          errorText: 'Passwords do not match',
        ),
        const SizedBox(height: PSizes.s16),

        PInput.filled(
          label: 'Credit Card Number',
          hintText: '1234 5678 9012 3456',
          controller: TextEditingController(),
          prefixIcon: const Icon(Icons.credit_card),
          keyboardType: TextInputType.number,
          helperText: 'We encrypt all payment information',
        ),
      ],
    );
  }

  Widget _buildTextAreaSection() {
    return Column(
      children: [
        PTextAreaInput(
          label: 'Description',
          hintText: 'Enter a detailed description...',
          controller: _textAreaController,
          maxLines: 4,
          helperText: 'Provide as much detail as possible',
        ),
        const SizedBox(height: PSizes.s16),

        PTextAreaInput(
          label: 'Comments',
          hintText: 'Leave your comments here...',
          controller: TextEditingController(),
          maxLines: 3,
          maxLength: 500,
          showCounter: true,
          variant: InputVariant.filled,
        ),
        const SizedBox(height: PSizes.s16),

        PTextAreaInput(
          label: 'Notes',
          hintText: 'Add your notes...',
          controller: TextEditingController(),
          maxLines: 5,
          variant: InputVariant.underlined,
          size: InputSize.large,
        ),
      ],
    );
  }

  Widget _buildInteractiveSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: PInput.outlined(
                label: 'First Name',
                hintText: 'John',
                controller: TextEditingController(),
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
              ),
            ),
            const SizedBox(width: PSizes.s12),
            Expanded(
              child: PInput.outlined(
                label: 'Last Name',
                hintText: 'Doe',
                controller: TextEditingController(),
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.words,
              ),
            ),
          ],
        ),
        const SizedBox(height: PSizes.s16),

        PInput.filled(
          label: 'Auto-focus Input',
          hintText: 'This input has auto-focus',
          controller: TextEditingController(),
          autofocus: true,
          prefixIcon: const Icon(Icons.edit),
        ),
        const SizedBox(height: PSizes.s16),

        PInput.outlined(
          label: 'Custom Border Radius',
          hintText: 'This input has custom border radius',
          controller: TextEditingController(),
          borderRadius: PSizes.s24,
          prefixIcon: const Icon(Icons.rounded_corner),
        ),
        const SizedBox(height: PSizes.s16),

        // Demo of different keyboard types
        Row(
          children: [
            Expanded(
              child: PInput.outlined(
                label: 'Number Only',
                hintText: '123',
                controller: TextEditingController(),
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.numbers),
              ),
            ),
            const SizedBox(width: PSizes.s12),
            Expanded(
              child: PInput.outlined(
                label: 'Decimal',
                hintText: '12.34',
                controller: TextEditingController(),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                prefixIcon: const Icon(Icons.calculate),
              ),
            ),
          ],
        ),
        const SizedBox(height: PSizes.s24),

        // Showcase all variants side by side
        Text(
          'All Variants Comparison',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s16),
            fontWeight: FontWeight.w600,
            color: context.pColor.neutral.n80,
          ),
        ),
        const SizedBox(height: PSizes.s12),

        Row(
          children: [
            Expanded(
              child: PInput.outlined(
                label: 'Outlined',
                hintText: 'Outlined',
                controller: TextEditingController(),
                size: InputSize.small,
              ),
            ),
            const SizedBox(width: PSizes.s8),
            Expanded(
              child: PInput.filled(
                label: 'Filled',
                hintText: 'Filled',
                controller: TextEditingController(),
                size: InputSize.small,
              ),
            ),
            const SizedBox(width: PSizes.s8),
            Expanded(
              child: PInput.underlined(
                label: 'Underlined',
                hintText: 'Underlined',
                controller: TextEditingController(),
                size: InputSize.small,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
