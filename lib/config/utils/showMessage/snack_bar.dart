import 'dart:io';

import 'package:coffee_app_bloc/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:floating_snackbar/floating_snackbar.dart';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class MessageUtils {
  /// Show a Floating SnackBar at the bottom, automatically dismissing after 2 seconds
  static void showSnackBar({
    required BuildContext context,
    required String title,
    required String message,
    required ContentType contentType,
  }) {
    floatingSnackBar(
      message: message,
      context: context,
      textColor: Colors.white,
      textStyle: TextStyle(color: Colors.black), // Customize text style
      duration: Duration(seconds: 2), // Automatically hides after 2 seconds
      // Example: Green for success, Red for failure
    );
  }

  /// Show a Floating SnackBar for error messages
  static void error({
    required BuildContext context,
    String title = "Error",
    required String message,
    // ContentType contentType = ContentType.failure,
  }) {
    floatingSnackBar(
      message: message,
      context: context,
      textColor: Colors.white,
      backgroundColor: Colors.red, // Red for error
      duration: Duration(seconds: 2), // Auto-dismiss after 2 seconds
    );
  }

  /// Show a Floating SnackBar for success messages
  static void success({
    required BuildContext context,
    String title = "Success",
    required String message,
    // ContentType contentType = ContentType.success,
  }) {
    floatingSnackBar(
      message: message,
      context: context,
      textColor: Colors.white,
      backgroundColor: AppColors.submitColor,
      duration: Duration(seconds: 2), // Auto-dismiss after 2 seconds
    );
  }
}
