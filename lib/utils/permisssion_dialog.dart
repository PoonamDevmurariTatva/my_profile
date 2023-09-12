import 'package:flutter/material.dart';

import '../values/app_colors.dart';
import '../values/app_strings.dart';

showPermissionDialog(BuildContext context, Function allowAccess,
    String titleText, String subTitleText) {
  var alertDialog = AlertDialog(
    title: Text(
      titleText,
      style:
      TextStyle(fontWeight: FontWeight.w500, color: AppColors.colorBlack),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          subTitleText,
          style: TextStyle(
              fontWeight: FontWeight.w400, color: AppColors.colorBlack),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () => allowAccess.call(),
                child: Text(AppStrings.allowAccess,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.colorBlack))),
            TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: false).pop();
                },
                child: Text(AppStrings.cancel,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.colorBlack))),
          ],
        ),
      ],
    ),
  );

  showDialog(
    context: context,
    builder: (context) => alertDialog,
    useRootNavigator: false,
  );
}