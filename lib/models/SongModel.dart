import 'package:apple_music/constant.dart';
import 'package:apple_music/models/LyricModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SongModel {
  SongModel(this.id,
      this.songUrl,
      this.songName,
      this.songLyricUrl,
      this.artwork,
      this.artist,);
  String id;
  String songUrl;
  String songName;
  String songLyricUrl;
  String artwork;
  String artist;

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
        json['song']['_id'],
        json['song_url'],
        json['song']['song_name'],
        json['lyricURL'],
        json['song']['album']['art_url'],
        json['song']['artist']['artist_name'],
    );
  }

  static Future <SongModel> fetchSong(String id) async {
    Uri httpURI = Uri(scheme: "http", host: SV_HOSTNAME, port: SV_PORT, path: SONG_PATH, queryParameters: {
      '_id': id
    });
    final  response = await http.get(httpURI);
    JsonDecoder decoder = JsonDecoder();
    SongModel song = SongModel.fromJson(decoder.convert(response.body));
    return song;
  }
}
