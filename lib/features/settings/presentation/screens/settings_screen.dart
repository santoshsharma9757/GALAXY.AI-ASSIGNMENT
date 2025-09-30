import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: AppDimensions.elevationNone,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          AppStrings.settings,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Profile Section
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingXXL),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  backgroundImage: const NetworkImage(
                    'https://i.pravatar.cc/150?img=33',
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingL),
                const Text(
                  'santosh sharma',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1, color: AppColors.border),
          
          // Settings List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingS),
              children: [
                _SettingsItem(
                  icon: Icons.settings_outlined,
                  title: AppStrings.general,
                  onTap: () {
                    // Handle General
                  },
                ),
                _SettingsItem(
                  icon: Icons.email_outlined,
                  title: AppStrings.email,
                  subtitle: 'santoshsharma9757@gmail.com',
                  onTap: () {
                    // Handle Email
                  },
                ),
                _SettingsItem(
                  icon: Icons.workspace_premium_outlined,
                  title: AppStrings.upgradeToGo,
                  onTap: () {
                    // Handle Upgrade
                  },
                ),
                _SettingsItem(
                  icon: Icons.person_outline,
                  title: AppStrings.personalization,
                  onTap: () {
                    // Handle Personalization
                  },
                ),
                _SettingsItem(
                  icon: Icons.data_usage_outlined,
                  title: AppStrings.dataControls,
                  onTap: () {
                    // Handle Data Controls
                  },
                ),
                _SettingsItem(
                  icon: Icons.mic_none_outlined,
                  title: AppStrings.voice,
                  onTap: () {
                    // Handle Voice
                  },
                ),
                _SettingsItem(
                  icon: Icons.security_outlined,
                  title: AppStrings.security,
                  onTap: () {
                    // Handle Security
                  },
                ),
                _SettingsItem(
                  icon: Icons.info_outline,
                  title: AppStrings.about,
                  onTap: () {
                    // Handle About
                  },
                ),
                const SizedBox(height: AppDimensions.paddingL),
                _SettingsItem(
                  icon: Icons.logout,
                  title: AppStrings.signOut,
                  textColor: AppColors.error,
                  iconColor: AppColors.error,
                  onTap: () {
                    _showSignOutDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              AppStrings.signOut,
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;

  const _SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? AppColors.iconPrimary,
        size: AppDimensions.iconL,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor ?? AppColors.textPrimary,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            )
          : null,
      onTap: onTap,
    );
  }
}
