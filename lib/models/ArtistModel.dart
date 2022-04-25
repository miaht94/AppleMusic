import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:http/http.dart' as http;

class ArtistModel{
  ArtistModel(
      this.id,
      this.name,
      this.description,
      this.highlightSong,
      this.topSongList,
      this.albumList,
      this.imageUrl,
      );
  String id;
  String name;
  String description;
  String highlightSong;
  List<dynamic> topSongList;
  List<dynamic> albumList;
  String imageUrl;


  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      json['_id'],
      json['artist_name'],
      json['artist_description'],
      (json['highlight_song'] != null) ? json['highlight_song']['_id'] : "",
      json['top_song_list'] ?? [],
      json['album_list'] ?? [],
      json['artist_image_url'],
    );
  }

  static Future<ArtistModel> fetchArtist(String id) async{
    final Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, port: SV_PORT, path: ARTIST_PATH, queryParameters: {
      '_id': id
    });
    final  response = await http.get(httpURI);
    if (response.statusCode == 200){
      final JsonDecoder decoder = const JsonDecoder();
      final ArtistModel song = ArtistModel.fromJson(decoder.convert(response.body));
      return song;
    } else {
      return Future.error('No artist for Id($id)');
    }
  }
}