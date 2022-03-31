class UserModel {
  UserModel(this.name, this.avatarURL, this.email);
  String name;
  String avatarURL;
  String email;
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(json['data']['name'], json['data']['avatarURL'], json['data']['email']);
  }
}