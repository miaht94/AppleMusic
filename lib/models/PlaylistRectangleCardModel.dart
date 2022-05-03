import 'package:apple_music/constant.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class PlaylistRectangleCardModel {
  PlaylistRectangleCardModel(this._playlistId, this._playlistName, this._playlistDescription, this._artURL, this.songsId);
  String _playlistId;
  String _playlistName;
  String _playlistDescription;
  String _artURL;
  List<String> songsId;
  String get playlistId {
    return _playlistId;
  }

  String get playlistName {
    return _playlistName;
  }

  String get artURL {
    return _artURL;
  }

  String get playlistDescription {
    return _playlistDescription;
  }

  factory PlaylistRectangleCardModel.fromJson(Map<String, dynamic> json) {
    return PlaylistRectangleCardModel(json["_id"], json["playlist_name"], json["playlist_description"], json["art_url"], List<String>.from(json["songs"]));
  }

    Future<bool> updatePlaylist({String? playlist_name, String? playlist_description,List<String>? songs, String? art_url}) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: 'http://' + SV_HOSTNAME + '/'));
      Map<String, dynamic> form = {'_id': this._playlistId};
      
      playlist_name != null ? form.addAll({'playlist_name': playlist_name}) : '';
      playlist_description != null ? form.addAll({'playlist_description': playlist_description}) : '';
      String temp = "";
      
      if (songs!=null) {
        songs = songs.map((e) => "\"" + e + "\"").toList();
        temp = songs.join(",");
      }
      temp = "[" + temp + "]" ;
      songs != null ? form.addAll({'songs': temp}) : '';
      art_url != null ? form.addAll({'art_url': await MultipartFile.fromFile(art_url, filename:art_url.split('/').last),}) : '';
      FormData formData = FormData.fromMap(form);
      dynamic response = await dio.post(UPDATE_PLAYLIST, data: formData, queryParameters: {'app_token': GetIt.I.get<CredentialModelNotifier>().value.appToken});
      return true;
    } catch(e) {
      return false;
    }
  }

  Future<bool> addSong(String songId) async {
    List<String> songsId = [];
    for (String i in this.songsId) {
      songsId.add(i);
    }
    songsId.add(songId);
    return updatePlaylist(songs: songsId);
  }
}