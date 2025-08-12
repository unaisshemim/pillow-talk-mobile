import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pillowtalk/common/widget/app_bar_title.dart';
import 'package:pillowtalk/common/widget/screen_container.dart';
import 'package:pillowtalk/features/auth/provider/auth_provider.dart';
import 'package:pillowtalk/utils/constant/router.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool notificationsEnabled = true;
  bool voiceMessagesEnabled = true;
  bool analyticsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return PScreenContainer(
      backgroundColor: context.pColor.neutral.n20,
      appBar: PAppBarTitle(
        title: 'Profile',
        trailingAction: IconButton(
          icon: Icon(Icons.edit_outlined, color: context.pColor.neutral.n70),
          onPressed: () => _showEditProfileDialog(),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(PSizes.s24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    context.pColor.primary.base,
                    context.pColor.secondary.base,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/300?img=3',
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => _showImagePickerDialog(),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: context.pColor.neutral.n10,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: context.pColor.primary.base,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              size: 20,
                              color: context.pColor.primary.base,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: PSizes.s16),
                  Text(
                    'Sarah Johnson',
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s24),
                      fontWeight: FontWeight.bold,
                      color: context.pColor.neutral.n10,
                    ),
                  ),
                  const SizedBox(height: PSizes.s4),
                  Text(
                    'sarah.johnson@email.com',
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s16),
                      color: context.pColor.neutral.n10.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: PSizes.s16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildProfileStat('2 Years', 'Together'),
                      _buildProfileStat('156', 'Conversations'),
                      _buildProfileStat('23', 'Goals Met'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: PSizes.s24),

            // Profile Options
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PSizes.s16,
                    vertical: PSizes.s16,
                  ),
                  child: Text(
                    'Personal Information',
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s14),
                      fontWeight: FontWeight.w600,
                      color: context.pColor.neutral.n60,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                Container(
                  color: context.pColor.neutral.n10,
                  child: Column(
                    children: [
                      _buildProfileOption(
                        context,
                        Icons.person_outline,
                        'Edit Profile',
                        'Update your personal information',
                        () => _showEditProfileDialog(),
                      ),
                      _buildProfileOption(
                        context,
                        Icons.favorite_outline,
                        'Relationship Status',
                        'Connected with John Smith',
                        () => _showRelationshipDialog(),
                      ),
                      _buildProfileOption(
                        context,
                        Icons.psychology,
                        'Love Language',
                        'Words of Affirmation',
                        () => _showLoveLanguageDialog(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: PSizes.s32),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PSizes.s16,
                    vertical: PSizes.s16,
                  ),
                  child: Text(
                    'App Settings',
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s14),
                      fontWeight: FontWeight.w600,
                      color: context.pColor.neutral.n60,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                Container(
                  color: context.pColor.neutral.n10,
                  child: Column(
                    children: [
                      _buildSwitchOption(
                        context,
                        Icons.notifications,
                        'Push Notifications',
                        'Receive notifications for messages',
                        notificationsEnabled,
                        (value) {
                          setState(() {
                            notificationsEnabled = value;
                          });
                        },
                      ),
                      _buildSwitchOption(
                        context,
                        Icons.mic,
                        'Voice Messages',
                        'Enable voice message recording',
                        voiceMessagesEnabled,
                        (value) {
                          setState(() {
                            voiceMessagesEnabled = value;
                          });
                        },
                      ),
                      _buildSwitchOption(
                        context,
                        Icons.analytics,
                        'Analytics & Insights',
                        'Share conversation analytics',
                        analyticsEnabled,
                        (value) {
                          setState(() {
                            analyticsEnabled = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: PSizes.s32),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PSizes.s16,
                    vertical: PSizes.s16,
                  ),
                  child: Text(
                    'Privacy & Security',
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s14),
                      fontWeight: FontWeight.w600,
                      color: context.pColor.neutral.n60,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                Container(
                  color: context.pColor.neutral.n10,
                  child: Column(
                    children: [
                      _buildProfileOption(
                        context,
                        Icons.lock_outline,
                        'Change Password',
                        '',
                        () => _showChangePasswordDialog(),
                      ),
                      _buildProfileOption(
                        context,
                        Icons.security_outlined,
                        'Two-Factor Authentication',
                        '',
                        () => _show2FADialog(),
                      ),
                      _buildProfileOption(
                        context,
                        Icons.privacy_tip,
                        'Privacy Settings',
                        '',
                        () => _showPrivacyDialog(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: PSizes.s32),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PSizes.s16,
                    vertical: PSizes.s16,
                  ),
                  child: Text(
                    'Support',
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s14),
                      fontWeight: FontWeight.w600,
                      color: context.pColor.neutral.n60,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                Container(
                  color: context.pColor.neutral.n10,
                  child: Column(
                    children: [
                      _buildProfileOption(
                        context,
                        Icons.help_outline,
                        'Help & Support',
                        '',
                        () => _showHelpDialog(),
                      ),
                      _buildProfileOption(
                        context,
                        Icons.info_outline,
                        'About Pillow Talk',
                        '',
                        () => _showAboutDialog(),
                      ),
                      _buildProfileOption(
                        context,
                        Icons.star_outline,
                        'Rate the App',
                        '',
                        () => _showRateAppDialog(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: PSizes.s32),

                // Sign Out Button
                Container(
                  color: context.pColor.neutral.n10,
                  child: _buildProfileOption(
                    context,
                    Icons.logout,
                    'Sign Out',
                    '',
                    () => _showSignOutDialog(),
                  ),
                ),

                const SizedBox(height: PSizes.s32),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: responsive(context, PSizes.s18),
            fontWeight: FontWeight.bold,
            color: context.pColor.neutral.n10,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: responsive(context, PSizes.s12),
            color: context.pColor.neutral.n10.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileOption(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: context.pColor.neutral.n20, width: 0.5),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: PSizes.s16,
          vertical: PSizes.s12,
        ),
        leading: Icon(
          icon,
          color: context.pColor.neutral.n70,
          size: PSizes.s24,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: responsive(context, PSizes.s16),
            fontWeight: FontWeight.w500,
            color: context.pColor.neutral.n90,
          ),
        ),
        subtitle: subtitle.isNotEmpty
            ? Text(
                subtitle,
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s14),
                  color: context.pColor.neutral.n60,
                ),
              )
            : null,
        trailing: Icon(
          Icons.chevron_right,
          size: 24,
          color: context.pColor.neutral.n50,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchOption(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: context.pColor.neutral.n20, width: 0.5),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: PSizes.s16,
          vertical: PSizes.s12,
        ),
        leading: Icon(
          icon,
          color: context.pColor.neutral.n70,
          size: PSizes.s24,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: responsive(context, PSizes.s16),
            fontWeight: FontWeight.w500,
            color: context.pColor.neutral.n90,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: responsive(context, PSizes.s14),
            color: context.pColor.neutral.n60,
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: context.pColor.primary.base,
        ),
      ),
    );
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: 'Sarah Johnson');
    final emailController = TextEditingController(
      text: 'sarah.johnson@email.com',
    );
    final bioController = TextEditingController(
      text: 'Love spending quality time together',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s18),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: PSizes.s16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: PSizes.s16),
              TextField(
                controller: bioController,
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.pColor.neutral.n60),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessSnackBar('Profile updated successfully!');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.pColor.primary.base,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showImagePickerDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(PSizes.s16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(PSizes.s16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Change Profile Picture',
              style: TextStyle(
                fontSize: responsive(context, PSizes.s18),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: PSizes.s16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageOption(Icons.camera_alt, 'Camera', () {
                  Navigator.pop(context);
                  _showSuccessSnackBar('Camera opened');
                }),
                _buildImageOption(Icons.photo_library, 'Gallery', () {
                  Navigator.pop(context);
                  _showSuccessSnackBar('Gallery opened');
                }),
                _buildImageOption(Icons.delete, 'Remove', () {
                  Navigator.pop(context);
                  _showSuccessSnackBar('Profile picture removed');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: context.pColor.primary.base.withOpacity(0.1),
              borderRadius: BorderRadius.circular(PSizes.s12),
            ),
            child: Icon(
              icon,
              color: context.pColor.primary.base,
              size: PSizes.s24,
            ),
          ),
          const SizedBox(height: PSizes.s8),
          Text(
            label,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s12),
              color: context.pColor.neutral.n70,
            ),
          ),
        ],
      ),
    );
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Sign Out',
          style: TextStyle(
            fontSize: responsive(context, PSizes.s18),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.pColor.neutral.n60),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _performSignOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.pColor.error.base,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  void _performSignOut() async {
    try {
      // Show loading state
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Use auth provider to logout
      final authNotifier = ref.read(authNotifierProvider.notifier);
      await authNotifier.logout();

      // Close loading dialog
      if (mounted) Navigator.pop(context);

      _showSuccessSnackBar('Signed out successfully');

      // Navigate to auth screen
      if (mounted) context.pushNamed(PRouter.auth.path);
    } catch (e) {
      // Close loading dialog if still open
      if (mounted) Navigator.pop(context);

      // Show error message
      _showErrorSnackBar('Failed to sign out. Please try again.');
    }
  }

  void _showRelationshipDialog() {
    _showInfoDialog(
      'Relationship Status',
      'You are connected with John Smith since January 2023.',
    );
  }

  void _showLoveLanguageDialog() {
    _showInfoDialog(
      'Love Language',
      'Your primary love language is Words of Affirmation. This means you feel most loved when receiving affirming words and encouragement.',
    );
  }

  void _showChangePasswordDialog() {
    _showInfoDialog(
      'Change Password',
      'Password change functionality will be implemented here.',
    );
  }

  void _show2FADialog() {
    _showInfoDialog(
      'Two-Factor Authentication',
      '2FA setup will enhance your account security.',
    );
  }

  void _showPrivacyDialog() {
    _showInfoDialog(
      'Privacy Settings',
      'Manage your data privacy and sharing preferences.',
    );
  }

  void _showHelpDialog() {
    _showInfoDialog(
      'Help & Support',
      'Contact our support team at support@pillowtalk.com or visit our FAQ section.',
    );
  }

  void _showAboutDialog() {
    _showInfoDialog(
      'About Pillow Talk',
      'Pillow Talk v1.0.0\nBuilding stronger relationships through better communication.',
    );
  }

  void _showRateAppDialog() {
    _showInfoDialog(
      'Rate the App',
      'We would love your feedback! Please rate us on the App Store or Google Play.',
    );
  }

  void _showInfoDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontSize: responsive(context, PSizes.s18),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: context.pColor.success.base,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PSizes.s8),
        ),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: context.pColor.error.base,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PSizes.s8),
        ),
      ),
    );
  }
}
