import 'package:flutter/material.dart';

import '../values/app_colors.dart';

class AppCheckBox extends StatelessWidget {
  final bool isChecked;
  final String label;
  final Function(bool isChecked) onChange;
  const AppCheckBox(
      {Key? key,
      this.isChecked = false,
      required this.label,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            onChange(!isChecked);
          },
          child: Icon(
            isChecked
                ? Icons.check_box_rounded
                : Icons.check_box_outline_blank_outlined,
            color: AppColors.colorPrimary,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          label,
          style: TextStyle(color: AppColors.colorBlack, fontSize: 14),
        )
      ],
    ); //.onClick((){onChange(!isChecked);});
  }
}
