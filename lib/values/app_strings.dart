class AppStrings {
  static String errorEmailRequired = "Email required.";
  static String errorEmailNotValid = "Enter valid email.";
  static String errorPasswordRequired = "Password required.";
  static String errorPasswordMinimumSixCharRequired =
      "Minimum 6 characters required.";
  static String errorIncorrectPassword = "Incorrect password";
  static String errorUserNotFound = "User not found, Please try with ";
  static String logout = "Logout";
  static String no = "No";
  static String yes = "Yes";
  static String save = "Save";
  static String editProfile = "Edit Profile";
  static String logoutConfirmationText = "Are you sure you want to logout?";
  static String closeWithoutSaving =
      "Are you want to close this without saving information";
  static String gallery = "Gallery";
  static String camera = "Camera";
  static String cancel = "Cancel";
  static String skill = "Skill";
  static String userName = "Username";
  static String email = "Email";
  static String workExperience = "Work Experience";
  static String allowAccess = "Allow Access";
  static String labelPleaseAllowAccessToYourPhotos =
      "Please allow access to your photos.";
  static String labelThisAllowsYuMeToChoosePhotosFromYourLibrary =
      "This allows application to choose photos from your library.";
  static String labelPleaseAllowAccessToYourCamera =
      "Please allow access to your camera.";
  static String labelThisAllowsYuMeToCapturePhotosFromYourCamera =
      "This allows application to capture photos from your camera.";
}

enum ImagePermissionStatus { isGranted, isDenied }

Map<String, String> fieldErrors = {
  "name": "Please enter your name",
  "email": "Please enter your email",
  "skill": "Please enter your skills",
  "workExperience": "Please enter your work experience",
  "avatar": "Profile picture required"
};