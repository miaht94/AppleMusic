import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:apple_music/models_refactor/UserModel.dart';
import 'package:apple_music/models_refactor/AlbumModel.dart';
import 'package:apple_music/models_refactor/PlaylistModel.dart';
import 'package:apple_music/models_refactor/ArtistModel.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart'
as http;

class HttpUtil {
  static final HttpUtil httpUtilSingleton = HttpUtil._internal();
  factory HttpUtil() {  
    return httpUtilSingleton;
  }
  HttpUtil._internal() {
    dio.httpClientAdapter = isTestingMode ? GetIt.I.get<HttpClientAdapter>() : DefaultHttpClientAdapter();
  }
  Dio dio = Dio(BaseOptions(baseUrl: 'http://$SV_HOSTNAME/'));

  Future<UserModel?> fetchUserModel({required String app_token}) async {
    try {
      final Response userModelFuture = await dio.get('$MY_PROFILE_PATH', queryParameters: {
      'app_token': app_token
    });
    return UserModel.fromJson(userModelFuture.data);
    } catch(e) {
      return null;
    }
  }

  Future<AlbumModel?> getAlbumModel({String? id, String? album_name, String? artist_name, String? genre, String? album_year}) async {
    try {
      Map<String, String> params = {};
      id != null ? params.addAll({'_id': id}) : "";
      album_name != null ? params.addAll({'album_name': album_name}) : "";
      artist_name != null ? params.addAll({'artist_name': artist_name}) : "";
      genre != null ? params.addAll({'genre': genre}) : "";
      album_year != null ? params.addAll({'album_year': album_year}) : "";
      final Response albumModelFuture = await dio.get(
        '$ALBUM_PATH',
        queryParameters: params
      );
      return AlbumModel.fromJson(albumModelFuture.data);
    } catch(e) {
      return null;
    }
  }

  Future<List<AlbumModel>?> searchAlbumModel({String? id, String? album_name, String? artist_name, String? genre, String? album_year}) async {
    try {
      Map<String, String> params = {};
      id != null ? params.addAll({'_id': id}) : "";
      album_name != null ? params.addAll({'album_name': album_name}) : "";
      artist_name != null ? params.addAll({'artist_name': artist_name}) : "";
      genre != null ? params.addAll({'genre': genre}) : "";
      album_year != null ? params.addAll({'album_year': album_year}) : "";
      final Response albumsModelFuture = await dio.get(
        '$SEARCH_ALBUM_PATH',
        queryParameters: params
      );
      List<AlbumModel> res = [];
      for (Map<String, dynamic> i in albumsModelFuture.data) {
        res.add(AlbumModel.fromJson(i));
      }
      return res;
    } catch(e) {
      return null;
    }
  }

  Future<List<PlaylistModel>?> searchPlaylist({String? id, String? playlist_name, required bool public, required String app_token}) async {
    try {
      Map<String, String> params = {};
      id != null ? params.addAll({'_id': id}) : "";
      params.addAll({'app_token': app_token});
      playlist_name != null ? params.addAll({'playlist_name': playlist_name}) : "";
      params.addAll({'public': public ? "1" : "0"});
      final Response playlistModelFuture = await dio.get(
        '$SEARCH_PLAYLIST_PATH',
        queryParameters: params
      );
      List<PlaylistModel> res = [];
      for (Map<String, dynamic> i in playlistModelFuture.data) {
        res.add(PlaylistModel.fromJson(i));
      }
      return res;
    } catch (e) {
      return null;
    }
  }
  Future<PlaylistModel?> getPlaylistModel({String? id, String? playlist_name, required bool public, required String app_token}) async {
    try {
      Map<String, String> params = {};
      id != null ? params.addAll({'_id': id}) : "";
      params.addAll({'app_token': app_token});
      playlist_name != null ? params.addAll({'playlist_name': playlist_name}) : "";
      params.addAll({'public': public ? "1" : "0"});
      final Response playlistModelFuture = await dio.get(
        '$PLAYLIST_PATH',
        queryParameters: params
      );
      PlaylistModel newPlaylist = PlaylistModel.fromJson(playlistModelFuture.data);
      return newPlaylist;
    } catch (e) {
      return null;
    }
  }

  Future<bool> removeSongFromPlaylist({
    required String playlist_id,
    required String song_id,
    required String app_token,
  }) async {
    PlaylistModel? playlistModel = await getPlaylistModel(id : playlist_id, public: true, app_token: app_token);
    if (playlistModel != null) {
      int songIndex = -1;
      for(SongModel song in playlistModel.songs){
        if(song.id == song_id){
          songIndex = playlistModel.songs.indexOf(song);
          break;
        }
      }
      if(songIndex == -1){
        return false;
      } else {
        try{
          playlistModel.songs.removeAt(songIndex);
          Map<String,dynamic> body = {'_id': playlist_id};
          body.addAll({'songs': jsonEncode(playlistModel.songs.map((item) => item.id).toList())});
          FormData formData = FormData.fromMap(body);
          dynamic response = await dio.post(UPDATE_PLAYLIST, data: formData, queryParameters: {'app_token': app_token});
          return true;
        } catch(e) {
          print(e);
          return false;
        }
      }
      
    }
    return false;
  }

