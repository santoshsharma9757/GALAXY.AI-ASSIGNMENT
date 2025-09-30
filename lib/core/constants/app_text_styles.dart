import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Reusable text styles using Lato font family
/// Usage: AppTextStyles.titleLarge, AppTextStyles.bodyMedium, etc.
class AppTextStyles {
  // Display styles (largest)
  static TextStyle displayLarge({Color? color}) => GoogleFonts.lato(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle displayMedium({Color? color}) => GoogleFonts.lato(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle displaySmall({Color? color}) => GoogleFonts.lato(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textPrimary,
      );

  // Headline styles
  static TextStyle headlineLarge({Color? color}) => GoogleFonts.lato(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle headlineMedium({Color? color}) => GoogleFonts.lato(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle headlineSmall({Color? color}) => GoogleFonts.lato(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textPrimary,
      );

  // Title styles
  static TextStyle titleLarge({Color? color}) => GoogleFonts.lato(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle titleMedium({Color? color}) => GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle titleSmall({Color? color}) => GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textPrimary,
      );

  // Body styles (most common)
  static TextStyle bodyLarge({Color? color}) => GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle bodyMedium({Color? color}) => GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle bodySmall({Color? color}) => GoogleFonts.lato(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textPrimary,
      );

  // Label styles (buttons, chips)
  static TextStyle labelLarge({Color? color}) => GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle labelMedium({Color? color}) => GoogleFonts.lato(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle labelSmall({Color? color}) => GoogleFonts.lato(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.textPrimary,
      );

  // Custom styles for specific use cases
  static TextStyle button({Color? color}) => GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.textInverse,
      );

  static TextStyle subtitle({Color? color}) => GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textSecondary,
      );

  static TextStyle caption({Color? color}) => GoogleFonts.lato(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textSecondary,
      );

  static TextStyle overline({Color? color}) => GoogleFonts.lato(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
        color: color ?? AppColors.textSecondary,
      );

  // Helper method for custom text styles with Lato
  static TextStyle custom({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) =>
      GoogleFonts.lato(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? AppColors.textPrimary,
        height: height,
        letterSpacing: letterSpacing,
      );
}
