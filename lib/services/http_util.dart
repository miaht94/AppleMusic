import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:apple_music/models/LyricModel.dart';
import 'package:apple_music/models_refactor/AlbumModel.dart';
import 'package:apple_music/models_refactor/ArtistModel.dart';
import 'package:apple_music/models_refactor/PlaylistModel.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:apple_music/models_refactor/UserModel.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class HttpUtil {
  static final HttpUtil httpUtilSingleton = HttpUtil._internal();
  // ignore: sort_constructors_first
  factory HttpUtil() {
    return httpUtilSingleton;
  }

  // ignore: sort_constructors_first
  HttpUtil._internal() {
    dio.httpClientAdapter = isTestingMode ? GetIt.I.get<HttpClientAdapter>() : DefaultHttpClientAdapter();
  }
  Dio dio = Dio(BaseOptions(baseUrl: 'http://$SV_HOSTNAME/'));
  void refresh() {
    dio.httpClientAdapter = isTestingMode ? GetIt.I.get<HttpClientAdapter>() : DefaultHttpClientAdapter();
  }
  Future<UserModel?> fetchUserModel({required String app_token}) async {
    try {
      // ignore: strict_raw_type
      final Response userModelFuture = await dio.get(MY_PROFILE_PATH, queryParameters: {
      'app_token': app_token
    });
    return UserModel.fromJson(userModelFuture.data);
    } catch(e) {
      return null;
    }
  }

  Future<AlbumModel?> getAlbumModel({String? id, String? album_name, String? artist_name, String? genre, String? album_year}) async {
    try {
      final Map<String, String> params = {};
      // ignore: unnecessary_statements
      id != null ? params.addAll({'_id': id}) : '';
      // ignore: unnecessary_statements
      album_name != null ? params.addAll({'album_name': album_name}) : '';
      // ignore: unnecessary_statements
      artist_name != null ? params.addAll({'artist_name': artist_name}) : '';
      // ignore: unnecessary_statements
      genre != null ? params.addAll({'genre': genre}) : '';
      // ignore: unnecessary_statements
      album_year != null ? params.addAll({'album_year': album_year}) : '';
      // ignore: strict_raw_type
      final Response albumModelFuture = await dio.get(
        ALBUM_PATH,
        queryParameters: params
      );
      return AlbumModel.fromJson(albumModelFuture.data);
    } catch(e) {
      return AlbumModel(genre: '', art_url: '', album_year: 2008, id: '', album_name: 'AlbumError', artist: ArtistRawModel(artist_image_url: '', artist_name: '', id: '', artist_description: '', album_list_id: []), songs: []);
    }
  }

  Future<List<AlbumModel>?> searchAlbumModel({String? id, String? album_name, String? artist_name, String? genre, String? album_year}) async {
    try {
      final Map<String, String> params = {};
      // ignore: unnecessary_statements
      id != null ? params.addAll({'_id': id}) : '';
      // ignore: unnecessary_statements
      album_name != null ? params.addAll({'album_name': album_name}) : '';
      // ignore: unnecessary_statements
      artist_name != null ? params.addAll({'artist_name': artist_name}) : '';
      // ignore: unnecessary_statements
      genre != null ? params.addAll({'genre': genre}) : '';
      // ignore: unnecessary_statements
      album_year != null ? params.addAll({'album_year': album_year}) : '';
      // ignore: strict_raw_type
      final Response albumsModelFuture = await dio.get(
        SEARCH_ALBUM_PATH,
        queryParameters: params
      );
      final List<AlbumModel> res = [];
      for (final Map<String, dynamic> i in albumsModelFuture.data) {
        res.add(AlbumModel.fromJson(i));
      }
      return res;
    } catch(e) {
      return null;
    }
  }

  Future<List<LyricModel>> fetchLyrics(String url) async {
    // ignore: inference_failure_on_function_invocation
    final response = await dio.getUri(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.data);
      if (response.data != null) {
        if (kDebugMode) {
          print('fetch lyric');
        }
        data.sort((a, b){
          return a['timestamp'].compareTo(b['timestamp']);
        });
        return data.map((item) => LyricModel.fromJson(item)).toList();
      }
      // return list;
    } else {

      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
    return [];
  }

  Future<List<PlaylistModel>?> searchPlaylist({String? id, String? playlist_name, required bool public, required String app_token}) async {
    try {
      final Map<String, String> params = {};
      // ignore: unnecessary_statements
      id != null ? params.addAll({'_id': id}) : '';
      params.addAll({'app_token': app_token});
      // ignore: unnecessary_statements
      playlist_name != null ? params.addAll({'playlist_name': playlist_name}) : '';
      params.addAll({'public': public ? '1' : '0'});
      // ignore: strict_raw_type
      final Response playlistModelFuture = await dio.get(
        SEARCH_PLAYLIST_PATH,
        queryParameters: params
      );
      final List<PlaylistModel> res = [];
      for (final Map<String, dynamic> i in playlistModelFuture.data) {
        res.add(PlaylistModel.fromJson(i));
      }
      return res;
    } catch (e) {
      return null;
    }
  }
  Future<PlaylistModel?> getPlaylistModel({String? id, String? playlist_name, required bool public, required String app_token}) async {
    try {
      final Map<String, String> params = {};
      // ignore: unnecessary_statements
      id != null ? params.addAll({'_id': id}) : '';
      params.addAll({'app_token': app_token});
      // ignore: unnecessary_statements
      playlist_name != null ? params.addAll({'playlist_name': playlist_name}) : '';
      params.addAll({'public': public ? '1' : '0'});
      // ignore: strict_raw_type
      final Response playlistModelFuture = await dio.get(
        PLAYLIST_PATH,
        queryParameters: params
      );
      final PlaylistModel newPlaylist = PlaylistModel.fromJson(playlistModelFuture.data);
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
    final PlaylistModel? playlistModel = await getPlaylistModel(id : playlist_id, public: true, app_token: app_token);
    if (playlistModel != null) {
      int songIndex = -1;
      for(final SongModel song in playlistModel.songs){
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
          final Map<String,dynamic> body = {'_id': playlist_id};
          // ignore: cascade_invocations
          body.addAll({'songs': jsonEncode(playlistModel.songs.map((item) => item.id).toList())});
          final FormData formData = FormData.fromMap(body);
          // ignore: inference_failure_on_function_invocation
          await dio.post(UPDATE_PLAYLIST, data: formData, queryParameters: {'app_token': app_token});
          return true;
        } catch(e) {
          if (kDebugMode) {
            print(e);
          }
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
      final Map<String, dynamic> form = {};
      // ignore: cascade_invocations
      form.addAll({'playlist_name': title});
      // ignore: cascade_invocations
      form.addAll({'playlist_description': description});
      // ignore: unnecessary_statements
      songs != null ? form.addAll({'songs': songs}) : '';
      form.addAll({'art_url': await MultipartFile.fromFile(imagePath, filename:imagePath.split('/').last),});
      final FormData formData = FormData.fromMap(form);
      // ignore: inference_failure_on_function_invocation
      await dio.post(ADD_PLAYLIST, data: formData, queryParameters: {'app_token': app_token});
      return true;
    } catch(e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<bool> deletePlaylist({required String id, required String app_token}) async {
    try{
      final Map<String,String> params = {
        'app_token': app_token,
      };
      final Map<String, dynamic> form = {
        '_id': id,
      };
      final FormData formData = FormData.fromMap(form);
      // ignore: inference_failure_on_function_invocation
      await dio.delete(DELETE_PLAYLIST,  data: formData, queryParameters: params);
      return true;
    } catch(e){
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }


  Future<bool> addSongToPlaylist({required String song_id, required String playlist_id, required String app_token}) async {
    final PlaylistModel? playlistModel = await getPlaylistModel(id : playlist_id, public: true, app_token: app_token);
    if (playlistModel != null) {
        try{
          final List<String> listSongsId = playlistModel.songs.map((item) => item.id).toList();
          // ignore: cascade_invocations
          listSongsId.add(song_id);
          final Map<String,dynamic> body = {'_id': playlist_id};
          // ignore: cascade_invocations
          body.addAll({'songs': jsonEncode(listSongsId)});
          final FormData formData = FormData.fromMap(body);
          // ignore: inference_failure_on_function_invocation
          await dio.post(UPDATE_PLAYLIST, data: formData, queryParameters: {'app_token': app_token});
          return true;
        } catch(e) {
          if (kDebugMode) {
            print(e);
          }
          return false;
        }
      }
    return false;
  }

  Future<bool> addListSongToPlaylist({required List<String> songs_id, required String playlist_id, required String app_token}) async {
    final PlaylistModel? playlistModel = await getPlaylistModel(id : playlist_id, public: true, app_token: app_token);
    if (playlistModel != null) {
        try{
          List<String> listSongsId = playlistModel.songs.map((item) => item.id).toList();
          // ignore: cascade_invocations
          listSongsId.addAll(songs_id);
          listSongsId = listSongsId.toSet().toList();
          final Map<String,dynamic> body = {'_id': playlist_id};
          // ignore: cascade_invocations
          body.addAll({'songs': jsonEncode(listSongsId)});
          final FormData formData = FormData.fromMap(body);
          // ignore: inference_failure_on_function_invocation
          await dio.post(UPDATE_PLAYLIST, data: formData, queryParameters: {'app_token': app_token});
          return true;
        } catch(e) {
          if (kDebugMode) {
            print(e);
          }
          return false;
        }
      }
    return false;
  }

  Future<SongUrlModel?> fetchSongModel(String id) async {
    try {
      // ignore: inference_failure_on_function_invocation
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
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<ArtistModel?> fetchArtistModel({String? id, String? artist_name}) async {
    try {
      final Map<String,String> params = {};

      if(id != null) {
        params.addAll({'_id': id});
      }

      if(artist_name != null) {
        params.addAll({'artist_name': artist_name});
        if (kDebugMode) {
          print(artist_name);
        }
      }

      // ignore: inference_failure_on_function_invocation
      final response = await dio.get(ARTIST_PATH,queryParameters :params );
      if (response.statusCode == 200){
        final ArtistModel artist = ArtistModel.fromJson(response.data);
        return artist;
      } else {
        return ArtistModel(artist_image_url: '', artist_name: 'ArtistError', id: '', artist_description: '', album_list: []);
      }
    } catch(e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<List<SongModel?>?> searchSongModel({String? id,
    String? artist,
    String? album,
    String? song_name,
  }) async {
    try {
      final Map<String,String> params = {};

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

      // ignore: inference_failure_on_function_invocation
      final response = await dio.get(SEARCH_SONG_PATH,queryParameters :params );
      final List<SongModel> list = [];
      final List<dynamic> jsonArray = response.data;
      for (final Map<String, dynamic> i in jsonArray) {
        list.add(SongModel.fromJson(i));
      }
      return list;
    } catch(e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<List<ArtistModel?>?> searchArtistModel({String? id,
    String? artist_name
  }) async {
    try {
      final Map<String,String> params = {};

      if(id != null){
        params.addAll({'_id': id});
      }

      if(artist_name != null){
        params.addAll({'artist_name': artist_name});
      }
      // ignore: inference_failure_on_function_invocation
      final response = await dio.get(SEARCH_ARTIST_PATH,queryParameters :params );
      final List<ArtistModel> list = [];
      final List<dynamic> jsonArray = response.data;
      for (final Map<String, dynamic> i in jsonArray) {
        list.add(ArtistModel.fromJson(i));
      }
      return list;
    } catch(e) {
      if (kDebugMode) {
        print(e);
      }
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
      final Map<String,dynamic> body = {};

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
      if (kDebugMode) {
        print(favorite_artists);
      }
      if(favorite_albums != null) {
        body.addAll({'favorite_albums':jsonEncode(favorite_albums)});
      }

      final FormData formData = FormData.fromMap(body);
      // ignore: inference_failure_on_function_invocation
      await dio.post(UPDATE_FAVORITE, data: formData, queryParameters: {'app_token': app_token});
      return true;
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      return false;
    }

}
  Future<UserModel?> getUserModel({required String app_token}) async {
    try {
      // ignore: strict_raw_type
      final Response res = await dio.get(MY_PROFILE_PATH, queryParameters: {
        'app_token': app_token
      });
      return UserModel.fromJson(res.data);
    } catch(e) {
      return null;
    }
  }

  Future<bool> updateProfile({String? name, String? avtPath, required String app_token}) async {
    final Map<String, dynamic> form = {};
    // ignore: unnecessary_statements
    name != null ? form.addAll({'name': name}) : '';
    if (avtPath != null) {
      form.addAll({'avatarURL': await MultipartFile.fromFile(avtPath, filename:avtPath.split('/').last),});
    }
    final FormData formData = FormData.fromMap(form);
    // ignore: inference_failure_on_function_invocation
    await dio.post(UPDATE_PROFILE, data: formData, queryParameters: {'app_token': app_token});
    return true;
  }

  // ignore: inference_failure_on_untyped_parameter
  Future<bool> updatePlaylist({required String id, String? playlist_name, String? playlist_description, String? imagePath, required app_token}) async {
    final Map<String, dynamic> form = {};
    // Dio dio_ = Dio(BaseOptions(baseUrl: 'http://localhost:3000/'));
    // ignore: cascade_invocations
    form.addAll({'_id': id});
    // ignore: unnecessary_statements
    playlist_name != null ? form.addAll({'playlist_name': playlist_name}) : '';
    // ignore: unnecessary_statements
    playlist_description != null ? form.addAll({'playlist_description': playlist_description}) : '';
    if (imagePath != null) {
      form.addAll({'art_url': await MultipartFile.fromFile(imagePath, filename:imagePath.split('/').last),});
    }
    final FormData formData = FormData.fromMap(form);
    // ignore: inference_failure_on_function_invocation
    await dio.post(UPDATE_PLAYLIST, data: formData, queryParameters: {'app_token': app_token});
    return true;
  }

  Future<List<SongModel>?> getFavoriteSongList({required String app_token}) async {
    try {
      // ignore: strict_raw_type
      final Response res = await dio.get(MY_PROFILE_PATH, queryParameters: {
        'app_token': app_token
      });
      if (kDebugMode) {
        print(res);
      }
      final List<SongModel> list = [];
      for (final Map<String, dynamic> i in res.data['favorite_songs']) {
          i.addAll({'artist': i['artist'], 'album': i['album']});
          if (kDebugMode) {
            print(i);
          }
          list.add(SongModel.fromJson(i));
      }
      if (kDebugMode) {
        print(list[0]);
      }
      return list;
    } catch(e) {
      return null;
    }
  }

  Future<List<AlbumModel>?> getFavoriteAlbumList({required String app_token}) async {
    try {
      // ignore: strict_raw_type
      final Response res = await dio.get(MY_PROFILE_PATH, queryParameters: {
        'app_token': app_token
      });
      final List<AlbumModel> list = [];
      for (final Map<String, dynamic> i in res.data['favorite_albums']) {
        if (kDebugMode) {
          print(i);
        }
        list.add(AlbumModel.fromJson(i));
      }
      return list;
    } catch(e) {
      return null;
    }


  }

  Future<List<ArtistModel>?> getFavoriteArtistList({required String app_token}) async {
    try {
      // ignore: strict_raw_type
      final Response res = await dio.get(MY_PROFILE_PATH, queryParameters: {
        'app_token': app_token
      });
      final List<ArtistModel> list = [];
      for (final Map<String, dynamic> i in res.data['favorite_artists']) {
        list.add(ArtistModel.fromJson(i));
      }
      return list;
    } catch (e) {
      return null;
    }
  }

  Future<List<PlaylistModel>?> getMyPlaylists({required String app_token}) async {
    try {
      // ignore: strict_raw_type
      final Response res = await dio.get(MY_PROFILE_PATH, queryParameters: {
        'app_token': app_token
      });
      final List<PlaylistModel> list = [];
      for (final Map<String, dynamic> i in res.data['playlists']) {
        list.add(PlaylistModel.fromJson(i));
      }
      return list;
    } catch (e) {
      return null;
    }
  }
}

enum FAVORITE_ACTION{
  pop,push
}