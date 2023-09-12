import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/profile/profile_cubit.dart';
import '../utils/common_methods.dart';
import '../utils/navigation/app_routes.dart';
import '../utils/navigation/navigation_routes.dart';
import '../utils/preference_constants.dart';
import '../utils/preference_utils.dart';
import '../values/app_colors.dart';
import '../values/app_strings.dart';
import 'components/profile_picture.dart';
import 'components/skill_experience_item.dart';
import 'components/username.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => current is! ProfileError,
      builder: (context, state) {
        var cubit = context.read<ProfileCubit>();
        return Scaffold(
          backgroundColor: AppColors.colorWhite,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 250,
                    child: Stack(
                      children: [
                        Container(
                          height: 200,
                          color: AppColors.colorPrimary,
                          child: Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton.icon(
                                        onPressed: () =>
                                            CommonMethod.openAlertDialog(
                                                AppStrings
                                                    .logoutConfirmationText,
                                                () => doLogout(context)),
                                        icon: Icon(Icons.logout,
                                            color: AppColors.colorBlack),
                                        label: Text(
                                          AppStrings.logout,
                                          style: TextStyle(
                                              color: AppColors.colorBlack),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Positioned(
                          right: 0,
                          left: 0,
                          bottom: 0,
                          child: ProfilePicture(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Username(),
                  const SizedBox(
                    height: 50.0,
                  ),
                  SkillExperienceItem(
                      title: 'Skill', subTitle: cubit.profile?.skill ?? ""),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SkillExperienceItem(
                      title: 'Work Experience',
                      subTitle: cubit.profile?.workExperience ?? ""),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  doLogout(BuildContext context) {
    String rememberedEmail = getString(PreferenceConstant.rememberedMail);
    clear();
    setString(PreferenceConstant.rememberedMail, rememberedEmail);
    NavigationRoutes.pop(context);
    NavigationRoutes.pushAndRemoveUntil(context, Screens.login);
  }
}
