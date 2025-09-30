import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class GptModelDropdown extends StatefulWidget {
  final String selectedModel;
  final ValueChanged<String> onModelChanged;

  const GptModelDropdown({
    super.key,
    required this.selectedModel,
    required this.onModelChanged,
  });

  @override
  State<GptModelDropdown> createState() => _GptModelDropdownState();
}

class _GptModelDropdownState extends State<GptModelDropdown> {
  final List<String> _models = [
    AppStrings.gpt4,
    AppStrings.gpt4Turbo,
    AppStrings.gpt35Turbo,
    AppStrings.gpt4o,
    AppStrings.gpt4oMini,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.buttonHeightM,
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingS),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          value: widget.selectedModel,
          isExpanded: false,
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.iconSecondary,
              size: AppDimensions.iconM,
            ),
          ),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.zero,
            height: AppDimensions.buttonHeightM,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 300,
            elevation: 8,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
            offset: const Offset(0, -4), // Position dropdown below button
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: WidgetStateProperty.all(6),
              thumbVisibility: WidgetStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
          ),
          items: _models.map((String model) {
            return DropdownMenuItem<String>(
              value: model,
              child: Text(
                model,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              widget.onModelChanged(newValue);
            }
          },
        ),
      ),
    );
  }
}
