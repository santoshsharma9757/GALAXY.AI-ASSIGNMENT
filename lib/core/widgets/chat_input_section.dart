import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_strings.dart';
import '../utils/snackbar_utils.dart';

class ChatInputSection extends StatefulWidget {
  final Function(String)? onSendMessage;
  final VoidCallback? onFileUpload;
  final VoidCallback? onVoiceInput;
  final VoidCallback? onShowBottomSheet;

  const ChatInputSection({
    super.key,
    this.onSendMessage,
    this.onFileUpload,
    this.onVoiceInput,
    this.onShowBottomSheet,
  });

  @override
  State<ChatInputSection> createState() => _ChatInputSectionState();
}

class _ChatInputSectionState extends State<ChatInputSection> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto-focus the text field when the widget is first built
    // Add delay for iOS and profile/release mode compatibility
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          // For iOS, we need to ensure focus happens after build is complete
          FocusScope.of(context).requestFocus(_focusNode);
        }
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      ToastUtils.showError("Please enter a message");
      return;
    }

    widget.onSendMessage?.call(text);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingS),
      child: SafeArea(
        child: Row(
          children: [
            GestureDetector(
              onTap: widget.onShowBottomSheet ?? widget.onFileUpload,
              child: _buildSvgIconButton(
                svgPath: 'assets/svg/gallery.svg',
                onTap: widget.onShowBottomSheet ?? widget.onFileUpload,
                isCircular: true, // attach button is perfectly circular
              ),
            ),
            const SizedBox(width: AppDimensions.paddingM),
            Expanded(child: _buildTextField()),
          ],
        ),
      ),
    );
  }

  Widget _buildSvgIconButton({
    required String svgPath,
    required VoidCallback? onTap,
    bool isCircular = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingS),
        decoration: BoxDecoration(
          color: AppColors.grey.withValues(alpha: 0.2),
          shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircular
              ? null
              : BorderRadius.circular(AppDimensions.radiusM),
        ),
        child: SvgPicture.asset(
          svgPath,
          width: AppDimensions.iconL,
          height: AppDimensions.iconL,
          colorFilter: const ColorFilter.mode(
            AppColors.iconPrimary,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXXXL),
      ),
      child: TextField(
        controller: _textController,
        focusNode: _focusNode,
        decoration: InputDecoration(
          hintText: AppStrings.askAnything,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingL,
            vertical: AppDimensions.paddingM,
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSuffixSvgIconButton(
                svgPath: 'assets/svg/mic.svg',
                onTap: widget.onVoiceInput,
              ),
              const SizedBox(width: AppDimensions.paddingM),
              _buildSuffixIconButton(
                icon: Icons.arrow_upward,
                onTap: _sendMessage,
                isPrimary: true,
              ),
              const SizedBox(width: AppDimensions.paddingM),
            ],
          ),
        ),
        maxLines: null,
        textInputAction: TextInputAction.send,
        onSubmitted: (_) => _sendMessage(),
      ),
    );
  }

  Widget _buildSuffixIconButton({
    required IconData icon,
    required VoidCallback? onTap,
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingXS),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        ),
        child: Icon(
          icon,
          color: isPrimary ? AppColors.textInverse : AppColors.iconPrimary,
          size: AppDimensions.iconM,
        ),
      ),
    );
  }

  Widget _buildSuffixSvgIconButton({
    required String svgPath,
    required VoidCallback? onTap,
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingXS),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        ),
        child: SvgPicture.asset(
          svgPath,
          width: AppDimensions.iconM,
          height: AppDimensions.iconM,
          colorFilter: ColorFilter.mode(
            isPrimary ? AppColors.textInverse : Colors.grey,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
