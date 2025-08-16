import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pillowtalk/common/common/screen_container.dart';
import 'package:pillowtalk/common/common/app_bar_title.dart';
import 'package:pillowtalk/common/common/alert_dialog.dart';
import 'package:pillowtalk/features/auth/provider/auth_provider.dart';
import 'package:pillowtalk/features/profile/screen/edit_profile_screen.dart';
import 'package:pillowtalk/utils/constant/router.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  // Toggle states
  bool notificationsEnabled = true;
  bool voiceMessagesEnabled = true;
  bool analyticsEnabled = false;
  bool darkModeEnabled = false;
  bool autoBackupEnabled = true;
  bool locationServicesEnabled = false;
  bool _signingOut = false; // <-- add

  @override
  Widget build(BuildContext context) {
    Future<void> signOut() async {
      if (_signingOut) return;

      final confirmed = await PAlertDialogUtils.showConfirmation(
        context,
        title: 'Sign out?',
        message: 'You will need to log in again to continue.',
        confirmLabel: 'Sign Out',
        cancelLabel: 'Cancel',
        isDestructive: true,
      );

      if (confirmed != true) return;

      setState(() => _signingOut = true);
      try {
        // 1) call riverpod logout
        await ref.read(authNotifierProvider.notifier).logout();

        // 2) reset provider state (optional but recommended)
        ref.invalidate(authNotifierProvider);

        // 3) go to your auth route (adjust to your route name if different)
        if (mounted) context.goNamed(PRouter.auth.name);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign out. Please try again.')),
        );
      } finally {
        if (mounted) setState(() => _signingOut = false);
      }
    }

    return PScreenContainer(
      backgroundColor: context.pColor.neutral.n20,
      appBar: PAppBarTitle(title: 'Settings', isBackButtonNeeded: true),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: PSizes.s16),

            // Notifications Section
            _buildSectionHeader('Notifications'),
            _buildSettingsContainer([
              _buildToggleItem(
                Icons.notifications_outlined,
                'Push Notifications',
                'Receive notifications for new messages',
                notificationsEnabled,
                (value) => setState(() => notificationsEnabled = value),
              ),
              _buildToggleItem(
                Icons.mic_outlined,
                'Voice Messages',
                'Enable voice message notifications',
                voiceMessagesEnabled,
                (value) => setState(() => voiceMessagesEnabled = value),
              ),
            ]),

            const SizedBox(height: PSizes.s24),

            // Account Section
            _buildSectionHeader('Account'),
            _buildSettingsContainer([
              _buildMenuItem(
                Icons.person_outline,
                'Profile Information',
                'Update your personal details',
                () => context.pushNamed(PRouter.profileEdit.name),
              ),
              _buildMenuItem(
                Icons.lock_outline,
                'Privacy & Security',
                'Manage your privacy settings',
                () => _navigateToPrivacySecurity(),
              ),
              _buildMenuItem(
                Icons.favorite_outline,
                'Relationship Settings',
                'Configure couple preferences',
                () => _navigateToRelationshipSettings(),
              ),
            ]),

            const SizedBox(height: PSizes.s24),

            // App Preferences Section
            _buildSectionHeader('App Preferences'),
            _buildSettingsContainer([
              _buildToggleItem(
                Icons.dark_mode_outlined,
                'Dark Mode',
                'Switch to dark theme',
                darkModeEnabled,
                (value) => setState(() => darkModeEnabled = value),
              ),
              _buildToggleItem(
                Icons.analytics_outlined,
                'Analytics & Insights',
                'Share anonymous usage data',
                analyticsEnabled,
                (value) => setState(() => analyticsEnabled = value),
              ),
              _buildMenuItem(
                Icons.language_outlined,
                'Language',
                'English',
                () => _navigateToLanguage(),
              ),
            ]),

            const SizedBox(height: PSizes.s24),

            // Data & Storage Section
            _buildSectionHeader('Data & Storage'),
            _buildSettingsContainer([
              _buildToggleItem(
                Icons.backup_outlined,
                'Auto Backup',
                'Automatically backup conversations',
                autoBackupEnabled,
                (value) => setState(() => autoBackupEnabled = value),
              ),
              _buildToggleItem(
                Icons.location_on_outlined,
                'Location Services',
                'Allow location-based features',
                locationServicesEnabled,
                (value) => setState(() => locationServicesEnabled = value),
              ),
              _buildMenuItem(
                Icons.storage_outlined,
                'Storage Management',
                'Manage app data and cache',
                () => _navigateToStorage(),
              ),
            ]),

            const SizedBox(height: PSizes.s24),

            // Support Section
            _buildSectionHeader('Support'),
            _buildSettingsContainer([
              _buildMenuItem(
                Icons.help_outline,
                'Help Center',
                'Get help and support',
                () => _navigateToHelpCenter(),
              ),
              _buildMenuItem(
                Icons.feedback_outlined,
                'Send Feedback',
                'Share your thoughts with us',
                () => _navigateToFeedback(),
              ),
              _buildMenuItem(
                Icons.info_outline,
                'About',
                'App version and information',
                () => _navigateToAbout(),
              ),
            ]),

            const SizedBox(height: PSizes.s24),

            // Danger Zone Section
            _buildSectionHeader('Account Actions'),
            _buildSettingsContainer([
              _buildMenuItem(
                Icons.logout,
                'Sign Out',
                'Sign out of your account',
                () => signOut(),
                isDestructive: true,
              ),
              _buildMenuItem(
                Icons.delete_forever,
                'Delete Account',
                'Permanently delete your account',
                () => _navigateToDeleteAccount(),
                isDestructive: true,
              ),
            ]),

            const SizedBox(height: PSizes.s32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: PSizes.s16,
        vertical: PSizes.s8,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: responsive(context, PSizes.s14),
            fontWeight: FontWeight.w600,
            color: context.pColor.neutral.n60,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsContainer(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: PSizes.s16),
      decoration: BoxDecoration(
        color: context.pColor.neutral.n10,
        borderRadius: BorderRadius.circular(PSizes.s12),
        border: Border.all(color: context.pColor.neutral.n30),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildToggleItem(
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
          vertical: PSizes.s8,
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
          inactiveThumbColor: context.pColor.neutral.n50,
          inactiveTrackColor: context.pColor.neutral.n30,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    final textColor = isDestructive
        ? context.pColor.error.base
        : context.pColor.neutral.n90;
    final iconColor = isDestructive
        ? context.pColor.error.base
        : context.pColor.neutral.n70;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: context.pColor.neutral.n20, width: 0.5),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: PSizes.s16,
          vertical: PSizes.s8,
        ),
        leading: Icon(icon, color: iconColor, size: PSizes.s24),
        title: Text(
          title,
          style: TextStyle(
            fontSize: responsive(context, PSizes.s16),
            fontWeight: FontWeight.w500,
            color: textColor,
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
          size: 20,
          color: context.pColor.neutral.n50,
        ),
        onTap: onTap,
      ),
    );
  }

  // Navigation methods (no logic, just placeholders)

  void _navigateToPrivacySecurity() {
    // Navigate to privacy & security screen
  }

  void _navigateToRelationshipSettings() {
    // Navigate to relationship settings screen
  }

  void _navigateToLanguage() {
    // Navigate to language selection screen
  }

  void _navigateToStorage() {
    // Navigate to storage management screen
  }

  void _navigateToHelpCenter() {
    // Navigate to help center screen
  }

  void _navigateToFeedback() {
    // Navigate to feedback screen
  }

  void _navigateToAbout() {
    // Navigate to about screen
  }

  void _navigateToDeleteAccount() {
    // Navigate to delete account confirmation screen
  }
}
