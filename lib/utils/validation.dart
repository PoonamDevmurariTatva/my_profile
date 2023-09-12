import '../values/app_strings.dart';

class Validations {
  static String validateEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regex = RegExp(pattern.toString());

    if (email.isEmpty) {
      return AppStrings.errorEmailRequired;
    } else if (!regex.hasMatch(email)) {
      return AppStrings.errorEmailNotValid;
    } else {
      return "";
    }
  }

  static String validatePassword(String password) {
    if (password.isEmpty) {
      return AppStrings.errorPasswordRequired;
    } else if (password.length < 6) {
      return AppStrings.errorPasswordMinimumSixCharRequired;
    } else {
      return "";
    }
  }

  static String validateField(String fieldName, String? fieldValue) {
    print(fieldValue);
    if (fieldValue == null || fieldValue.isEmpty) {
      return fieldErrors[fieldName] ?? "";
    } else if (fieldName == "email") {
      return Validations.validateEmail(fieldValue);
    } else {
      return "";
    }
  }
}