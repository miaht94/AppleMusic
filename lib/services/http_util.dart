import 'package:apple_music/constant.dart';
import 'package:apple_music/models/UserModel.dart';
import 'package:apple_music/models_refactor/AlbumModel.dart';
import 'package:apple_music/models_refactor/PlaylistModel.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class HttpUtil {
  static final HttpUtil httpUtilSingleton = HttpUtil._internal();
  factory HttpUtil() {  
    return httpUtilSingleton;
  }
  HttpUtil._internal() {
    dio.httpClientAdapter = isTestingMode ? GetIt.I.get<HttpClientAdapter>() : DefaultHttpClientAdapter();
  }
  Dio dio = Dio(BaseOptions(baseUrl:'http://$SV_HOSTNAME/'));

  Future<UserModel?> fetchUserModel({required String app_token}) async {
    try {
      final Response<UserModel> userModelFuture = await dio.get('$MY_PROFILE_PATH', queryParameters: {
      'app_token': app_token
    });
    return userModelFuture.data;
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
}