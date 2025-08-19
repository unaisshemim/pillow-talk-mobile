import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillowtalk/common/ui/button/button.dart';
import 'package:pillowtalk/common/ui/input/input.dart';
import 'package:pillowtalk/common/ui/input/email_input.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

enum ProfileOnboardingStep { name, gender, age, email }

class ProfileOnboardingStepper extends ConsumerStatefulWidget {
  final ProfileOnboardingStep step;
  final VoidCallback onNext;
  final bool isLoading;
  final Map<String, dynamic>? currentData;
  final void Function(dynamic)? onUpdateData;

  const ProfileOnboardingStepper({
    super.key,
    required this.step,
    required this.onNext,
    this.isLoading = false,
    this.currentData,
    this.onUpdateData,
  });

  @override
  ConsumerState<ProfileOnboardingStepper> createState() =>
      _ProfileOnboardingStepperState();
}

class _ProfileOnboardingStepperState
    extends ConsumerState<ProfileOnboardingStepper>
    with SingleTickerProviderStateMixin {
  late TextEditingController _controller;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  String? _selectedGender;
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _animationController.forward();

    // Load existing data
    _loadExistingData();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _loadExistingData() {
    if (widget.currentData == null) return;

    final data = widget.currentData!;

    switch (widget.step) {
      case ProfileOnboardingStep.name:
        if (data['name'] != null) {
          _controller.text = data['name'];
        }
        break;
      case ProfileOnboardingStep.gender:
        if (data['gender'] != null) {
          _selectedGender = data['gender'];
        }
        break;
      case ProfileOnboardingStep.age:
        if (data['age'] != null) {
          _controller.text = data['age'].toString();
        }
        break;
      case ProfileOnboardingStep.email:
        if (data['email'] != null) {
          _controller.text = data['email'];
        }
        break;
    }
  }

  String _getTitle() {
    switch (widget.step) {
      case ProfileOnboardingStep.name:
        return "What should I call you when we chat?";
      case ProfileOnboardingStep.gender:
        return "Which pronouns should I use when talking about you?";
      case ProfileOnboardingStep.age:
        return "How many birthdays have you celebrated so far?";
      case ProfileOnboardingStep.email:
        return "What's your email? This helps keep your chats private and secure.";
    }
  }

  String _getSubtitle() {
    switch (widget.step) {
      case ProfileOnboardingStep.name:
        return "Hi! I'm Pillow, your relationship companion.";
      case ProfileOnboardingStep.gender:
        return "This helps me communicate with you more naturally.";
      case ProfileOnboardingStep.age:
        return "This helps me suggest activities that fit your life stage.";
      case ProfileOnboardingStep.email:
        return "Almost done! Just one more step.";
    }
  }

  String _getIllustrationEmoji() {
    switch (widget.step) {
      case ProfileOnboardingStep.name:
        return "👋";
      case ProfileOnboardingStep.gender:
        return "🤝";
      case ProfileOnboardingStep.age:
        return "🎂";
      case ProfileOnboardingStep.email:
        return "🔒";
    }
  }

  bool _isValid() {
    switch (widget.step) {
      case ProfileOnboardingStep.name:
        return _controller.text.trim().isNotEmpty;
      case ProfileOnboardingStep.gender:
        return _selectedGender != null;
      case ProfileOnboardingStep.age:
        final age = int.tryParse(_controller.text);
        return age != null && age > 0 && age <= 120;
      case ProfileOnboardingStep.email:
        final email = _controller.text.trim();
        return email.isNotEmpty && email.contains('@') && email.contains('.');
    }
  }

  void _handleNext() {
    if (!_isValid()) return;

    // Update the data using the callback if provided
    if (widget.onUpdateData != null) {
      switch (widget.step) {
        case ProfileOnboardingStep.name:
          widget.onUpdateData!(_controller.text.trim());
          break;
        case ProfileOnboardingStep.gender:
          widget.onUpdateData!(_selectedGender!);
          break;
        case ProfileOnboardingStep.age:
          widget.onUpdateData!(_controller.text);
          break;
        case ProfileOnboardingStep.email:
          widget.onUpdateData!(_controller.text.trim());
          break;
      }
    }

    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(responsive(context, PSizes.s24)),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  context.height -
                  responsive(context, PSizes.s48 * 2), // Account for padding
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  // Illustration
                  Container(
                    height: context.height * 0.12, // Reduced from 0.15
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          context.pColor.primary.p20.withOpacity(0.3),
                          context.pColor.secondary.s20.withOpacity(0.3),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(PSizes.s16),
                    ),
                    child: Center(
                      child: Text(
                        _getIllustrationEmoji(),
                        style: TextStyle(
                          fontSize: responsive(context, 48),
                        ), // Reduced from 60
                      ),
                    ),
                  ),

                  SizedBox(
                    height: responsive(context, PSizes.s24),
                  ), // Reduced from s32
                  // Subtitle
                  Text(
                    _getSubtitle(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: context.pColor.neutral.n60,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(
                    height: responsive(context, PSizes.s12),
                  ), // Reduced from s16
                  // Title
                  Text(
                    _getTitle(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: context.pColor.neutral.n90,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(
                    height: responsive(context, PSizes.s24),
                  ), // Reduced from s32
                  // Input Field
                  if (widget.step == ProfileOnboardingStep.gender)
                    _buildGenderSelector()
                  else if (widget.step == ProfileOnboardingStep.email)
                    PEmailInput(
                      controller: _controller,
                      hintText: "Enter your email address",
                      onChanged: (_) => setState(() {}),
                      size: InputSize.large,
                    )
                  else
                    PInput.outlined(
                      controller: _controller,
                      hintText: _getHintText(),
                      onChanged: (_) => setState(() {}),
                      keyboardType: widget.step == ProfileOnboardingStep.age
                          ? TextInputType.number
                          : TextInputType.text,
                      size: InputSize.large,
                    ),

                  SizedBox(
                    height: responsive(context, PSizes.s24),
                  ), // Added fixed spacing instead of Spacer
                  // Next Button
                  PButton.primary(
                    text: widget.step == ProfileOnboardingStep.email
                        ? "Complete Setup"
                        : "Continue",
                    onPressed: _isValid() && !widget.isLoading
                        ? _handleNext
                        : null,
                    isLoading: widget.isLoading,
                    size: ButtonSize.large,
                  ),

                  SizedBox(
                    height: responsive(context, PSizes.s16),
                  ), // Reduced from s24
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      children: _genderOptions.map((option) {
        final isSelected = _selectedGender == option;
        return Container(
          margin: EdgeInsets.only(bottom: responsive(context, PSizes.s12)),
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedGender = option;
              });
            },
            borderRadius: BorderRadius.circular(PSizes.s12),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(responsive(context, PSizes.s16)),
              decoration: BoxDecoration(
                color: isSelected
                    ? context.pColor.primary.p20.withOpacity(0.3)
                    : context.pColor.neutral.n20,
                borderRadius: BorderRadius.circular(PSizes.s12),
                border: Border.all(
                  color: isSelected
                      ? context.pColor.primary.base
                      : context.pColor.neutral.n40,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Text(
                option,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isSelected
                      ? context.pColor.primary.base
                      : context.pColor.neutral.n70,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  String _getHintText() {
    switch (widget.step) {
      case ProfileOnboardingStep.name:
        return "Enter your name";
      case ProfileOnboardingStep.age:
        return "Enter your age";
      case ProfileOnboardingStep.email:
        return "Enter your email address";
      case ProfileOnboardingStep.gender:
        return "";
    }
  }
}