  Future<bool> addPlaylist({
    required String title,
    required String description,
    List<String>? songs,
    required String imagePath,
    required String app_token,
  }) async {
    try {
      Map<String, dynamic> form = {};
      form.addAll({'playlist_name': title});
      form.addAll({'playlist_description': description});
      songs != null ? form.addAll({'songs': songs}) : '';
      form.addAll({'art_url': await MultipartFile.fromFile(imagePath, filename:imagePath.split('/').last),});
      FormData formData = FormData.fromMap(form);
      dynamic response = await dio.post(ADD_PLAYLIST, data: formData, queryParameters: {'app_token': app_token});
      return true;
    } catch(e) {
      print(e);
      return false;
    }
  }

  Future<bool> deletePlaylist({required String id, required String app_token}) async {
    try{
      Map<String,String> params = {
        'app_token': app_token,
      };
      Map<String, dynamic> form = {
        '_id': id,
      };
      FormData formData = FormData.fromMap(form);
      dynamic response = await dio.delete(DELETE_PLAYLIST,  data: formData, queryParameters: params);
      return true;
    } catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> addSongToPlaylist({required String song_id, required String playlist_id, required String app_token}) async {
    PlaylistModel? playlistModel = await getPlaylistModel(id : playlist_id, public: true, app_token: app_token);
    if (playlistModel != null) {
        try{
          List<String> listSongsId = playlistModel.songs.map((item) => item.id).toList();
          listSongsId.add(song_id);
          Map<String,dynamic> body = {'_id': playlist_id};
          body.addAll({'songs': jsonEncode(listSongsId)});
          FormData formData = FormData.fromMap(body);
          dynamic response = await dio.post(UPDATE_PLAYLIST, data: formData, queryParameters: {'app_token': app_token});
          return true;
        } catch(e) {
          print(e);
          return false;
        }
      }
    return false;
  }

  Future<SongUrlModel?> fetchSongModel(String id) async {
    try {
      final response = await dio.get(SONG_PATH, queryParameters: {
        '_id': id
      });
      if (response.statusCode == 200){
        final SongUrlModel song = SongUrlModel.fromJson(response.data);
        return song;
      } else {
        return Future.error('No song for Id($id)');
      }
    } catch(e) {
      print(e);
      return null;
    }
  }

  Future<ArtistModel?> fetchArtistModel({String? id, String? artist_name}) async {
    try {
      Map<String,String> params = {};

      if(id != null) {
        params.addAll({'_id': id});
      }

      if(artist_name != null) {
        params.addAll({'artist_name': artist_name});
        print(artist_name);
      }

      final response = await dio.get(ARTIST_PATH,queryParameters :params );
      if (response.statusCode == 200){
        final ArtistModel artist = ArtistModel.fromJson(response.data);
        return artist;
      } else {
        return Future.error('No artist for Id($id)');
      }
    } catch(e) {
      print(e);
      return null;
    }
  }

  Future<List<SongModel?>?> searchSongModel({String? id,
    String? artist,
    String? album,
    String? song_name,
  }) async {
    try {
      Map<String,String> params = {};

      if(id != null){
        params.addAll({'_id': id});
      }

      if(artist != null){
        params.addAll({'artist': artist});
      }

      if(album != null){
        params.addAll({'album': album});
      }

      if(song_name != null){
        params.addAll({'song_name': song_name});
      }

      final response = await dio.get(SEARCH_SONG_PATH,queryParameters :params );
      List<SongModel> list = [];
      List<dynamic> jsonArray = response.data;
      for (Map<String, dynamic> i in jsonArray) {
        list.add(SongModel.fromJson(i));
      }
      return list;
    } catch(e) {
      print(e);
      return null;
    }
  }

  Future<List<ArtistModel?>?> searchArtistModel({String? id,
    String? artist_name
  }) async {
    try {
      Map<String,String> params = {};

      if(id != null){
        params.addAll({'_id': id});
      }

      if(artist_name != null){
        params.addAll({'artist_name': artist_name});
      }
      final response = await dio.get(SEARCH_ARTIST_PATH,queryParameters :params );
      List<ArtistModel> list = [];
      List<dynamic> jsonArray = response.data;
      for (Map<String, dynamic> i in jsonArray) {
        list.add(ArtistModel.fromJson(i));
      }
      return list;
    } catch(e) {
      print(e);
      return null;
    }
  }

  Future<bool> updateFavorite({
    required FAVORITE_ACTION action,
    required String app_token,
    List<String>? favorite_songs,
    List<String>? favorite_artists,
    List<String>? favorite_albums,
    })async {
    try{
      Map<String,dynamic> body = {};

      if(action == FAVORITE_ACTION.pop){
        body.addAll({'action': 'pop'});
      } else {
        body.addAll({'action': 'push'});
      }

      if(favorite_songs != null) {
        body.addAll({'favorite_songs':jsonEncode(favorite_songs)});
      }

      if(favorite_artists != null) {
        body.addAll({'favorite_artists':jsonEncode(favorite_artists)});
      }
      print(favorite_artists);
      if(favorite_albums != null) {
        body.addAll({'favorite_albums':jsonEncode(favorite_albums)});
      }

      FormData formData = FormData.fromMap(body);
      dynamic response = await dio.post(UPDATE_FAVORITE, data: formData, queryParameters: {'app_token': app_token});
      return true;
    }catch(e){
      print(e);
      return false;
    }

}
  Future<UserModel?> getUserModel({required String app_token}) async {
    try {
      Response res = await dio.get(MY_PROFILE_PATH, queryParameters: {
        'app_token': app_token
      });
      return UserModel.fromJson(res.data);
    } catch(e) {
      return null;
    }
  }
}

enum FAVORITE_ACTION{
  pop,push
}