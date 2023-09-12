import 'package:flutter/material.dart';
import 'package:my_profile/values/app_colors.dart';

extension AppSnackBar on BuildContext {
  showSnackBar(String? message, {bool isError = false}) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message ?? ""),
      backgroundColor: isError ? Colors.red : AppColors.colorPrimary,
      duration: const Duration(seconds: 1),
    ));
  }
}