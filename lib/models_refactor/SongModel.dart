
import 'package:apple_music/models_refactor/ArtistModel.dart';

class SongUrlModel{
  SongUrlModel({
    required this.song_url,
    required this.lyricURL,
    required this.song,
});

  String song_url;
  String lyricURL;
  SongModel song;

  // ignore: sort_constructors_first
  factory SongUrlModel.fromJson(Map<String,dynamic> json){
    return SongUrlModel(
        song_url: json['song_url'],
        lyricURL: json['lyricURL'],
        song: SongModel.fromJson(json['song']));
  }
}

class SongModel{
  SongModel({
    required this.id,
    required this.song_name,
    this.track_number,
    this.collaboration,
    required this.song_key,
    required this.lyric_key,
    required this.album,
    required this.artist,
  });

  String id;
  String song_name;
  int ? track_number;
  String ? collaboration;
  String song_key;
  String lyric_key;
  AlbumRawModel album;
  ArtistRawModel artist;

  // ignore: sort_constructors_first
  factory SongModel.fromJson(Map<String,dynamic> json) {
    final SongModel newSong = SongModel(
        id: json['_id'],
        song_name: json['song_name'],
        track_number: json['track_number'],
        collaboration: json['collaboration'],
        song_key: json['song_key'],
        lyric_key: json['lyric_key'],
        album: AlbumRawModel.fromJson(json['album']),
        artist: ArtistRawModel.fromJson(json['artist']));
    return newSong;
  }
}

class ArtistRawModel {

  ArtistRawModel({
    required this.id,
    required this.artist_name,
    required this.artist_description,
    this.highlight_song_id,
    this.top_song_list_id,
    required this.album_list_id,
    required this.artist_image_url,
    this.artist_video_url});

  String id;
  String artist_name;
  String artist_description;
  String? highlight_song_id;
  List<String>? top_song_list_id;
  List<String> album_list_id;
  String? artist_video_url;
  String artist_image_url;


  // ignore: sort_constructors_first
  factory ArtistRawModel.fromJson(Map<String, dynamic> json) {
    final ArtistRawModel newArtist = ArtistRawModel(
        id: json['_id'],
        artist_name: json['artist_name'],
        artist_description: json['artist_description'],
        album_list_id: (json['album_list'] as List).map((item) => item as String).toList(),
        artist_image_url: json['artist_image_url'],
        artist_video_url: json['artist_video_url'],
        top_song_list_id: (json['top_song_list'] as List).map((item) => item as String).toList(),
        highlight_song_id: json['highlight_song']);
    return newArtist;
  }
}
