import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

class UpgradeScreen extends StatelessWidget {
  const UpgradeScreen({super.key});

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
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimensions.paddingXXL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'ChatGPT ',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          TextSpan(
                            text: 'Go',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingM),
                    const Text(
                      AppStrings.getMoreAccess,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingXXXL),

                    // Features Table Header
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            AppStrings.features,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 60,
                          child: Text(
                            AppStrings.free,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppDimensions.paddingL),
                        SizedBox(
                          width: 60,
                          child: Text(
                            AppStrings.go,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.paddingL),

                    // Features List
                    _FeatureRow(
                      title: AppStrings.accessToGPT5,
                      hasFree: true,
                      hasGo: true,
                    ),
                    _FeatureRow(
                      title: AppStrings.moreMessages,
                      hasFree: false,
                      hasGo: true,
                    ),
                    _FeatureRow(
                      title: AppStrings.moreFileUploads,
                      hasFree: false,
                      hasGo: true,
                    ),
                    _FeatureRow(
                      title: AppStrings.moreImageGeneration,
                      hasFree: false,
                      hasGo: true,
                    ),
                    _FeatureRow(
                      title: AppStrings.moreAdvancedDataAnalysis,
                      hasFree: false,
                      hasGo: true,
                    ),
                    _FeatureRow(
                      title: AppStrings.moreMemory,
                      hasFree: false,
                      hasGo: true,
                    ),

                    const SizedBox(height: AppDimensions.paddingXXXL),
                  ],
                ),
              ),
            ),

            // Bottom Section
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingXXL),
              child: Column(
                children: [
                  // Restore Subscription
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // Handle restore subscription
                      },
                      child: const Text(
                        AppStrings.restoreSubscription,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  // Upgrade Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle upgrade
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.textPrimary,
                        foregroundColor: AppColors.textInverse,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusXXXL,
                          ),
                        ),
                      ),
                      child: const Text(
                        AppStrings.upgradeToGo,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingL),
                  // Pricing Info
                  const Text(
                    AppStrings.renewsFor,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
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

class _FeatureRow extends StatelessWidget {
  final String title;
  final bool hasFree;
  final bool hasGo;

  const _FeatureRow({
    required this.title,
    required this.hasFree,
    required this.hasGo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingL),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          SizedBox(
            width: 60,
            child: Center(
              child: hasFree
                  ? const Icon(
                      Icons.check,
                      color: AppColors.textSecondary,
                      size: AppDimensions.iconM,
                    )
                  : const Text(
                      '—',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.textSecondary,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: AppDimensions.paddingL),
          SizedBox(
            width: 60,
            child: Center(
              child: hasGo
                  ? const Icon(
                      Icons.check,
                      color: AppColors.primary,
                      size: AppDimensions.iconM,
                    )
                  : const Text(
                      '—',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.textSecondary,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
