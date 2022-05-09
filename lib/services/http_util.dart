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

  Future<bool> removeSongFromPlaylist({required String playlist_id, required String song_id}) async {
    return false;
  }

  Future<bool> addPlaylist({required String title, required String description, required String imagePath}) async {
    return false;
  }

  Future<bool> deletePlaylist({required String id}) async {
    return false;
  }

  Future<bool> addSongToPlaylist({required String song_id, required String playlist_id}) async {
    return false;
  }

  Future<SongUrlModel?> fetchSongModel(String id) async {
    try {
      final Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, port: SV_PORT, path: SONG_PATH, queryParameters: {
        '_id': id
      });
      final  response = await GetIt.I.get<http.Client>().get(httpURI);
      if (response.statusCode == 200){
        final JsonDecoder decoder = JsonDecoder();
        final SongUrlModel song = SongUrlModel.fromJson(decoder.convert(response.body));
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

      if(id != null){
        params.addAll({'_id': id});
      }

      if(artist_name != null){
        params.addAll({'artist_name': artist_name});
        print(artist_name);
      }

      final Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, port: SV_PORT, path: ARTIST_PATH, queryParameters: params);
      final  response = await GetIt.I.get<http.Client>().get(httpURI);
      if (response.statusCode == 200){
        final JsonDecoder decoder = const JsonDecoder();
        final ArtistModel artist = ArtistModel.fromJson(decoder.convert(response.body));
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

      Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, path: SEARCH_SONG_PATH, port: SV_PORT, queryParameters: params);
      dynamic res = await http.get(httpURI);
      List<SongModel> list = [];
      JsonDecoder decoder = const JsonDecoder();
      List<dynamic> jsonArray = decoder.convert(res.body);
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

      Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, path: SEARCH_ARTIST_PATH, port: SV_PORT, queryParameters: params);
      dynamic res = await http.get(httpURI);
      List<ArtistModel> list = [];
      JsonDecoder decoder = const JsonDecoder();
      List<dynamic> jsonArray = decoder.convert(res.body);
      for (Map<String, dynamic> i in jsonArray) {
        list.add(ArtistModel.fromJson(i));
      }
      return list;
    } catch(e) {
      print(e);
      return null;
    }
  }

}