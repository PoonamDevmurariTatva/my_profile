class ProfileModel {
  String? name;
  String? email;
  String? skill;
  String? workExperience;
  String? avatar;

  ProfileModel(
      {this.name, this.email, this.skill, this.workExperience, this.avatar});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    skill = json['skill'];
    workExperience = json['workExperience'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['skill'] = skill;
    data['workExperience'] = workExperience;
    data['avatar'] = avatar;
    return data;
  }

  ProfileModel.empty() {
    ProfileModel(
        name: "", email: "", skill: "", workExperience: "", avatar: "");
  }

  setField(fieldName, fieldValue) {
    switch (fieldName) {
      case "name":
        name = fieldValue;
        break;
      case "email":
        email = fieldValue;
        break;
      case "skill":
        skill = fieldValue;
        break;
      case "workExperience":
        workExperience = fieldValue;
        break;
      case "avatar":
        avatar = fieldValue;
        break;
    }
  }

  String? getField(fieldName) {
    switch (fieldName) {
      case "name":
        return name;
      case "email":
        return email;
      case "skill":
        return skill;
      case "workExperience":
        return workExperience;
      case "avatar":
        return avatar;
      default:
        return "";
    }
  }
}