import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models_refactor/ArtistModel.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart'
as http;
class UserModel {
  UserModel({required this.uid, required this.name, required this.avatarURL, required this.email, required this.playlists, required this.favorite_songs, required this.favorite_albums, required this.favorite_artists});
  String uid;
  String name;
  String avatarURL;
  String email;
  List<SongRawModel> favorite_songs;
  List<AlbumRawModel> favorite_albums;
  List<ArtistRawModel> favorite_artists;
  List<PlaylistInUserModel> playlists;
  bool containPlaylist(String id) {
    for (PlaylistInUserModel playlist in playlists) {
      if (playlist.id == id) return true;
    }
    return false;
  }
  bool containFavSong(String id) {
    for (SongRawModel song in favorite_songs) {
      if (song.id == id) return true;
    }
    return false;
  }
  bool containFavAlbum(String id) {
    for (AlbumRawModel album in favorite_albums) {
      if (album.id == id) return true;
    }
    return false;
  }
  bool containFavArtist(String id) {
    for (ArtistRawModel artist in favorite_artists) {
      if (artist.id == id) return true;
    }
    return false;
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> fav_songs_json = List<Map<String, dynamic>>.from(json['favorite_songs']);
    List <SongRawModel> list_fav_songs_obj = [];
    for (Map<String, dynamic> i in fav_songs_json) {
      list_fav_songs_obj.add(SongRawModel.fromJson(i));
    }

    List<Map<String, dynamic>> fav_albums_json = List<Map<String, dynamic>>.from(json['favorite_albums']);
    List <AlbumRawModel> list_fav_albums_obj = [];
    for (Map<String, dynamic> i in fav_albums_json) {
      list_fav_albums_obj.add(AlbumRawModel.fromJson(i));
    }

    List<Map<String, dynamic>> fav_artists_json = List<Map<String, dynamic>>.from(json['favorite_artists']);
    List <ArtistRawModel> list_fav_artists_obj = [];
    for (Map<String, dynamic> i in fav_artists_json) {
      list_fav_artists_obj.add(ArtistRawModel.fromJson(i));
    }

    List<Map<String, dynamic>> playlists_json = List<Map<String, dynamic>>.from(json['playlists']);
    List <PlaylistInUserModel> list_playlists_obj = [];
    for (Map<String, dynamic> i in playlists_json) {
      list_playlists_obj.add(PlaylistInUserModel.fromJson(i));
    }
    return UserModel(
      uid: json['_id'] ,
      name: json['name'], 
      avatarURL: json['avatarURL'], 
      email: json['email'], 
      playlists: list_playlists_obj, 
      favorite_songs: list_fav_songs_obj,
      favorite_albums: list_fav_albums_obj, 
      favorite_artists: list_fav_artists_obj
    );
  }
}

class PlaylistInUserModel {
  PlaylistInUserModel({required this.id, required this.playlist_name, required this.art_url, required this.playlist_description, required this.songsId, required this.public});
  String id;
  String playlist_name;
  String art_url;
  String playlist_description;
  List<String> songsId;
  bool public;
  factory PlaylistInUserModel.fromJson(Map<String, dynamic> json) {
    PlaylistInUserModel newPlaylist = new PlaylistInUserModel(
      id : json['_id'], 
      playlist_name : json['playlist_name'], 
      art_url : json['art_url'], 
      playlist_description : json['playlist_description'], 
      songsId : List<String>.from(json['songs']), 
      public : json['public']);
    return newPlaylist;
  }
}

class SongRawModel {
  SongRawModel({
    required this.id,
    required this.song_name,
    this.track_number,
    this.collaboration,
    required this.song_key,
    required this.lyric_key,
  });

  String id;
  String song_name;
  int? track_number;
  String? collaboration;
  String song_key;
  String lyric_key;
  factory SongRawModel.fromJson(Map<String, dynamic> json) {
    SongRawModel newSong = SongRawModel(
        id: json['_id'],
        song_name: json['song_name'],
        song_key: json['song_key'],
        lyric_key: json['lyric_key'],
        track_number: json['track_number'],
        collaboration: json['collaboration'],
        // album: AlbumRawModel.fromJson(json['album']),
    );
    return newSong;
  }
}

// class ArtistInUserModel {

//   String id;
//   String artist_name;
//   String artist_description;
//   String? highlight_song_id;
//   List<String> top_song_list;
//   List<String> album_list;
//   String? artist_video_url;
//   String artist_image_url;

