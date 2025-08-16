import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillowtalk/common/common/screen_container.dart';
import 'package:pillowtalk/common/common/app_bar_title.dart';
import 'package:pillowtalk/common/common/input/input.dart';
import 'package:pillowtalk/common/common/button/button.dart';
import 'package:pillowtalk/features/profile/model/profile_model.dart';
import 'package:pillowtalk/features/profile/provider/profile_provider.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();

  String _selectedGender = 'male';
  final List<String> _genderOptions = ['male', 'female', 'other'];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Pre-populate with existing data (placeholder values)
    Future.microtask(_loadProfileIntoControllers);
  }

  Future<void> _loadProfileIntoControllers() async {
    final profile = await ref
        .read(profileNotifierProvider.notifier)
        .getUserProfile();

    log("profile.toString(): ${profile.toString()}");

    if (!mounted || profile == null) return;

    _nameController.text = profile.name ?? '';
    _ageController.text = (profile.age ?? '').toString();
    _emailController.text = profile.email ?? '';
    setState(() {
      _selectedGender = profile.gender ?? _selectedGender;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PScreenContainer(
      backgroundColor: context.pColor.neutral.n20,
      appBar: PAppBarTitle(title: 'Edit Profile', isBackButtonNeeded: true),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(PSizes.s16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture Section

                // Form Fields
                _buildFormSection(),

                const SizedBox(height: PSizes.s32),

                // Submit Button
                _buildSubmitButton(),

                const SizedBox(height: PSizes.s32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection() {
    return Container(
      padding: const EdgeInsets.all(PSizes.s20),
      decoration: BoxDecoration(
        color: context.pColor.neutral.n10,
        borderRadius: BorderRadius.circular(PSizes.s16),
        border: Border.all(color: context.pColor.neutral.n30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Information',
            style: TextStyle(
              fontSize: responsive(context, PSizes.s18),
              fontWeight: FontWeight.bold,
              color: context.pColor.neutral.n90,
            ),
          ),
          const SizedBox(height: PSizes.s20),

          // Name Field
          PInput.outlined(
            label: 'Full Name',
            controller: _nameController,
            prefixIcon: Icon(
              Icons.person_outline,
              color: context.pColor.neutral.n60,
              size: 20,
            ),
          ),

          const SizedBox(height: PSizes.s16),

          // Age Field
          PInput.outlined(
            label: 'Age',
            controller: _ageController,
            keyboardType: TextInputType.number,
            prefixIcon: Icon(
              Icons.cake_outlined,
              color: context.pColor.neutral.n60,
              size: 20,
            ),
          ),

          const SizedBox(height: PSizes.s16),

          // Gender Dropdown
          _buildGenderDropdown(),

          const SizedBox(height: PSizes.s16),

          // Email Field
          PInput.outlined(
            label: 'Email Address',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icon(
              Icons.email_outlined,
              color: context.pColor.neutral.n60,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s14),
            fontWeight: FontWeight.w500,
            color: context.pColor.neutral.n70,
          ),
        ),
        const SizedBox(height: PSizes.s8),
        DropdownButtonFormField<String>(
          value: _selectedGender,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedGender = newValue;
              });
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select your gender';
            }
            return null;
          },
          style: TextStyle(
            fontSize: responsive(context, PSizes.s16),
            color: context.pColor.neutral.n90,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.wc_outlined,
              color: context.pColor.neutral.n60,
              size: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(PSizes.s12),
              borderSide: BorderSide(color: context.pColor.neutral.n30),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(PSizes.s12),
              borderSide: BorderSide(color: context.pColor.neutral.n30),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(PSizes.s12),
              borderSide: BorderSide(
                color: context.pColor.primary.base,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: context.pColor.neutral.n10,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: PSizes.s16,
              vertical: PSizes.s16,
            ),
          ),
          items: _genderOptions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return PButton.primary(
      text: 'Update Profile',
      onPressed: _handleSubmit,
      isLoading: _isLoading,
      size: ButtonSize.large,
    );
  }

  void _handleSubmit() async {
    // Manual validation since PInput doesn't have built-in validation
    String? nameError;
    String? ageError;
    String? emailError;

    // Validate name
    if (_nameController.text.trim().isEmpty) {
      nameError = 'Please enter your full name';
    }

    // Validate age
    if (_ageController.text.trim().isEmpty) {
      ageError = 'Please enter your age';
    } else {
      final age = int.tryParse(_ageController.text.trim());
      if (age == null || age < 18 || age > 100) {
        ageError = 'Please enter a valid age (18-100)';
      }
    }

    // Validate email
    if (_emailController.text.trim().isEmpty) {
      emailError = 'Please enter your email address';
    } else if (!RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(_emailController.text.trim())) {
      emailError = 'Please enter a valid email address';
    }

    // Show errors if any
    if (nameError != null || ageError != null || emailError != null) {
      String errorMessage = '';
      if (nameError != null) errorMessage += '$nameError\n';
      if (ageError != null) errorMessage += '$ageError\n';
      if (emailError != null) errorMessage += '$emailError\n';

      _showErrorMessage(errorMessage.trim());
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call

    // Create profile data object
    final profileData = ProfileUpdateRequest(
      name: _nameController.text.trim(),
      age: int.parse(_ageController.text.trim()),
      gender: _selectedGender,
      email: _emailController.text.trim(),
    );
    await ref
        .read(profileNotifierProvider.notifier)
        .updateUserProfile(profile: profileData);

    setState(() {
      _isLoading = false;
    });

    _showSuccessMessage('Profile updated successfully!');

    // Navigate back after short delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) Navigator.pop(context);
    });
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: context.pColor.success.base,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PSizes.s8),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: context.pColor.error.base,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PSizes.s8),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
