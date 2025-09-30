import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../utils/snackbar_utils.dart';

class AiBottomSheet extends StatelessWidget {
  final VoidCallback? onCameraTap;
  final VoidCallback? onPhotosTap;
  final VoidCallback? onFilesTap;
  final VoidCallback? onThinkLongerTap;
  final VoidCallback? onDeepResearchTap;
  final VoidCallback? onStudyAndLearnTap;
  final VoidCallback? onCreateImageTap;
  final VoidCallback? onWebSearchTap;

  const AiBottomSheet({
    super.key,
    this.onCameraTap,
    this.onPhotosTap,
    this.onFilesTap,
    this.onThinkLongerTap,
    this.onDeepResearchTap,
    this.onStudyAndLearnTap,
    this.onCreateImageTap,
    this.onWebSearchTap,
  });

  Future<void> _pickImageFromCamera(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      
      if (image != null) {
        Navigator.pop(context);
        ToastUtils.showSuccess("Image captured: ${image.name}");
      }
    } catch (e) {
      ToastUtils.showError("Error accessing camera");
    }
  }

  Future<void> _pickImageFromGallery(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      
      if (image != null) {
        Navigator.pop(context);
        ToastUtils.showSuccess("Image selected: ${image.name}");
      }
    } catch (e) {
      ToastUtils.showError("Error accessing gallery");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusXXL),
          topRight: Radius.circular(AppDimensions.radiusXXL),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: AppDimensions.paddingM),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
          ),
          
          const SizedBox(height: AppDimensions.paddingXXL),
          
          // Input Options Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingXXL),
            child: Row(
              children: [
                Expanded(
                  child: _InputOptionButton(
                    icon: Icons.camera_alt,
                    label: AppStrings.camera,
                    onTap: () => _pickImageFromCamera(context),
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingM),
                Expanded(
                  child: _InputOptionButton(
                    icon: Icons.photo_library,
                    label: AppStrings.photos,
                    onTap: () => _pickImageFromGallery(context),
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingM),
                Expanded(
                  child: _InputOptionButton(
                    icon: Icons.attach_file,
                    label: AppStrings.files,
                    onTap: onFilesTap,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppDimensions.paddingXXXL),
          
          // AI Functionalities Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingXXL),
            child: Column(
              children: [
                _AiFunctionalityItem(
                  icon: Icons.lightbulb_outline,
                  label: AppStrings.thinkLonger,
                  onTap: onThinkLongerTap,
                ),
                const SizedBox(height: AppDimensions.paddingL),
                _AiFunctionalityItem(
                  icon: Icons.search,
                  label: AppStrings.deepResearch,
                  onTap: onDeepResearchTap,
                ),
                const SizedBox(height: AppDimensions.paddingL),
                _AiFunctionalityItem(
                  icon: Icons.menu_book_outlined,
                  label: AppStrings.studyAndLearn,
                  onTap: onStudyAndLearnTap,
                ),
                const SizedBox(height: AppDimensions.paddingL),
                _AiFunctionalityItem(
                  icon: Icons.auto_awesome,
                  label: AppStrings.createImage,
                  onTap: onCreateImageTap,
                ),
                const SizedBox(height: AppDimensions.paddingL),
                _AiFunctionalityItem(
                  icon: Icons.language,
                  label: AppStrings.webSearch,
                  onTap: onWebSearchTap,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppDimensions.paddingXXXL),
          
          // Bottom indicator
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
          ),
          
          const SizedBox(height: AppDimensions.paddingL),
        ],
      ),
    );
  }
}

class _InputOptionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _InputOptionButton({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppDimensions.iconL,
              color: AppColors.textPrimary,
            ),
            const SizedBox(height: AppDimensions.paddingS),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AiFunctionalityItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _AiFunctionalityItem({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingM,
          horizontal: AppDimensions.paddingL,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: AppDimensions.iconM,
              color: AppColors.textPrimary,
            ),
            const SizedBox(width: AppDimensions.paddingL),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
