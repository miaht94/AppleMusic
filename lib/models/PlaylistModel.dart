import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PlaylistModel{
  PlaylistModel(
      this.id,
      this.playlistName,
      this.artUrl,
      this.playlistDescription,
      this.songs,
      this.public,
      );
  String id;
  String playlistName;
  String artUrl;
  String playlistDescription;
  List<dynamic> songs;
  bool public;

  Future<bool> updatePlaylist({String? playlist_name, String? playlist_description,List<String>? songs, String? art_url}) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: 'http://' + SV_HOSTNAME + '/'));
      Map<String, dynamic> form = {};
      playlist_name != null ? form.addAll({'playlist_name': playlist_name}) : '';
      playlist_description != null ? form.addAll({'playlist_description': playlist_description}) : '';
      songs != null ? form.addAll({'songs': songs}) : '';
      art_url != null ? form.addAll({'art_url': await MultipartFile.fromFile(art_url, filename:art_url.split('/').last),}) : '';
      FormData formData = FormData.fromMap(form);
      dynamic response = await dio.post(UPDATE_PLAYLIST, data: formData, queryParameters: {'app_token': GetIt.I.get<CredentialModelNotifier>().value.appToken});
      return true;
    } catch(e) {
      return false;
    }
  }

  Future<bool> addSong(String songId) async {
    List<String> songsId = [];
    for (Map<String, dynamic> json in songs) {
      songsId.add(json['_id']);
    }
    songsId.add(songId);
    return updatePlaylist(songs: songsId);
  }

  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    return PlaylistModel(
        json['_id'],
        json['playlist_name'],
        json['art_url'],
        json['playlist_description'],
        json['songs'],
        json['public'],
    );
  }

  static Future<PlaylistModel> fetchPlaylist(String id) async{
    final Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, port: SV_PORT, path: PLAYLIST_PATH, queryParameters: {
      '_id': id,
      'app_token' : GetIt.I.get<CredentialModelNotifier>().value.appToken,
      'public': '1',
    });
    final  response = await http.get(httpURI);
    if (response.statusCode == 200){
      final JsonDecoder decoder = const JsonDecoder();
      final PlaylistModel song = PlaylistModel.fromJson(decoder.convert(response.body));
      return song;
    } else {
      return Future.error('No playlist for Id($id)');
    }
  }
}

// class PlaylistModelNotifier extends ValueNotifier<PlaylistModel> {
//   PlaylistModelNotifier(PlaylistModel value) : super(value);
//   Future<void> refresh() async {
//     value = await PlaylistModel.fetchPlaylist(value.id);
//     notifyListeners();
//   }
// }