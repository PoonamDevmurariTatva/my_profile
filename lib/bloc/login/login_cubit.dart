

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_profile/bloc/login/repository/login_repository.dart';

import '../../utils/preference_constants.dart';
import '../../utils/preference_utils.dart';
import '../../utils/response.dart';
import '../../utils/validation.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  LoginRepository loginRepository;

  LoginCubit(this.loginRepository)
      : super(LoginInitial()) {
    rememberMe = getString(PreferenceConstant.rememberedMail).isNotEmpty;
    getSavedEmail();
  }

  getSavedEmail() async {
    emailController.text = getString(PreferenceConstant.rememberedMail, null);
  }

  login() async {
    if (loginFormValid()) {
      emit(LoginLoading());
      var result = await loginRepository.loginWithEmailAndPassword(
          emailController.text, passwordController.text);
      if (result.status == Status.SUCCEED) {
        setString(PreferenceConstant.rememberedMail,
            rememberMe ? emailController.text : "");
        setString(
            PreferenceConstant.profile, jsonEncode(result.data?.toJson()));
        setBool(PreferenceConstant.isLoggedIn, true);
        emit(LoginSucceed());
      } else {
        emit(LoginError(result.message ?? ""));
      }
    }
  }

  bool loginFormValid() {
    String emailError = Validations.validateEmail(emailController.text);
    String passwordError =
    Validations.validatePassword(passwordController.text);
    if (emailError.isNotEmpty) {
      emit(LoginError(emailError));
      return false;
    } else if (passwordError.isNotEmpty) {
      emit(LoginError(passwordError));
      return false;
    } else {
      return true;
    }
  }

  changeRememberMe(bool isChecked) {
    rememberMe = isChecked;
    emit(RememberMeChanged());
  }
}