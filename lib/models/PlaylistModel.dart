import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

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