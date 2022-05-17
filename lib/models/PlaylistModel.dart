import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class PlaylistModel{
  PlaylistModel(
      this.id,
      this.playlistName,
      this.artUrl,
      this.playlistDescription,
      this.songs,
      // ignore: avoid_positional_boolean_parameters
      this.public,
      );
  String id;
  String playlistName;
  String artUrl;
  String playlistDescription;
  List<dynamic> songs;
  bool public;

  // ignore: non_constant_identifier_names
  Future<bool> updatePlaylist({String? playlist_name, String? playlist_description,List<String>? songs, String? art_url}) async {
    try {
      final Map<String, dynamic> form = {};
      // ignore: unnecessary_statements
      playlist_name != null ? form.addAll({'playlist_name': playlist_name}) : '';
      // ignore: unnecessary_statements
      playlist_description != null ? form.addAll({'playlist_description': playlist_description}) : '';
      // ignore: unnecessary_statements
      songs != null ? form.addAll({'songs': songs}) : '';
      // ignore: unnecessary_statements
      art_url != null ? form.addAll({'art_url': await MultipartFile.fromFile(art_url, filename:art_url.split('/').last),}) : '';
      return true;
    } catch(e) {
      return false;
    }
  }

  Future<bool> addSong(String songId) async {
    final List<String> songsId = [];
    for (final Map<String, dynamic> json in songs) {
      songsId.add(json['_id']);
    }
    songsId.add(songId);
    return updatePlaylist(songs: songsId);
  }

  // ignore: sort_constructors_first
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
    final response = await GetIt.I.get<http.Client>().get(httpURI);
    if (response.statusCode == 200){
      const JsonDecoder decoder = JsonDecoder();
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