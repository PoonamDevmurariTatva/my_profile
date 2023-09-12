import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/profile/profile_cubit.dart';
import '../values/app_colors.dart';
import 'edit_profile.dart';
import 'my_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        buildWhen: (previous, current) => current is! ProfileError,
        builder: (context, state) {
          var cubit = context.read<ProfileCubit>();
          return Scaffold(
              backgroundColor: AppColors.colorWhite,
              bottomNavigationBar: BottomNavigationBar(
                onTap: (value) {
                  cubit.setBottomNavigationBarIndex(value);
                },
                currentIndex: cubit.bottomNavigationBarIndex,
                items:  [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle, color: AppColors.colorPrimary,), label: "Profile", ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.edit, color: AppColors.colorPrimary,), label: "Edit Profile", )
                ],
              ),
              body: cubit.bottomNavigationBarIndex == 0
                  ? const MyProfile()
                  : const EditProfile());
        },
      ),
    );
  }
}