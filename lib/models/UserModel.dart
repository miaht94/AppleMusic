import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart'
as http;
class UserModel {
  UserModel(this.name, this.avatarURL, this.email, this.playLists);
  String name;
  String avatarURL;
  String email;
  List<dynamic> playLists;
  bool containPlaylist(String id) {
    for (Map<String, dynamic> json in playLists) {
      if (json['_id'] == id) return true;
    }
    return false;
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(json['name'], json['avatarURL'], json['email'], json['playlists']);
  }
  static Future<UserModel> fetchUser(String appToken) async {
    Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, port: SV_PORT, path: MY_PROFILE_PATH, queryParameters: {
      'app_token': appToken
    });
    final http.Response res = await http.get(httpURI);
    final JsonDecoder decoder = JsonDecoder();
    UserModel user = UserModel.fromJson(decoder.convert(res.body));
    return user;
  }
}

class UserModelNotifier extends ValueNotifier<UserModel> {
  UserModelNotifier(UserModel value) : super(value);
  Future<void> refreshUser() async {
    value = await UserModel.fetchUser(GetIt.I.get<CredentialModelNotifier>().value.appToken);
    notifyListeners();
  }
  Future<bool> addPlaylist(String playlist_name, String playlist_description, String art_url) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: "http://" + SV_HOSTNAME + '/'));
      String fileName = art_url.split('/').last;
      FormData formData = FormData.fromMap({
          "art_url":
              await MultipartFile.fromFile(art_url, filename:fileName),
          "playlist_name": playlist_name,
          "playlist_description": playlist_description,
          "songs": []
      });
      dynamic response = await dio.post(ADD_PLAYLIST, data: formData, queryParameters: {"app_token": GetIt.I.get<CredentialModelNotifier>().value.appToken});
      await refreshUser();
      return true;
    } catch(e) {
      return false;
    }
  }

  Future<bool> deletePlaylist(String playlistId) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl:"http://" + SV_HOSTNAME + '/'));
      FormData formData = FormData.fromMap({
          "_id": playlistId
      });
      dynamic response = await dio.delete(DELETE_PLAYLIST, data: formData, queryParameters: {"app_token": GetIt.I.get<CredentialModelNotifier>().value.appToken});
      await refreshUser();
      return true;
    } catch(e) {
      return false;
    }
  }
}