import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class SongModel {
  SongModel(this.id,
      this.songUrl,
      this.songName,
      this.songLyricUrl,
      this.artwork,
      this.artist,
      this.genre,
      );
  String id;
  String songUrl;
  String songName;
  String songLyricUrl;
  String artwork;
  String artist;
  String genre;
  // ignore: sort_constructors_first
  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
        json['song']['_id'],
        json['song_url'],
        json['song']['song_name'],
        json['lyricURL'],
        json['song']['album']['art_url'],
        json['song']['artist']['artist_name'],
        json['song']['album']['genre'] ?? '',
    );
  }

  static Future <SongModel> fetchSong(String id) async {
    final Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, port: SV_PORT, path: SONG_PATH, queryParameters: {
      '_id': id
    });
    final  response = await GetIt.I.get<http.Client>().get(httpURI);
    if (response.statusCode == 200){
      const JsonDecoder decoder = JsonDecoder();
      final SongModel song = SongModel.fromJson(decoder.convert(response.body));
      return song;
    } else {
      return Future.error('No song for Id($id)');
    }

  }
}
