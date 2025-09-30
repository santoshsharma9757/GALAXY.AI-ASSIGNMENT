import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Utility class for showing toast messages throughout the app
/// Works reliably on both iOS and Android using SnackBar
class ToastUtils {
  static GlobalKey<ScaffoldMessengerState>? _scaffoldMessengerKey;

  /// Initialize with ScaffoldMessenger key
  static void init(GlobalKey<ScaffoldMessengerState> key) {
    _scaffoldMessengerKey = key;
  }

  /// Show a success toast message
  static void showSuccess(String message) {
    _showSnackBar(
      message: message,
      backgroundColor: AppColors.success,
      textColor: AppColors.textInverse,
    );
  }

  /// Show an error toast message
  static void showError(String message) {
    _showSnackBar(
      message: message,
      backgroundColor: AppColors.black.withValues(alpha: 0.8),
      textColor: AppColors.textInverse,
    );
  }

  /// Show a warning toast message
  static void showWarning(String message) {
    _showSnackBar(
      message: message,
      backgroundColor: AppColors.warning,
      textColor: AppColors.textPrimary,
    );
  }

  /// Show an info toast message
  static void showInfo(String message) {
    _showSnackBar(
      message: message,
      backgroundColor: AppColors.black.withValues(alpha: 0.8),
      textColor: AppColors.textInverse,
    );
  }

  /// Internal method to show snackbar
  static void _showSnackBar({
    required String message,
    required Color backgroundColor,
    required Color textColor,
  }) {
    if (_scaffoldMessengerKey?.currentState == null) return;

    // Remove any existing snackbar
    _scaffoldMessengerKey!.currentState!.clearSnackBars();

    // Show new snackbar
    _scaffoldMessengerKey!.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(
          bottom: 70, // Position above keyboard
          left: 70,
          right: 50,
        ),
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// Show a custom toast message
  static void showCustom({
    required String message,
    required Color backgroundColor,
    required Color textColor,
    Duration duration = const Duration(seconds: 2),
  }) {
    _showSnackBar(
      message: message,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }
}