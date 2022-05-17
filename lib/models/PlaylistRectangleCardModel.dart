import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class PlaylistRectangleCardModel {
  PlaylistRectangleCardModel(this._playlistId, this._playlistName, this._playlistDescription, this._artURL, this._songsId);
  String _playlistId;
  String _playlistName;
  String _playlistDescription;
  String _artURL;
  List<String> _songsId; 

  List<String> get songsId {
    if (kDebugMode) {
      print('SongsId get');
    }
    return _songsId;
  }

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

  // ignore: sort_constructors_first
  factory PlaylistRectangleCardModel.fromJson(Map<String, dynamic> json) {
    return PlaylistRectangleCardModel(json['_id'], json['playlist_name'], json['playlist_description'], json['art_url'], List<String>.from(json['songs']));
  }

    // ignore: non_constant_identifier_names
    Future<bool> updatePlaylist({String? playlist_name, String? playlist_description,List<String>? songs, String? art_url}) async {
    try {
      final Map<String, dynamic> form = {'_id': _playlistId};
      
      // ignore: unnecessary_statements
      playlist_name != null ? form.addAll({'playlist_name': playlist_name}) : '';
      // ignore: unnecessary_statements
      playlist_description != null ? form.addAll({'playlist_description': playlist_description}) : '';
      String temp = '';
      
      if (songs!=null) {
        songs = songs.map((e) => '"$e"').toList();
        temp = songs.join(',');
      }
      temp = '[$temp]' ;
      // ignore: unnecessary_statements
      songs != null ? form.addAll({'songs': temp}) : '';
      // ignore: unnecessary_statements
      art_url != null ? form.addAll({'art_url': await MultipartFile.fromFile(art_url, filename:art_url.split('/').last),}) : '';

      return true;
    } catch(e) {
      return false;
    }
  }

  Future<bool> addSong(String songId) async {
    List<String> songsId_ = [];
    // ignore: prefer_foreach
    for (final String i in songsId) {
      songsId_.add(i);
    }
    songsId_.add(songId);
    final Set<String> setId = Set.from(songsId_);
    songsId_ = setId.toList();
    final bool suc = await updatePlaylist(songs: songsId_);
    if (suc) {
      songsId.add(songId);
    }
    return suc;
  }

  Future<bool> removeSong(String songId) async {
    final List<String> songsId_ = [];
    // ignore: prefer_foreach
    for (final String i in songsId) {
      songsId_.add(i);
    }
    songsId_.removeWhere((item) => item == songId);
    final bool suc = await updatePlaylist(songs: songsId_);
    if (suc) {
      songsId.removeWhere((item) => item == songId);
    }
    return suc;
  }
}