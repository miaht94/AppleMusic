class UserModel {
  UserModel(this.name, this.avatarURL, this.email, this.playLists);
  String name;
  String avatarURL;
  String email;
  List<dynamic> playLists;
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(json['name'], json['avatarURL'], json['email'], json['playlists']);
  }
}