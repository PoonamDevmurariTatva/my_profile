import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../model/profile_model.dart';
import '../../utils/common_methods.dart';
import '../../utils/preference_constants.dart';
import '../../utils/preference_utils.dart';
import '../../utils/validation.dart';



part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileModel? profile;
  int bottomNavigationBarIndex = 0;

  ProfileCubit() : super(ProfileInitial()) {
    profile = CommonMethod.getProfile;
    emit(ProfileInitial());
  }

  changeProfileData(fieldName, String? fieldValue) {
    var error = Validations.validateField(fieldName, fieldValue);
    if (error.isEmpty) {
      profile?.setField(fieldName, fieldValue);
      setString(PreferenceConstant.profile, jsonEncode(profile?.toJson()));
      if (fieldName == "avatar") {
        emit(ProfilePictureChanged());
      } else {
        emit(ProfileSuccess());
      }
    } else {
      emit(ProfileError(error));
    }
  }

  ImageProvider getProfilePicture() {
    ImageProvider image;
    if (profile?.avatar != null) {
      image = FileImage(File(profile?.avatar ?? ""));
    } else {
      image = const NetworkImage(
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHXi6kWCo1P3qJAuOnEAs6jWS1Dg1BqRkk8Q&usqp=CAU");
    }
    return image;
  }

  setBottomNavigationBarIndex(index) {
    bottomNavigationBarIndex = index;
    emit(ProfileInitial());
  }

  validateFields(
      String name, String email, String skills, String workExperience) {}
}