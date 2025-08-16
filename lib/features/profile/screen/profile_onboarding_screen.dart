import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pillowtalk/common/ui/snackBar.dart';
import 'package:pillowtalk/features/profile/model/profile_model.dart';
import 'package:pillowtalk/features/profile/provider/profile_provider.dart';
import 'package:pillowtalk/features/profile/widget/profile_onboarding_stepper.dart';
import 'package:pillowtalk/utils/constant/router.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

class ProfileOnboardingScreen extends ConsumerStatefulWidget {
  const ProfileOnboardingScreen({super.key});

  @override
  ConsumerState<ProfileOnboardingScreen> createState() =>
      _ProfileOnboardingScreenState();
}

class _ProfileOnboardingScreenState
    extends ConsumerState<ProfileOnboardingScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  int _currentStep = 0;
  final int _totalSteps = 4;
  bool _isLoading = false;

  // Local state to store onboarding data
  String? _name;
  String? _gender;
  int? _age;
  String? _email;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );
    _updateProgress();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _updateProgress() {
    _progressController.animateTo((_currentStep + 1) / _totalSteps);
  }

  // Methods to update local onboarding data
  void _updateName(String name) {
    setState(() {
      _name = name;
    });
  }

  void _updateGender(String gender) {
    setState(() {
      _gender = gender;
    });
  }

  void _updateAge(int age) {
    setState(() {
      _age = age;
    });
  }

  void _updateEmail(String email) {
    setState(() {
      _email = email;
    });
  }

  // Get current onboarding data
  Map<String, dynamic> get _onboardingData => {
    'name': _name,
    'gender': _gender,
    'age': _age,
    'email': _email,
  };

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _updateProgress();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _updateProgress();
    }
  }

  Future<void> _completeOnboarding() async {
    setState(() {
      _isLoading = true;
    });

    // Validate that all required data is available
    if (_name == null || _age == null || _gender == null || _email == null) {
      if (mounted) {
        PSnackBar.showError(
          context,
          message: 'Please complete all steps before continuing.',
        );
      }
      setState(() {
        _isLoading = false;
      });
      return;
    }
    final profileData = ProfileModel(
      name: _name!,
      age: _age!,
      gender: _gender!,
      email: _email!,
    );
    final success = await ref
        .read(profileNotifierProvider.notifier)
        .setupProfile(profile: profileData);

    if (success) {
      if (mounted) {
        PSnackBar.showSuccess(
          context,
          message: 'Profile setup complete! Welcome to Pillow Talk!',
        );
      }

      // Navigate to main app
      if (mounted) {
        context.go(PRouter.home.path);
      }
    } else {
      if (mounted) {
        PSnackBar.showError(
          context,
          message: 'Failed to set up profile. Please try again.',
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pColor.neutral.n10,
      body: SafeArea(
        child: Column(
          children: [
            // Header with progress
            Container(
              padding: EdgeInsets.all(responsive(context, PSizes.s24)),
              child: Column(
                children: [
                  // Back button and step indicator
                  Row(
                    children: [
                      if (_currentStep > 0)
                        IconButton(
                          onPressed: _previousStep,
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: context.pColor.neutral.n70,
                          ),
                        )
                      else
                        SizedBox(width: responsive(context, 48)),
                      Expanded(
                        child: Text(
                          'Step ${_currentStep + 1} of $_totalSteps',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: context.pColor.neutral.n60),
                        ),
                      ),
                      SizedBox(width: responsive(context, 48)),
                    ],
                  ),
                  SizedBox(height: responsive(context, PSizes.s16)),
                  // Progress bar
                  Container(
                    height: responsive(context, 4),
                    decoration: BoxDecoration(
                      color: context.pColor.neutral.n30,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        return FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: _progressAnimation.value,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  context.pColor.primary.base,
                                  context.pColor.secondary.base,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ProfileOnboardingStepper(
                    step: ProfileOnboardingStep.name,
                    onNext: _nextStep,
                    currentData: _onboardingData,
                    onUpdateData: (value) => _updateName(value as String),
                  ),
                  ProfileOnboardingStepper(
                    step: ProfileOnboardingStep.gender,
                    onNext: _nextStep,
                    currentData: _onboardingData,
                    onUpdateData: (value) => _updateGender(value as String),
                  ),
                  ProfileOnboardingStepper(
                    step: ProfileOnboardingStep.age,
                    onNext: _nextStep,
                    currentData: _onboardingData,
                    onUpdateData: (value) => _updateAge(int.parse(value)),
                  ),
                  ProfileOnboardingStepper(
                    step: ProfileOnboardingStep.email,
                    onNext: () => _completeOnboarding(),
                    isLoading: _isLoading,
                    currentData: _onboardingData,
                    onUpdateData: (value) => _updateEmail(value as String),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
