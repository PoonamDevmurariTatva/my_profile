import 'dart:convert';

import '../../../model/profile_model.dart';
import '../../../utils/common_methods.dart';
import '../../../utils/preference_constants.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/response.dart';
import '../../../values/app_strings.dart';

class LoginRepository {
  var profile = CommonMethod.getProfile ??
      ProfileModel(
          name: "Poonam Devmurari",
          email: "poonam.devmurari@tatvasoft.com",
          skill:
          "Flutter (for iOS, Android, Web), BLoC, Dart, Android, Core Java, swift",
          workExperience:
          'I have total 4 years of experience in flutter development.'
              'In this span of time developed 9 Projects in which 2 projects support web as well.',
          avatar: null);
  ProfileModel emptyUser = ProfileModel.empty();

  Future<Response<ProfileModel>> loginWithEmailAndPassword(
      String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    if (profile.email?.toLowerCase() != email.toLowerCase()) {
      return Response.error("${AppStrings.errorUserNotFound}${profile.email}");
    } else if (password == "Poonam") {
      if (CommonMethod.getProfile == null) {
        setString(PreferenceConstant.profile, jsonEncode(profile.toJson()));
      }
      return Response.succeed(profile);
    } else {
      return Response.error(AppStrings.errorIncorrectPassword);
    }
  }
}