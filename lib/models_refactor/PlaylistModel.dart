import 'package:apple_music/models_refactor/SongModel.dart';

class PlaylistModel {
  PlaylistModel({required this.id, required this.playlist_name, required this.art_url, required this.playlist_description, required this.songs, required this.public});
  String id;
  String playlist_name;
  String art_url;
  String playlist_description;
  List<SongModel> songs;
  bool public;
  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    List<SongModel> song_artist_pairs = [];
    for (Map<String, dynamic> i in json['songs']) {
      (i['song'] as Map<String, dynamic>).addAll({'artist': i['artist'], 'album': i['album']});
      song_artist_pairs.add(SongModel.fromJson(i['song']));
    }
    PlaylistModel newPlaylist = new PlaylistModel(
      id : json['_id'], 
      playlist_name : json['playlist_name'], 
      art_url : json['art_url'], 
      playlist_description : json['playlist_description'], 
      songs : song_artist_pairs, 
      public : json['public']);
    return newPlaylist;
  }
}


// class SongInPlaylistModel {
//   SongInPlaylistModel({required this.id, required this.song_name, required this.song_key, required this.lyric_key, this.collaboration, this.track_number});
//   String id;
//   String song_name;
//   int? track_number;
//   String? collaboration;
//   String? song_key;
//   String lyric_key;
//   factory SongInPlaylistModel.fromJson(Map<String, dynamic> json) {
//     SongInPlaylistModel newSong = SongInPlaylistModel(id: json['_id'], song_name: json['song_name'], song_key: json['song_key'], lyric_key: json['lyric_key'], collaboration: json['collaboration'], track_number: json['track_number']);
//     return newSong;
//   }
// }