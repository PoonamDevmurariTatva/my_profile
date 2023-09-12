import 'package:flutter/material.dart';
import 'package:my_profile/values/app_colors.dart';

class ProgressDialogUtil {
  static bool _isLoading = false;
  static showProgressDialog(BuildContext context) {
    if (!_isLoading) {
      _isLoading = true;
      showDialog(
          context: context,
          builder: (context) {
            return  Center(
                key: ValueKey("dialog"),
                child: CircularProgressIndicator(color: AppColors.colorPrimary));
          });
    }
  }

  static dismissProgressDialog(BuildContext context) {
    if (_isLoading) {
      Navigator.of(context).pop();
    }
    _isLoading = false;
  }
}