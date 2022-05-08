import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:apple_music/models/UserModel.dart';
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

  Future<UserModel?> fetchUserModel(String appToken) async {
    try {
      final Response<UserModel> userModelFuture = await dio.get('$MY_PROFILE_PATH', queryParameters: {
      'app_token': appToken
    });
    return userModelFuture.data;
    } catch(e) {
      return null;
    } 
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

  Future<bool> UpdateFavorite({
    required FAVORITE_ACTION action,
    required String appToken,
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
      dynamic response = await dio.post(UPDATE_FAVORITE, data: formData, queryParameters: {'app_token': appToken});
      return true;
    }catch(e){
      print(e);
      return false;
    }

}

}

enum FAVORITE_ACTION{
  pop,push
}