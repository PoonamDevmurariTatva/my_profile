import 'package:flutter/material.dart';

import '../values/app_colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? inputType;
  final InputDecoration? decoration;
  final String? hint;
  final bool? obscureText;
  final int? maxLine;

  const AppTextField(
      {Key? key,
        required this.controller,
        this.inputType,
        this.decoration,
        this.hint,
        this.obscureText,
        this.maxLine = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        keyboardType: inputType ?? TextInputType.name,
        obscureText: obscureText ?? false,
        maxLines: maxLine,

        decoration: InputDecoration(
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.colorBlack, width: 0),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.colorPrimary, width: 0),
              borderRadius: BorderRadius.circular(10),
            )));
  }
}