//   ArtistInUserModel({required this.id, required this.artist_name, required this.artist_description, this.highlight_song_id, required this.top_song_list, required this.album_list, required this.artist_image_url, this.artist_video_url});
//   factory ArtistInUserModel.fromJson(Map<String, dynamic> json) {
//     ArtistInUserModel newArtist = ArtistInUserModel(
//       id: json['_id'], 
//       artist_name: json['artist_name'], 
//       artist_description: json['artist_description'], 
//       album_list: List<String>.from(json['album_list']), 
//       artist_image_url: json['artist_image_url'], 
//       artist_video_url: json['artist_video_url'], 
//       top_song_list: List<String>.from(json['top_song_list']), 
//       highlight_song_id: json['highlight_song']
//     );
//     return newArtist;
//   }
// }

// class AlbumInUserModel {
//   AlbumInUserModel({required this.id, required this.album_name, required this.genre, required this.album_year, required this.art_url, required this.songsId});
//   String id;
//   String album_name;
//   String genre;
//   String art_url;
//   int album_year;
//   List<String> songsId;
//   factory AlbumInUserModel.fromJson(Map<String, dynamic> json) {
//       AlbumInUserModel newAlbum = AlbumInUserModel(id: json['_id'], album_name: json['album_name'], genre: json['genre'], album_year: json['album_year'], art_url: json['art_url'], songsId: List<String>.from(json['songs']));
//       return newAlbum;
//   }
// }
class UserModelNotifier extends ValueNotifier<UserModel> {
  UserModelNotifier(UserModel value) : super(value);
  Future<bool> refreshUser() async {
    UserModel? newUserModel = await HttpUtil().getUserModel(app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken);
    if (newUserModel != null) {
      value = newUserModel;
      notifyListeners();
      return true;
    }
    return false;
  }
}
//   
//   Future<bool> addPlaylist(String playlist_name, String playlist_description, String art_url) async {
//     try {
//       Dio dio = Dio(BaseOptions(baseUrl: 'http://' + SV_HOSTNAME + '/'));
//       String fileName = art_url.split('/').last;
//       FormData formData = FormData.fromMap({
//           'art_url':
//               await MultipartFile.fromFile(art_url, filename:fileName),
//           'playlist_name': playlist_name,
//           'playlist_description': playlist_description,
//           'songs': []
//       });
//       dynamic response = await dio.post(ADD_PLAYLIST, data: formData, queryParameters: {'app_token': GetIt.I.get<CredentialModelNotifier>().value.appToken});
//       await refreshUser();
//       return true;
//     } catch(e) {
//       return false;
//     }
//   }

//   Future<bool> deletePlaylist(String playlistId) async {
//     try {
//       Dio dio = Dio(BaseOptions(baseUrl:'http://' + SV_HOSTNAME + '/'));
//       FormData formData = FormData.fromMap({
//           '_id': playlistId
//       });
//       dynamic response = await dio.delete(DELETE_PLAYLIST, data: formData, queryParameters: {'app_token': GetIt.I.get<CredentialModelNotifier>().value.appToken});
//       await refreshUser();
//       return true;
//     } catch(e) {
//       return false;
//     }
//   }

//   Future<bool> updateFavorite({List<String>? favSongsId, List<String>? favAlbumsId, List<String>? favArtistsId, required String action}) async {
//     try {
//     Dio dio = Dio(BaseOptions(baseUrl:'http://' + SV_HOSTNAME + '/'));
//     Map<String, dynamic> params = {'action': action};
//     if (favSongsId != null) {
//       params.addAll({'favorite_songs': jsonEncode(favSongsId)});
//     }
//     if (favAlbumsId != null) {
//       params.addAll({'favorite_albums': jsonEncode(favAlbumsId)});
//     }
//     if (favArtistsId != null) {
//       params.addAll({'favorite_artists': jsonEncode(favArtistsId)});
//     }
//     FormData formData = FormData.fromMap(
//         params
//     );
//     Response response = await dio.post(UPDATE_FAVORITE, data: formData, queryParameters: {'app_token': GetIt.I.get<CredentialModelNotifier>().value.appToken});
//     refreshUser();
//     notifyListeners();
//     return true;
//     }
//     catch (e) {
//       return false;
//     }
//   }
// }