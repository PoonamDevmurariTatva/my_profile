import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_profile/utils/preference_constants.dart';
import 'package:my_profile/utils/preference_utils.dart';

import '../model/profile_model.dart';
import '../values/app_colors.dart';
import '../values/app_strings.dart';
import '../widgets/app_buttons.dart';
import '../widgets/app_text_field.dart';
import 'navigation/app_routes.dart';

class CommonMethod {
  static removeFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static ProfileModel? get getProfile {
    var jsonProfile = getString(PreferenceConstant.profile, "");
    if (jsonProfile.isNotEmpty) {
      var profile = ProfileModel.fromJson(jsonDecode(jsonProfile));
      return profile;
    }
    return null;
  }

  openEditBottomSheet(
      String title, int maxLines, Function? onSave, String? initialValue) {
    TextEditingController controller = TextEditingController();
    controller.text = initialValue ?? "";
    showModalBottomSheet(
      context: navigationKey.currentContext!,
      isDismissible: false,
      enableDrag: false,
      elevation: 10,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            if (initialValue != controller.text.toString()) {
              openAlertDialog(AppStrings.closeWithoutSaving, () {
                NavigationRoutes.pop(context);
                NavigationRoutes.pop(context);
              });
              return false;
            } else {
              return true;
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Edit $title",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            if (initialValue != controller.text.toString()) {
                              openAlertDialog(AppStrings.closeWithoutSaving,
                                      () {
                                    NavigationRoutes.pop(context);
                                    NavigationRoutes.pop(context);
                                  });
                            } else {
                              NavigationRoutes.pop(context);
                            }
                          },
                          icon: const Icon(Icons.clear))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    hint: title,
                    maxLine: maxLines,
                    controller: controller,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppButton(
                      text: "Save",
                      onTap: () {
                        onSave?.call(controller.text);
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static openAlertDialog(String title, Function? onPressed) {
    showCupertinoDialog(
        context: navigationKey.currentContext!,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text(
              title,
              style: const TextStyle(fontSize: 16.0),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    NavigationRoutes.pop(context);
                  },
                  child: Text(
                    AppStrings.no,
                    style: TextStyle(color: AppColors.colorBlack),
                  )),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.colorPrimary,
                    border: Border.all(
                      color: AppColors.colorWhite,
                    ),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(10))),
                child: TextButton(
                    onPressed: () => onPressed?.call(),
                    child: Text(
                      AppStrings.yes,
                      style: TextStyle(color: AppColors.colorBlack),
                    )),
              ),
            ],
          );
        });
  }
}